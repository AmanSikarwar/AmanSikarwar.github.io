import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';
import 'phone_frame.dart';

class Hero extends StatelessComponent {
  const Hero({required this.profile, required this.projects, super.key});

  final Profile profile;
  final List<Project> projects;

  @override
  Component build(BuildContext context) {
    return section(id: 'top', classes: 'hero', [
      div(classes: 'orb orb-a', []),
      div(classes: 'orb orb-b', []),
      div(classes: 'section hero-in', [
        div(classes: 'hero-copy', [
          div(classes: 'pill rise', [
            span(classes: 'pill-dot', []),
            .text(profile.availability),
          ]),
          h1(classes: 'rise d1', [.text(profile.name)]),
          p(classes: 'role rise d2', [.text(profile.role)]),
          p(classes: 'intro rise d3', [.text(profile.intro)]),
          div(classes: 'ctas rise d4', [
            a(classes: 'btn btn-primary', href: '#projects', [
              .text('See my work'),
              const Icon('arrow', size: 18),
            ]),
            a(classes: 'btn btn-ghost', href: profile.socials['github'] ?? '#', target: .blank, [
              const Icon('github', size: 18),
              .text('GitHub'),
            ]),
          ]),
          div(classes: 'socials rise d5', [
            for (final MapEntry(key: name, value: url) in profile.socials.entries)
              a(classes: 'social', href: url, target: .blank, attributes: {'aria-label': name}, [
                Icon(name, size: 18),
              ]),
            a(classes: 'social', href: 'mailto:${profile.email}', attributes: {'aria-label': 'email'}, [
              const Icon('mail', size: 18),
            ]),
          ]),
        ]),
        div(classes: 'hero-phone rise d3', [
          PhoneFrame(projects: projects, stats: profile.stats),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css.keyframes('rise', {
      'from': Styles(opacity: 0, transform: .translate(y: 26.px)),
      'to': Styles(opacity: 1, transform: .translate(y: 0.px)),
    }),
    css.keyframes('orb-drift', {
      '0%, 100%': Styles(transform: .translate(x: 0.px, y: 0.px)),
      '50%': Styles(transform: .translate(x: 40.px, y: (-30).px)),
    }),
    css('.hero', [
      css('&').styles(
        position: .relative(),
        overflow: .hidden,
        raw: {
          'background-image': 'radial-gradient(circle, #232C4A55 1px, transparent 1px)',
          'background-size': '34px 34px',
        },
      ),
      css('.orb').styles(
        position: .absolute(),
        radius: .circular(50.percent),
        filter: .blur(110.px),
        pointerEvents: .none,
        raw: {'animation': 'orb-drift 16s ease-in-out infinite'},
      ),
      css('.orb-a').styles(
        position: .absolute(top: (-10).percent, left: (-8).percent),
        width: 480.px,
        height: 480.px,
        backgroundColor: Color('#7C8CFF2E'),
      ),
      css('.orb-b').styles(
        position: .absolute(right: (-6).percent, bottom: (-14).percent),
        width: 420.px,
        height: 420.px,
        raw: {'animation-delay': '-8s', 'background-color': '#22D3EE24'},
      ),
      css('.hero-in').styles(
        display: .grid,
        minHeight: 100.vh,
        gridTemplate: GridTemplate(columns: GridTracks([GridTrack(.fr(1.05)), GridTrack(.fr(0.95))])),
        alignItems: .center,
        gap: .all(2.rem),
        raw: {'padding-top': '8rem', 'padding-bottom': '4rem'},
      ),
      css('.rise').styles(
        raw: {'animation': 'rise 0.8s cubic-bezier(0.22, 1, 0.36, 1) both'},
      ),
      css('.d1').styles(raw: {'animation-delay': '0.08s'}),
      css('.d2').styles(raw: {'animation-delay': '0.16s'}),
      css('.d3').styles(raw: {'animation-delay': '0.24s'}),
      css('.d4').styles(raw: {'animation-delay': '0.32s'}),
      css('.d5').styles(raw: {'animation-delay': '0.4s'}),
      css('.pill', [
        css('&').styles(
          display: .inlineFlex,
          padding: .symmetric(vertical: 0.4.rem, horizontal: 0.9.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(99.px),
          alignItems: .center,
          gap: .all(0.5.rem),
          color: T.muted,
          fontFamily: T.mono,
          fontSize: 0.78.rem,
          backgroundColor: Color('#12172988'),
        ),
        css('.pill-dot').styles(
          width: 8.px,
          height: 8.px,
          radius: .circular(50.percent),
          backgroundColor: Color('#4ADE80'),
          raw: {'box-shadow': '0 0 10px #4ADE80AA'},
        ),
      ]),
      css('h1').styles(
        margin: .only(top: 1.4.rem),
        fontFamily: T.display,
        fontWeight: .w800,
        letterSpacing: (-1.5).px,
        lineHeight: 1.04.em,
        raw: {'font-size': 'clamp(2.9rem, 6.5vw, 4.9rem)'},
      ),
      css('.role').styles(
        margin: .only(top: 0.9.rem),
        fontFamily: T.display,
        fontSize: 1.35.rem,
        fontWeight: .w700,
        raw: {
          'background': T.gradient,
          '-webkit-background-clip': 'text',
          'background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
        },
      ),
      css('.intro').styles(
        maxWidth: 34.rem,
        margin: .only(top: 1.2.rem),
        color: T.muted,
        fontSize: 1.06.rem,
        lineHeight: 1.75.em,
      ),
      css('.ctas').styles(
        display: .flex,
        margin: .only(top: 2.2.rem),
        flexWrap: .wrap,
        alignItems: .center,
        gap: .all(0.9.rem),
      ),
      css('.btn', [
        css('&').styles(
          display: .inlineFlex,
          padding: .symmetric(vertical: 0.85.rem, horizontal: 1.5.rem),
          radius: .circular(14.px),
          transition: Transition('all', duration: 250.ms, curve: .easeOut),
          alignItems: .center,
          gap: .all(0.55.rem),
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
      css('.socials').styles(
        display: .flex,
        margin: .only(top: 2.4.rem),
        alignItems: .center,
        gap: .all(0.7.rem),
      ),
      css('.social', [
        css('&').styles(
          display: .flex,
          width: 42.px,
          height: 42.px,
          border: .all(color: T.line, width: 1.px),
          radius: .circular(13.px),
          transition: Transition('all', duration: 250.ms, curve: .easeOut),
          justifyContent: .center,
          alignItems: .center,
          color: T.muted,
          backgroundColor: Color('#12172988'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#7C8CFF88'), width: 1.px),
          transform: .translate(y: (-3).px),
          color: T.text,
        ),
      ]),
      css('.hero-phone').styles(
        display: .flex,
        justifyContent: .center,
      ),
    ]),
    css.media(.screen(maxWidth: 980.px), [
      css('.hero .hero-in').styles(
        gridTemplate: GridTemplate(columns: GridTracks([GridTrack(.fr(1))])),
        raw: {'padding-top': '7rem'},
      ),
      css('.hero .hero-phone').styles(
        margin: .only(top: 2.rem),
      ),
      css('.hero h1').styles(
        raw: {'font-size': 'clamp(2.5rem, 10vw, 3.6rem)'},
      ),
    ]),
  ];
}
