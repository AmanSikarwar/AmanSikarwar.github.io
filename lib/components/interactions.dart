import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// The one JS island on the page. Renders nothing; wires up:
/// - scroll-reveal (.reveal -> .visible via IntersectionObserver, staggered)
/// - nav scroll-spy (.nav-link.active)
/// - mobile menu toggle (html.menu-open)
@client
class Interactions extends StatefulComponent {
  const Interactions({super.key});

  @override
  State<Interactions> createState() => _InteractionsState();
}

class _InteractionsState extends State<Interactions> {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    final doc = web.document;
    // Gate .reveal hiding on JS actually running (no-JS visitors see everything).
    doc.body!.classList.add('js');

    // Scroll reveal: each observer batch gets a small stagger.
    final revealObserver = web.IntersectionObserver(
      (JSArray<web.IntersectionObserverEntry> entries, web.IntersectionObserver observer) {
        for (final (i, entry) in entries.toDart.indexed) {
          if (!entry.isIntersecting) continue;
          final el = entry.target as web.HTMLElement;
          el.style.transitionDelay = '${(i % 6) * 70}ms';
          el.classList.add('visible');
          observer.unobserve(el);
        }
      }.toJS,
      web.IntersectionObserverInit(rootMargin: '0px 0px -8% 0px'),
    );
    final reveals = doc.querySelectorAll('.reveal');
    for (var i = 0; i < reveals.length; i++) {
      revealObserver.observe(reveals.item(i) as web.Element);
    }

    // Scroll spy: highlight the nav link of the section in view.
    final spyObserver = web.IntersectionObserver(
      (JSArray<web.IntersectionObserverEntry> entries, web.IntersectionObserver _) {
        for (final entry in entries.toDart) {
          if (!entry.isIntersecting) continue;
          final id = entry.target.id;
          final links = doc.querySelectorAll('.nav-link');
          for (var i = 0; i < links.length; i++) {
            final link = links.item(i) as web.Element;
            link.classList.toggle('active', link.getAttribute('href') == '#$id');
          }
        }
      }.toJS,
      web.IntersectionObserverInit(rootMargin: '-40% 0px -55% 0px'),
    );
    final sections = doc.querySelectorAll('section[id], footer[id]');
    for (var i = 0; i < sections.length; i++) {
      spyObserver.observe(sections.item(i) as web.Element);
    }

    // Mobile menu.
    final root = doc.documentElement!;
    final burger = doc.querySelector('.nav-burger');
    if (burger != null) {
      web.EventStreamProviders.clickEvent.forTarget(burger).listen((_) {
        root.classList.toggle('menu-open');
      });
    }
    final menuLinks = doc.querySelectorAll('.nav-menu a');
    for (var i = 0; i < menuLinks.length; i++) {
      web.EventStreamProviders.clickEvent.forTarget(menuLinks.item(i) as web.Element).listen((_) {
        root.classList.remove('menu-open');
      });
    }

    // Contact form: submit via fetch and show inline status instead of
    // navigating away. Plain HTML POST still works if this never runs.
    final formEl = doc.querySelector('form.cform') as web.HTMLFormElement?;
    if (formEl != null) {
      final status = doc.querySelector('.cform-status') as web.HTMLElement?;
      final send = doc.querySelector('.cform-send') as web.HTMLButtonElement?;
      web.EventStreamProviders.submitEvent.forTarget(formEl).listen((web.Event e) async {
        e.preventDefault();
        send?.disabled = true;
        status?.className = 'cform-status';
        try {
          final resp = await web.window
              .fetch(
                formEl.action.toJS,
                web.RequestInit(
                  method: 'POST',
                  headers: {'Accept': 'application/json'}.jsify()! as JSObject,
                  body: web.FormData(formEl),
                ),
              )
              .toDart;
          if (!resp.ok) throw Exception('HTTP ${resp.status}');
          formEl.reset();
          status?.textContent = "Message sent — I'll get back to you soon.";
          status?.className = 'cform-status ok';
        } catch (_) {
          status?.textContent = 'Something went wrong — please use the email link below.';
          status?.className = 'cform-status err';
        }
        send?.disabled = false;
      });
    }
  }

  @override
  Component build(BuildContext context) => .empty();
}
