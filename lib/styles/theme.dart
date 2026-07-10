import 'package:jaspr/dom.dart';

/// Design tokens. Dart constants over CSS variables: type-safe, zero indirection.
abstract final class T {
  // Palette — deep indigo ink, layered surfaces, electric indigo→cyan accent.
  static const bg = Color('#0B0E1A');
  static const surface = Color('#121729');
  static const surfaceRaised = Color('#181F36');
  static const line = Color('#232C4A');
  static const text = Color('#E8ECF8');
  static const muted = Color('#8A93AE');
  static const faint = Color('#5A6380');
  static const accent = Color('#7C8CFF');
  static const accent2 = Color('#22D3EE');
  static const amber = Color('#F5A623');

  /// Raw CSS gradient reused across components.
  static const gradient = 'linear-gradient(135deg, #7C8CFF 0%, #22D3EE 100%)';

  // Type. Body is the native platform stack — the site renders in SF Pro on
  // Apple devices and Roboto on Android, like a native app would.
  static const display = FontFamily.list([FontFamily('Syne'), FontFamilies.sansSerif]);
  static const body = FontFamily.list([
    FontFamily('-apple-system'),
    FontFamily('BlinkMacSystemFont'),
    FontFamily('Segoe UI'),
    FontFamily('Roboto'),
    FontFamilies.sansSerif,
  ]);
  static const mono = FontFamily.list([FontFamily('JetBrains Mono'), FontFamilies.monospace]);

  // Layout
  static const maxWidth = 1120;
}

@css
List<StyleRule> get globalStyles => [
  css('*, *::before, *::after').styles(
    margin: .zero,
    boxSizing: .borderBox,
  ),
  css('html').styles(
    raw: {'scroll-behavior': 'smooth', 'color-scheme': 'dark'},
  ),
  css('body').styles(
    minHeight: 100.vh,
    color: T.text,
    fontFamily: T.body,
    lineHeight: 1.6.em,
    backgroundColor: T.bg,
    raw: {'-webkit-font-smoothing': 'antialiased', 'text-rendering': 'optimizeLegibility'},
  ),
  css('::selection').styles(
    color: T.bg,
    backgroundColor: T.accent,
  ),
  css('a').styles(
    color: .inherit,
    textDecoration: .none,
  ),
  css(':focus-visible').styles(
    outline: Outline(color: T.accent2, style: .solid, width: OutlineWidth(2.px)),
    raw: {'outline-offset': '3px'},
  ),
  // Shared section shell: consistent rhythm across all sections.
  css('.section').styles(
    width: 100.percent,
    maxWidth: T.maxWidth.px,
    padding: .symmetric(vertical: 7.rem, horizontal: 1.5.rem),
    margin: .symmetric(horizontal: .auto),
  ),
  css.media(.screen(maxWidth: 720.px), [
    css('.section').styles(padding: .symmetric(vertical: 4.5.rem, horizontal: 1.25.rem)),
  ]),
  // Shared buttons (hero CTAs, contact form). Top-level so both <a> and
  // <button> get them anywhere on the page.
  css('.btn', [
    css('&').styles(
      display: .inlineFlex,
      padding: .symmetric(vertical: 0.85.rem, horizontal: 1.5.rem),
      border: .none,
      radius: .circular(14.px),
      cursor: .pointer,
      transition: Transition('all', duration: 250.ms, curve: .easeOut),
      alignItems: .center,
      gap: .all(0.55.rem),
      fontFamily: T.body,
      fontSize: 0.95.rem,
      fontWeight: .w600,
    ),
    css('&:active').styles(
      transform: .scale(0.96),
    ),
  ]),
  css('.btn-primary', [
    css('&').styles(
      color: T.bg,
      raw: {'background': T.gradient, 'box-shadow': '0 8px 28px #7C8CFF3D'},
    ),
    css('&:hover').styles(
      transform: .translate(y: (-2).px),
      raw: {'box-shadow': '0 12px 36px #7C8CFF5C'},
    ),
  ]),
  css('.btn-ghost', [
    css('&').styles(
      border: .all(color: T.line, width: 1.px),
      color: T.text,
      backgroundColor: Color('#12172988'),
    ),
    css('&:hover').styles(
      border: .all(color: Color('#7C8CFF88'), width: 1.px),
      transform: .translate(y: (-2).px),
      backgroundColor: T.surface,
    ),
  ]),
  // Anchored sections and project cards stop below the fixed nav.
  css('section[id], footer[id], article[id]').styles(
    raw: {'scroll-margin-top': '96px'},
  ),
  // Scroll reveal. Hidden state only applies once JS confirms it's running,
  // so no-JS visitors (and search bots) see full content.
  css('body.js .reveal').styles(
    opacity: 0,
    transition: Transition.combine([
      Transition('opacity', duration: 700.ms, curve: .easeOut),
      Transition('transform', duration: 700.ms, curve: .cubicBezier(0.22, 1, 0.36, 1)),
    ]),
    transform: .translate(y: 28.px),
  ),
  css('body.js .reveal.visible').styles(
    opacity: 1,
    transform: .translate(y: 0.px),
  ),
  // Accessibility: kill all motion when the visitor asks for it.
  css.media(.raw('(prefers-reduced-motion: reduce)'), [
    css('*, *::before, *::after').styles(
      raw: {
        'animation-duration': '0.01ms',
        'animation-iteration-count': '1',
        'transition-duration': '0.01ms',
        'scroll-behavior': 'auto',
      },
    ),
  ]),
];
