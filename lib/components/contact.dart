import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';

class Contact extends StatelessComponent {
  const Contact({required this.profile, super.key});

  final Profile profile;

  @override
  Component build(BuildContext context) {
    return footer(id: 'contact', classes: 'contact', [
      div(classes: 'section contact-in', [
        div(classes: 'contact-card reveal', [
          span(classes: 'contact-eyebrow', [.text('// contact')]),
          h2([.text('Let\'s ship something together')]),
          p([.text('Have an app idea, a role, or just want to talk mobile? My inbox is open.')]),
          a(classes: 'btn btn-primary contact-btn', href: 'mailto:${profile.email}', [
            const Icon('mail', size: 18),
            .text(profile.email),
          ]),
          div(classes: 'contact-socials', [
            for (final MapEntry(key: name, value: url) in profile.socials.entries)
              a(href: url, target: .blank, [.text(name)]),
          ]),
        ]),
        div(classes: 'foot-note', [
          span([.text('© ${DateTime.now().year} ${profile.name}')]),
          span(classes: 'foot-built', [.text('Built with Jaspr (Dart) — content in markdown')]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.contact', [
      css('&').styles(
        border: .only(top: BorderSide.solid(color: Color('#232C4A66'), width: 1.px)),
        raw: {
          'background':
              'radial-gradient(60% 80% at 50% 100%, #7C8CFF14 0%, transparent 70%), radial-gradient(40% 60% at 80% 100%, #22D3EE10 0%, transparent 70%)',
        },
      ),
      css('.contact-card').styles(
        display: .flex,
        flexDirection: .column,
        alignItems: .center,
        textAlign: .center,
      ),
      css('.contact-eyebrow').styles(
        color: T.accent2,
        fontFamily: T.mono,
        fontSize: 0.88.rem,
      ),
      css('h2').styles(
        maxWidth: .expression('22ch'),
        margin: .only(top: 0.8.rem),
        fontFamily: T.display,
        fontWeight: .w800,
        lineHeight: 1.15.em,
        raw: {'font-size': 'clamp(2rem, 5vw, 3.2rem)'},
      ),
      css('p').styles(
        maxWidth: 34.rem,
        margin: .only(top: 1.2.rem),
        color: T.muted,
        fontSize: 1.05.rem,
        lineHeight: 1.75.em,
      ),
      css('.contact-btn').styles(
        margin: .only(top: 2.2.rem),
      ),
      css('.contact-socials', [
        css('&').styles(
          display: .flex,
          margin: .only(top: 2.rem),
          flexWrap: .wrap,
          justifyContent: .center,
          gap: .all(1.6.rem),
        ),
        css('a').styles(
          transition: Transition('color', duration: 200.ms),
          color: T.faint,
          fontFamily: T.mono,
          fontSize: 0.85.rem,
        ),
        css('a:hover').styles(
          color: T.accent2,
        ),
      ]),
      css('.foot-note').styles(
        display: .flex,
        margin: .only(top: 5.rem),
        flexWrap: .wrap,
        justifyContent: .spaceBetween,
        gap: .all(0.5.rem),
        color: T.faint,
        fontSize: 0.82.rem,
      ),
      css('.foot-built').styles(
        fontFamily: T.mono,
      ),
    ]),
  ];
}
