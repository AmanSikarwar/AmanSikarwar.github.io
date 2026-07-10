import 'package:jaspr/dom.dart';

/// Design tokens as CSS custom properties so the theme can switch at runtime.
/// Values live in the `_dark`/`_light` maps below; components reference var().
abstract final class T {
  // Palette — dusk (dark) / daybreak (light): warm plum ink, sunset accent.
  static const bg = Color('var(--bg)');
  static const surface = Color('var(--surface)');
  static const surfaceRaised = Color('var(--surface-raised)');
  static const line = Color('var(--line)');
  static const text = Color('var(--text)');
  static const muted = Color('var(--muted)');
  static const faint = Color('var(--faint)');
  static const accent = Color('var(--accent)');
  static const accent2 = Color('var(--accent2)');

  /// Raw CSS gradient reused across components.
  static const gradient = 'var(--gradient)';

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

  // Layout. rem so the shell scales with the user's font-size setting.
  static const maxWidth = 70; // rem
}

// Dusk (default).
const _dark = {
  'color-scheme': 'dark',
  '--bg': '#100C13',
  '--surface': '#1A1420',
  '--surface-raised': '#241B2C',
  '--line': '#33263D',
  '--line-soft': '#33263D59',
  '--text': '#F3EDE9',
  '--muted': '#B0A3AC',
  '--faint': '#7D6F7C',
  '--accent': '#FFA96B',
  '--accent2': '#FF7A9C',
  '--gradient': 'linear-gradient(135deg, #FFA96B 0%, #FF7A9C 100%)',
  '--glass': '#1A142066',
  '--glass-strong': '#1A1420CC',
  '--nav-bg': '#100C13B8',
  '--chip': '#241B2C88',
  '--ticker-bg': '#120D18',
  '--shadow': '#00000055',
};

// Daybreak: warm porcelain counterpart, deeper accents for contrast.
const _light = {
  'color-scheme': 'light',
  '--bg': '#FAF5F0',
  '--surface': '#FFFFFF',
  '--surface-raised': '#FFFFFF',
  '--line': '#E5D8D0',
  '--line-soft': '#E5D8D0AA',
  '--text': '#2A1F27',
  '--muted': '#6E5F6B',
  '--faint': '#9C8D98',
  '--accent': '#D06B33',
  '--accent2': '#D64277',
  '--gradient': 'linear-gradient(135deg, #F2934F 0%, #E85D87 100%)',
  '--glass': '#FFFFFF8C',
  '--glass-strong': '#FFFFFFE0',
  '--nav-bg': '#FAF5F0C9',
  '--chip': '#F3E9E2',
  '--ticker-bg': '#F4ECE5',
  '--shadow': '#3A241A1A',
};

@css
List<StyleRule> get globalStyles => [
  // Theme variables: dark by default, light when the system asks for it
  // (and no explicit choice was made), or when the toggle sets data-theme.
  css(':root').styles(raw: _dark),
  css(':root[data-theme="light"]').styles(raw: _light),
  css.media(.raw('(prefers-color-scheme: light)'), [
    css(':root:not([data-theme])').styles(raw: _light),
  ]),
  css('*, *::before, *::after').styles(
    margin: .zero,
    boxSizing: .borderBox,
  ),
  css('html').styles(
    raw: {'scroll-behavior': 'smooth'},
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
    maxWidth: T.maxWidth.rem,
    padding: .symmetric(vertical: 7.rem, horizontal: 1.5.rem),
    margin: .symmetric(horizontal: .auto),
  ),
  // Breakpoints in em so they respond to the browser font-size setting.
  css.media(.screen(maxWidth: 45.em), [
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
      raw: {'background': T.gradient, 'box-shadow': '0 8px 28px #FFA96B3D'},
    ),
    css('&:hover').styles(
      transform: .translate(y: (-2).px),
      raw: {'box-shadow': '0 12px 36px #FFA96B5C'},
    ),
  ]),
  css('.btn-ghost', [
    css('&').styles(
      border: .all(color: T.line, width: 1.px),
      color: T.text,
      backgroundColor: Color('var(--glass)'),
    ),
    css('&:hover').styles(
      border: .all(color: Color('#FFA96B88'), width: 1.px),
      transform: .translate(y: (-2).px),
      backgroundColor: T.surface,
    ),
  ]),
  // Anchored sections and project cards stop below the fixed nav.
  css('section[id], footer[id], article[id]').styles(
    raw: {'scroll-margin-top': '6rem'},
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
