import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';

// Phone hardware palette — dark device by default, silver in light theme.
const _phoneDark = {
  '--ph-frame': 'linear-gradient(160deg, #281E31 0%, #191221 45%, #120D19 100%)',
  '--ph-frame-line': '#41314C',
  '--ph-screen': 'radial-gradient(120% 90% at 20% 0%, #2A1E33 0%, #150F1C 55%, #0E0A12 100%)',
  '--ph-widget': '#2E223755',
  '--ph-widget-line': '#3A2C4644',
  '--ph-dock': '#2E223766',
  '--ph-dock-line': '#FFFFFF0F',
  '--ph-batt': '#F3EDE977',
  '--ph-homebar': '#F3EDE955',
  '--ph-dot': '#F3EDE833',
  '--ph-dot-on': '#F3EDE9AA',
  '--ph-shadow': '#00000066',
};

const _phoneLight = {
  '--ph-frame': 'linear-gradient(160deg, #FBF6F3 0%, #EADFE3 45%, #D9CBD1 100%)',
  '--ph-frame-line': '#C7B9C0',
  '--ph-screen': 'radial-gradient(120% 90% at 20% 0%, #FFFBF5 0%, #F6EBEC 55%, #EDE0E4 100%)',
  '--ph-widget': '#FFFFFF9E',
  '--ph-widget-line': '#E5D8D0AA',
  '--ph-dock': '#F8F0F2AA',
  '--ph-dock-line': '#FFFFFFBB',
  '--ph-batt': '#2A1F2766',
  '--ph-homebar': '#2A1F2755',
  '--ph-dot': '#2A1F2733',
  '--ph-dot-on': '#2A1F27AA',
  '--ph-shadow': '#3A241A2E',
};

/// The hero's signature: a phone whose screen is a live "home screen" of
/// Aman's apps, with push notifications cycling in. Pure HTML/CSS — no JS.
class PhoneFrame extends StatelessComponent {
  const PhoneFrame({required this.projects, required this.stats, super.key});

  final List<Project> projects;
  final List<({String value, String label})> stats;

  // System apps for the dock, like a real phone.
  static const _dockApps = [
    (name: 'phone', bg: 'linear-gradient(145deg, #4CDE6A, #23B94B)', fg: '#FFFFFF'),
    (name: 'message', bg: 'linear-gradient(145deg, #4CDE6A, #23B94B)', fg: '#FFFFFF'),
    (name: 'compass', bg: 'linear-gradient(145deg, #F4F7FF, #C9D4E8)', fg: '#1B7FE4'),
    (name: 'camera', bg: 'linear-gradient(145deg, #443B4D, #2B2333)', fg: '#F3EDE9'),
  ];

  @override
  Component build(BuildContext context) {
    final mobile = projects
        .where((x) =>
            x.phone && (x.platforms.contains('iOS') || x.platforms.contains('Android')))
        .take(8)
        .toList();

    return div(classes: 'phone-scene', [
      div(classes: 'phone-glow', []),
      div(classes: 'phone-float', [
        div(classes: 'phone-tilt', [
          div(classes: 'phone-body', [
            div(classes: 'screen', [
              div(classes: 'wall-blob wall-a', []),
              div(classes: 'wall-blob wall-b', []),
              div(classes: 'island', []),
              div(classes: 'statusbar', [
                span(classes: 'sb-time', [.text('9:41')]),
                span(classes: 'sb-right', [
                  span(classes: 'sb-bars', [
                    for (final h in [4, 6, 8, 10]) span(styles: Styles(height: h.px), []),
                  ]),
                  span(classes: 'sb-battery', [span(classes: 'sb-level', [])]),
                ]),
              ]),
              div(classes: 'widgets', [
                for (final s in stats.take(2))
                  div(classes: 'widget', [
                    strong([.text(s.value)]),
                    span([.text(s.label)]),
                  ]),
                if (stats.length > 2)
                  div(classes: 'widget widget-wide', [
                    div(classes: 'ww-copy', [
                      strong([.text(stats[2].value)]),
                      span([.text(stats[2].label)]),
                    ]),
                    div(classes: 'contrib', [
                      for (final _ in Iterable.generate(12)) span([]),
                    ]),
                  ]),
              ]),
              div(classes: 'apps', [
                for (final proj in mobile)
                  a(classes: 'app', href: '#${proj.slug}', attributes: {'title': proj.title}, [
                    _appIcon(proj, 'app-icon'),
                    span(classes: 'app-label', [.text(_short(proj.title))]),
                  ]),
              ]),
              div(classes: 'pagedots', [span(classes: 'on', []), span([])]),
              div(classes: 'dock', [
                for (final sys in _dockApps)
                  div(
                    classes: 'dock-app',
                    styles: Styles(color: Color(sys.fg), raw: {'background': sys.bg}),
                    [Icon(sys.name, size: 24)],
                  ),
              ]),
              div(classes: 'homebar', []),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  static String _short(String title) => title.split(RegExp(r'[ &]')).first;

  /// Real app icon when the project has one, gradient letter tile otherwise.
  static Component _appIcon(Project proj, String classes) {
    if (proj.icon case final icon?) {
      return div(classes: classes, [
        img(classes: 'app-img', src: icon, alt: proj.title, loading: .lazy),
      ]);
    }
    return div(
      classes: classes,
      styles: Styles(raw: {'background': 'linear-gradient(145deg, ${proj.accent}, ${proj.accent}99)'}),
      [.text(proj.title[0])],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css.keyframes('phone-float', {
      '0%, 100%': Styles(transform: .translate(y: 0.px)),
      '50%': Styles(transform: .translate(y: (-14).px)),
    }),
    css.keyframes('glow-pulse', {
      '0%, 100%': Styles(opacity: 0.55),
      '50%': Styles(opacity: 0.9),
    }),
    css.keyframes('wall-drift', {
      '0%, 100%': Styles(transform: .combine([.translate(x: 0.px, y: 0.px), .scale(1)])),
      '50%': Styles(transform: .combine([.translate(x: 26.px, y: (-20).px), .scale(1.15)])),
    }),
    css.keyframes('sheen', {
      '0%, 55%': Styles(raw: {'transform': 'translateX(-130%) skewX(-18deg)'}),
      '85%, 100%': Styles(raw: {'transform': 'translateX(230%) skewX(-18deg)'}),
    }),
    // Phone hardware/wallpaper follows the site theme via scoped vars.
    css(':root[data-theme="light"] .phone-scene').styles(raw: _phoneLight),
    css.media(.raw('(prefers-color-scheme: light)'), [
      css(':root:not([data-theme]) .phone-scene').styles(raw: _phoneLight),
    ]),
    css('.phone-scene', [
      css('&').styles(
        position: .relative(),
        raw: {'perspective': '1400px', ..._phoneDark},
      ),
      css('.app-img').styles(
        width: 100.percent,
        height: 100.percent,
        raw: {'object-fit': 'cover'},
      ),
      css('.phone-glow').styles(
        position: .absolute(top: 10.percent, left: 8.percent, right: 8.percent, bottom: 8.percent),
        radius: .circular(50.percent),
        filter: .blur(90.px),
        raw: {
          'background': 'linear-gradient(135deg, #FFA96B44 0%, #FF7A9C33 100%)',
          'animation': 'glow-pulse 7s ease-in-out infinite',
        },
      ),
      css('.phone-float').styles(
        raw: {'animation': 'phone-float 7s ease-in-out infinite'},
      ),
      css('.phone-tilt').styles(
        transition: Transition('transform', duration: 600.ms, curve: .cubicBezier(0.22, 1, 0.36, 1)),
        raw: {'transform': 'rotateY(-12deg) rotateX(4deg)', 'transform-style': 'preserve-3d'},
      ),
      css('&:hover .phone-tilt').styles(
        raw: {'transform': 'rotateY(0deg) rotateX(0deg)'},
      ),
      css('.phone-body', [
        css('&').styles(
          position: .relative(),
          width: 300.px,
          padding: .all(10.px),
          border: .all(color: Color('var(--ph-frame-line)'), width: 1.px),
          radius: .circular(48.px),
          raw: {
            'background': 'var(--ph-frame)',
            'box-shadow':
                '0 40px 80px var(--ph-shadow), inset 0 1px 0 #FFFFFF14, inset 0 -1px 0 #00000055',
          },
        ),
        // Volume buttons (left edge; second one via box-shadow) and power (right).
        css('&::before').styles(
          content: '',
          position: .absolute(top: 120.px, left: (-3).px),
          width: 3.px,
          height: 34.px,
          backgroundColor: Color('var(--ph-frame-line)'),
          raw: {'border-radius': '2px 0 0 2px', 'box-shadow': '0 46px 0 var(--ph-frame-line)'},
        ),
        css('&::after').styles(
          content: '',
          position: .absolute(top: 150.px, right: (-3).px),
          width: 3.px,
          height: 56.px,
          backgroundColor: Color('var(--ph-frame-line)'),
          raw: {'border-radius': '0 2px 2px 0'},
        ),
      ]),
      css('.screen', [
        css('&').styles(
          position: .relative(),
          height: 620.px,
          radius: .circular(38.px),
          overflow: .hidden,
          raw: {
            'background': 'var(--ph-screen)',
            'box-shadow': 'inset 0 0 0 1px #FFFFFF0A',
          },
        ),
        // Glass sheen sweeping across the screen every few seconds.
        css('&::after').styles(
          content: '',
          position: .absolute(top: 0.px, left: 0.px, bottom: 0.px),
          zIndex: ZIndex(4),
          width: 45.percent,
          pointerEvents: .none,
          raw: {
            'background':
                'linear-gradient(100deg, transparent 0%, #FFFFFF09 40%, #FFFFFF12 50%, #FFFFFF09 60%, transparent 100%)',
            'animation': 'sheen 9s ease-in-out infinite',
          },
        ),
      ]),
      css('.wall-blob').styles(
        position: .absolute(),
        radius: .circular(50.percent),
        filter: .blur(46.px),
        pointerEvents: .none,
        raw: {'animation': 'wall-drift 11s ease-in-out infinite'},
      ),
      // Keep home-screen content above the wallpaper blobs.
      css('.statusbar, .widgets, .apps').styles(
        position: .relative(),
        zIndex: ZIndex(1),
      ),
      css('.wall-a').styles(
        position: .absolute(top: 6.percent, left: (-14).percent),
        width: 200.px,
        height: 200.px,
        raw: {'background': '#FFA96B3D'},
      ),
      css('.wall-b').styles(
        position: .absolute(left: 34.percent, bottom: 10.percent),
        width: 220.px,
        height: 220.px,
        raw: {'background': '#FF7A9C2E', 'animation-delay': '-5.5s'},
      ),
      css('.island').styles(
        position: .absolute(top: 12.px, left: 50.percent),
        zIndex: ZIndex(3),
        width: 92.px,
        height: 26.px,
        radius: .circular(14.px),
        transform: .translate(x: (-50).percent),
        backgroundColor: Color('#070409'),
      ),
      css('.statusbar', [
        css('&').styles(
          display: .flex,
          padding: .only(left: 26.px, right: 24.px, top: 16.px),
          justifyContent: .spaceBetween,
          alignItems: .center,
          color: T.text,
          fontSize: 13.px,
          fontWeight: .w600,
        ),
        css('.sb-right').styles(
          display: .flex,
          alignItems: .center,
          gap: .all(6.px),
        ),
        css('.sb-bars').styles(
          display: .flex,
          alignItems: .end,
          gap: .all(2.px),
        ),
        css('.sb-bars > span').styles(
          display: .inlineBlock,
          width: 3.px,
          radius: .circular(1.px),
          backgroundColor: T.text,
        ),
        css('.sb-battery').styles(
          display: .inlineBlock,
          width: 22.px,
          height: 11.px,
          padding: .all(1.5.px),
          border: .all(color: Color('var(--ph-batt)'), width: 1.px),
          radius: .circular(3.5.px),
        ),
        css('.sb-level').styles(
          display: .block,
          width: 70.percent,
          height: 100.percent,
          radius: .circular(1.5.px),
          backgroundColor: Color('#4CDE6A'),
        ),
      ]),
      css('.widgets', [
        css('&').styles(
          display: .grid,
          padding: .symmetric(vertical: 0.px, horizontal: 20.px),
          margin: .only(top: 26.px),
          gridTemplate: GridTemplate(columns: GridTracks([GridTrack.repeat(TrackRepeat(2), [GridTrack(.fr(1))])])),
          gap: .all(10.px),
        ),
        css('.widget', [
          css('&').styles(
            display: .flex,
            padding: .all(14.px),
            border: .all(color: Color('var(--ph-widget-line)'), width: 1.px),
            radius: .circular(18.px),
            flexDirection: .column,
            gap: .all(2.px),
            backgroundColor: Color('var(--ph-widget)'),
          ),
          css('strong').styles(
            fontFamily: T.display,
            fontSize: 20.px,
            fontWeight: .w800,
            raw: {
              'background': T.gradient,
              '-webkit-background-clip': 'text',
              'background-clip': 'text',
              '-webkit-text-fill-color': 'transparent',
            },
          ),
          css('span').styles(
            overflow: .hidden,
            color: T.muted,
            fontSize: 10.px,
            lineHeight: 1.4.em,
            raw: {'display': '-webkit-box', '-webkit-line-clamp': '2', '-webkit-box-orient': 'vertical'},
          ),
        ]),
        css('.widget-wide', [
          css('&').styles(
            justifyContent: .spaceBetween,
            alignItems: .center,
            flexDirection: .row,
            gap: .all(10.px),
            raw: {'grid-column': 'span 2'},
          ),
          css('.ww-copy').styles(
            display: .flex,
            flexDirection: .column,
            gap: .all(2.px),
          ),
          // GitHub-style contribution squares.
          css('.contrib').styles(
            display: .grid,
            flex: .none,
            gap: .all(3.px),
            raw: {'grid-template-columns': 'repeat(6, 8px)'},
          ),
          css('.contrib span').styles(
            width: 8.px,
            height: 8.px,
            radius: .circular(2.px),
            backgroundColor: Color('#34D399'),
            opacity: 0.18,
          ),
          css('.contrib span:nth-child(3n)').styles(opacity: 0.55),
          css('.contrib span:nth-child(4n + 1)').styles(opacity: 0.9),
          css('.contrib span:nth-child(5n + 2)').styles(opacity: 0.35),
        ]),
      ]),
      css('.apps', [
        css('&').styles(
          display: .grid,
          padding: .symmetric(vertical: 0.px, horizontal: 18.px),
          margin: .only(top: 24.px),
          gridTemplate: GridTemplate(columns: GridTracks([GridTrack.repeat(TrackRepeat(4), [GridTrack(.fr(1))])])),
          gap: Gap(row: 16.px, column: 6.px),
        ),
        css('.app', [
          css('&').styles(
            display: .flex,
            flexDirection: .column,
            alignItems: .center,
            gap: .all(6.px),
          ),
          css('&:hover .app-icon').styles(
            transform: .scale(1.08),
          ),
          css('&:active .app-icon').styles(
            transform: .scale(0.9),
          ),
          css('&:hover .app-label').styles(
            color: T.text,
          ),
        ]),
        css('.app-icon').styles(
          display: .flex,
          width: 50.px,
          height: 50.px,
          radius: .circular(14.px),
          overflow: .hidden,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 14.px, color: Color('var(--shadow)')),
          transition: Transition('transform', duration: 200.ms, curve: .easeOut),
          justifyContent: .center,
          alignItems: .center,
          color: Color('#100C13'),
          fontSize: 22.px,
          fontWeight: .w800,
        ),
        css('.app-label').styles(
          maxWidth: 60.px,
          overflow: .hidden,
          transition: Transition('color', duration: 200.ms),
          color: T.muted,
          fontSize: 10.px,
          textOverflow: .ellipsis,
          whiteSpace: .noWrap,
        ),
      ]),
      css('.pagedots', [
        css('&').styles(
          display: .flex,
          position: .absolute(bottom: 98.px, left: 0.px, right: 0.px),
          justifyContent: .center,
          gap: .all(7.px),
        ),
        css('span').styles(
          width: 6.px,
          height: 6.px,
          radius: .circular(50.percent),
          backgroundColor: Color('var(--ph-dot)'),
        ),
        css('span.on').styles(
          backgroundColor: Color('var(--ph-dot-on)'),
        ),
      ]),
      css('.dock').styles(
        display: .flex,
        position: .absolute(bottom: 22.px, left: 16.px, right: 16.px),
        padding: .all(10.px),
        border: .all(color: Color('var(--ph-dock-line)'), width: 1.px),
        radius: .circular(24.px),
        backdropFilter: .blur(14.px),
        justifyContent: .spaceAround,
        backgroundColor: Color('var(--ph-dock)'),
      ),
      css('.dock-app').styles(
        display: .flex,
        width: 46.px,
        height: 46.px,
        radius: .circular(13.px),
        overflow: .hidden,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 14.px, color: Color('var(--shadow)')),
        justifyContent: .center,
        alignItems: .center,
        color: Color('#100C13'),
        fontSize: 20.px,
        fontWeight: .w800,
      ),
      css('.homebar').styles(
        position: .absolute(bottom: 7.px, left: 50.percent),
        width: 110.px,
        height: 4.px,
        radius: .circular(2.px),
        transform: .translate(x: (-50).percent),
        backgroundColor: Color('var(--ph-homebar)'),
      ),
    ]),
    css.media(.screen(maxWidth: 980.px), [
      css('.phone-scene .phone-body').styles(width: 270.px),
      css('.phone-scene .screen').styles(height: 556.px),
      css('.phone-scene .widgets').styles(margin: .only(top: 20.px)),
    ]),
  ];
}
