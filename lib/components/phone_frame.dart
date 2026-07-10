import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';

/// The hero's signature: a phone whose screen is a live "home screen" of
/// Aman's apps, with push notifications cycling in. Pure HTML/CSS — no JS.
class PhoneFrame extends StatelessComponent {
  const PhoneFrame({required this.projects, required this.stats, super.key});

  final List<Project> projects;
  final List<({String value, String label})> stats;

  @override
  Component build(BuildContext context) {
    final featured = projects.where((x) => x.featured && x.phone).toList();
    final mobile = projects
        .where((x) =>
            x.phone && (x.platforms.contains('iOS') || x.platforms.contains('Android')))
        .toList();
    // Favorites live in the dock, the rest on the home screen — like a real phone.
    final dockApps = mobile.take(4).toList();
    final gridApps = mobile.skip(4).take(6).toList();

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
              div(classes: 'notifs', [
                for (final (i, proj) in featured.indexed)
                  div(
                    classes: 'notif',
                    // 4s per notif; cycle length follows the featured count
                    styles: Styles(raw: {
                      'animation': 'notif-in ${featured.length * 4}s ease-in-out ${i * 4}s infinite both',
                    }),
                    [
                      _appIcon(proj, 'notif-icon'),
                      div(classes: 'notif-body', [
                        strong([.text(proj.title)]),
                        span([.text(proj.tagline)]),
                      ]),
                      span(classes: 'notif-time', [.text('now')]),
                    ],
                  ),
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
                for (final proj in gridApps)
                  div(classes: 'app', [
                    _appIcon(proj, 'app-icon'),
                    span(classes: 'app-label', [.text(_short(proj.title))]),
                  ]),
              ]),
              div(classes: 'pagedots', [span(classes: 'on', []), span([])]),
              div(classes: 'dock', [
                for (final proj in dockApps) _appIcon(proj, 'dock-app'),
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
    // ponytail: visible window sized for 2 featured notifs (50% slots each)
    css.keyframes('notif-in', {
      '0%, 50%, 100%': Styles(opacity: 0, transform: .combine([.translate(y: (-18).px), .scale(0.92)])),
      '4%, 44%': Styles(opacity: 1, transform: .combine([.translate(y: 0.px), .scale(1)])),
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
    css('.phone-scene', [
      css('&').styles(
        position: .relative(),
        raw: {'perspective': '1400px'},
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
          'background': 'linear-gradient(135deg, #7C8CFF44 0%, #22D3EE33 100%)',
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
          border: .all(color: Color('#2E3A5E'), width: 1.px),
          radius: .circular(48.px),
          raw: {
            'background': 'linear-gradient(160deg, #1D2440 0%, #12172B 45%, #0E1222 100%)',
            'box-shadow':
                '0 40px 80px #00000066, inset 0 1px 0 #FFFFFF14, inset 0 -1px 0 #00000055',
          },
        ),
        // Volume buttons (left edge; second one via box-shadow) and power (right).
        css('&::before').styles(
          content: '',
          position: .absolute(top: 120.px, left: (-3).px),
          width: 3.px,
          height: 34.px,
          backgroundColor: Color('#2E3A5E'),
          raw: {'border-radius': '2px 0 0 2px', 'box-shadow': '0 46px 0 #2E3A5E'},
        ),
        css('&::after').styles(
          content: '',
          position: .absolute(top: 150.px, right: (-3).px),
          width: 3.px,
          height: 56.px,
          backgroundColor: Color('#2E3A5E'),
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
            'background':
                'radial-gradient(120% 90% at 20% 0%, #1B2242 0%, #0D1122 55%, #0A0D1A 100%)',
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
        raw: {'background': '#7C8CFF3D'},
      ),
      css('.wall-b').styles(
        position: .absolute(left: 34.percent, bottom: 10.percent),
        width: 220.px,
        height: 220.px,
        raw: {'background': '#22D3EE2E', 'animation-delay': '-5.5s'},
      ),
      css('.island').styles(
        position: .absolute(top: 12.px, left: 50.percent),
        zIndex: ZIndex(3),
        width: 92.px,
        height: 26.px,
        radius: .circular(14.px),
        transform: .translate(x: (-50).percent),
        backgroundColor: Color('#05070D'),
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
          border: .all(color: Color('#E8ECF877'), width: 1.px),
          radius: .circular(3.5.px),
        ),
        css('.sb-level').styles(
          display: .block,
          width: 70.percent,
          height: 100.percent,
          radius: .circular(1.5.px),
          backgroundColor: T.accent2,
        ),
      ]),
      css('.notifs', [
        css('&').styles(
          position: .absolute(top: 52.px, left: 14.px, right: 14.px),
          zIndex: ZIndex(2),
          height: 64.px,
        ),
        css('.notif').styles(
          display: .flex,
          position: .absolute(top: 0.px, left: 0.px, right: 0.px),
          padding: .symmetric(vertical: 10.px, horizontal: 12.px),
          radius: .circular(18.px),
          opacity: 0,
          backdropFilter: .blur(18.px),
          alignItems: .center,
          gap: .all(10.px),
          backgroundColor: Color('#242D4CBB'),
        ),
        css('.notif-icon').styles(
          display: .flex,
          width: 34.px,
          height: 34.px,
          radius: .circular(9.px),
          overflow: .hidden,
          justifyContent: .center,
          alignItems: .center,
          flex: .none,
          color: Color('#0B0E1A'),
          fontSize: 16.px,
          fontWeight: .w800,
        ),
        css('.notif-body', [
          css('&').styles(
            display: .flex,
            overflow: .hidden,
            flexDirection: .column,
            flex: .grow(1),
          ),
          css('strong').styles(
            color: T.text,
            fontSize: 12.5.px,
            lineHeight: 1.35.em,
          ),
          css('span').styles(
            overflow: .hidden,
            color: T.muted,
            fontSize: 11.5.px,
            lineHeight: 1.35.em,
            textOverflow: .ellipsis,
            whiteSpace: .noWrap,
          ),
        ]),
        css('.notif-time').styles(
          alignSelf: .start,
          color: T.faint,
          fontSize: 10.px,
        ),
      ]),
      css('.widgets', [
        css('&').styles(
          display: .grid,
          padding: .symmetric(vertical: 0.px, horizontal: 20.px),
          margin: .only(top: 84.px),
          gridTemplate: GridTemplate(columns: GridTracks([GridTrack.repeat(TrackRepeat(2), [GridTrack(.fr(1))])])),
          gap: .all(10.px),
        ),
        css('.widget', [
          css('&').styles(
            display: .flex,
            padding: .all(14.px),
            border: .all(color: Color('#2A335544'), width: 1.px),
            radius: .circular(18.px),
            flexDirection: .column,
            gap: .all(2.px),
            backgroundColor: Color('#242D4C55'),
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
          padding: .symmetric(vertical: 0.px, horizontal: 20.px),
          margin: .only(top: 22.px),
          gridTemplate: GridTemplate(columns: GridTracks([GridTrack.repeat(TrackRepeat(3), [GridTrack(.fr(1))])])),
          gap: Gap(row: 18.px, column: 8.px),
        ),
        css('.app').styles(
          display: .flex,
          flexDirection: .column,
          alignItems: .center,
          gap: .all(6.px),
        ),
        css('.app-icon').styles(
          display: .flex,
          width: 52.px,
          height: 52.px,
          radius: .circular(14.px),
          overflow: .hidden,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 14.px, color: Color('#00000055')),
          justifyContent: .center,
          alignItems: .center,
          color: Color('#0B0E1A'),
          fontSize: 22.px,
          fontWeight: .w800,
        ),
        css('.app-label').styles(
          maxWidth: 70.px,
          overflow: .hidden,
          color: T.muted,
          fontSize: 10.5.px,
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
          backgroundColor: Color('#E8ECF833'),
        ),
        css('span.on').styles(
          backgroundColor: Color('#E8ECF8AA'),
        ),
      ]),
      css('.dock').styles(
        display: .flex,
        position: .absolute(bottom: 22.px, left: 16.px, right: 16.px),
        padding: .all(10.px),
        border: .all(color: Color('#FFFFFF0F'), width: 1.px),
        radius: .circular(24.px),
        backdropFilter: .blur(14.px),
        justifyContent: .spaceAround,
        backgroundColor: Color('#242D4C66'),
      ),
      css('.dock-app').styles(
        display: .flex,
        width: 46.px,
        height: 46.px,
        radius: .circular(13.px),
        overflow: .hidden,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 14.px, color: Color('#00000055')),
        justifyContent: .center,
        alignItems: .center,
        color: Color('#0B0E1A'),
        fontSize: 20.px,
        fontWeight: .w800,
      ),
      css('.homebar').styles(
        position: .absolute(bottom: 7.px, left: 50.percent),
        width: 110.px,
        height: 4.px,
        radius: .circular(2.px),
        transform: .translate(x: (-50).percent),
        backgroundColor: Color('#E8ECF855'),
      ),
    ]),
    css.media(.screen(maxWidth: 980.px), [
      css('.phone-scene .phone-body').styles(width: 270.px),
      css('.phone-scene .screen').styles(height: 556.px),
      css('.phone-scene .widgets').styles(margin: .only(top: 72.px)),
    ]),
  ];
}
