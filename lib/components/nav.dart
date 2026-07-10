import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../styles/theme.dart';

class Nav extends StatelessComponent {
  const Nav({required this.email, super.key});

  final String email;

  static const _links = ['about', 'experience', 'projects', 'skills'];

  @override
  Component build(BuildContext context) {
    return header(classes: 'nav', [
      div(classes: 'nav-in', [
        a(classes: 'brand', href: '#top', [
          div(classes: 'brand-mark', [.text('AS')]),
          span(classes: 'brand-name', [.text('Aman Sikarwar')]),
        ]),
        nav(classes: 'nav-links', [
          for (final l in _links) a(classes: 'nav-link', href: '#$l', [.text(l)]),
        ]),
        a(classes: 'nav-cta', href: 'mailto:$email', [.text('Get in touch')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.nav', [
      css('&').styles(
        position: .fixed(top: 0.px, left: 0.px, right: 0.px),
        zIndex: ZIndex(100),
        border: .only(bottom: BorderSide.solid(color: Color('#232C4A66'), width: 1.px)),
        backdropFilter: .blur(16.px),
        backgroundColor: Color('#0B0E1AB8'),
      ),
      css('.nav-in').styles(
        display: .flex,
        maxWidth: T.maxWidth.px,
        padding: .symmetric(vertical: 0.8.rem, horizontal: 1.5.rem),
        margin: .symmetric(horizontal: .auto),
        justifyContent: .spaceBetween,
        alignItems: .center,
        gap: .all(1.rem),
      ),
      css('.brand').styles(
        display: .flex,
        alignItems: .center,
        gap: .all(0.65.rem),
      ),
      css('.brand-mark').styles(
        display: .flex,
        width: 30.px,
        height: 30.px,
        radius: .circular(9.px),
        justifyContent: .center,
        alignItems: .center,
        color: T.bg,
        fontSize: 12.px,
        fontWeight: .w800,
        raw: {'background': T.gradient},
      ),
      css('.brand-name').styles(
        fontSize: 0.95.rem,
        fontWeight: .w600,
      ),
      css('.nav-links').styles(
        display: .flex,
        gap: .all(1.8.rem),
      ),
      css('.nav-link', [
        css('&').styles(
          padding: .only(bottom: 3.px),
          transition: Transition('color', duration: 200.ms),
          color: T.muted,
          fontFamily: T.mono,
          fontSize: 0.84.rem,
          raw: {
            'background': 'linear-gradient(90deg, #7C8CFF, #22D3EE) no-repeat left bottom',
            'background-size': '0% 2px',
            'transition': 'color 0.2s, background-size 0.3s cubic-bezier(0.22, 1, 0.36, 1)',
          },
        ),
        css('&:hover').styles(
          color: T.text,
          raw: {'background-size': '100% 2px'},
        ),
      ]),
      css('.nav-cta', [
        css('&').styles(
          padding: .symmetric(vertical: 0.5.rem, horizontal: 1.1.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(11.px),
          transition: Transition('all', duration: 250.ms, curve: .easeOut),
          fontSize: 0.86.rem,
          fontWeight: .w600,
          backgroundColor: Color('#121729CC'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#7C8CFF88'), width: 1.px),
          backgroundColor: T.surface,
        ),
        css('&:active').styles(
          transform: .scale(0.96),
        ),
      ]),
    ]),
    css.media(.screen(maxWidth: 860.px), [
      css('.nav .nav-links').styles(display: .none),
      css('.nav .brand-name').styles(display: .none),
    ]),
  ];
}
