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
  }

  @override
  Component build(BuildContext context) => .empty();
}
