import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../styles/theme.dart';

class Nav extends StatelessComponent {
  const Nav({super.key});

  static const _links = ['about', 'experience', 'projects', 'oss', 'skills'];

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
        a(classes: 'nav-cta', href: '#contact', [.text('Get in touch')]),
        button(classes: 'nav-burger', attributes: {'aria-label': 'Menu'}, [
          span([]),
          span([]),
          span([]),
        ]),
      ]),
      div(classes: 'nav-menu', [
        for (final l in _links) a(href: '#$l', [.text(l)]),
        a(href: '#contact', [.text('get in touch')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.nav', [
      css('&').styles(
        position: .fixed(top: 0.px, left: 0.px, right: 0.px),
        zIndex: ZIndex(100),
        border: .only(bottom: BorderSide.solid(color: Color('#33263D66'), width: 1.px)),
        backdropFilter: .blur(16.px),
        backgroundColor: Color('#100C13B8'),
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
            'background': 'linear-gradient(90deg, #FFA96B, #FF7A9C) no-repeat left bottom',
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
          backgroundColor: Color('#1A1420CC'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#FFA96B88'), width: 1.px),
          backgroundColor: T.surface,
        ),
        css('&:active').styles(
          transform: .scale(0.96),
        ),
      ]),
      css('.nav-link.active').styles(
        color: T.text,
        raw: {'background-size': '100% 2px'},
      ),
      css('.nav-burger', [
        css('&').styles(
          display: .none,
          padding: .all(6.px),
          border: .none,
          cursor: .pointer,
          flexDirection: .column,
          gap: .all(5.px),
          backgroundColor: Colors.transparent,
        ),
        css('span').styles(
          display: .block,
          width: 22.px,
          height: 2.px,
          radius: .circular(2.px),
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          backgroundColor: T.text,
        ),
      ]),
      css('.nav-menu', [
        css('&').styles(
          display: .flex,
          maxHeight: .zero,
          overflow: .hidden,
          transition: Transition('max-height', duration: 400.ms, curve: .cubicBezier(0.22, 1, 0.36, 1)),
          flexDirection: .column,
        ),
        css('a').styles(
          padding: .symmetric(vertical: 0.9.rem, horizontal: 1.5.rem),
          border: .only(top: BorderSide.solid(color: Color('#33263D44'), width: 1.px)),
          color: T.muted,
          fontFamily: T.mono,
          fontSize: 0.95.rem,
        ),
        css('a:hover').styles(
          color: T.text,
          backgroundColor: Color('#1A142088'),
        ),
      ]),
    ]),
    // Open state (html.menu-open toggled by the Interactions island).
    css('.menu-open .nav-menu').styles(
      maxHeight: 20.rem,
    ),
    css('.menu-open .nav-burger span:nth-child(1)').styles(
      transform: .combine([.translate(y: 7.px), .rotate(45.deg)]),
    ),
    css('.menu-open .nav-burger span:nth-child(2)').styles(
      opacity: 0,
    ),
    css('.menu-open .nav-burger span:nth-child(3)').styles(
      transform: .combine([.translate(y: (-7).px), .rotate((-45).deg)]),
    ),
    css.media(.screen(maxWidth: 860.px), [
      css('.nav .nav-links').styles(display: .none),
      css('.nav .brand-name').styles(display: .none),
      css('.nav .nav-burger').styles(display: .flex),
    ]),
    css.media(.screen(minWidth: 861.px), [
      css('.nav .nav-menu').styles(display: .none),
    ]),
  ];
}
