import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'section_header.dart';

class SkillsSection extends StatelessComponent {
  const SkillsSection({required this.skills, super.key});

  final Skills skills;

  @override
  Component build(BuildContext context) {
    return section(id: 'skills', classes: 'skills-wrap', [
      div(classes: 'ticker', attributes: {'aria-hidden': 'true'}, [
        div(classes: 'ticker-track', [
          // Duplicated track = seamless CSS marquee loop.
          for (final _ in [0, 1])
            div(classes: 'ticker-row', [
              for (final s in skills.ticker) ...[
                span(classes: 'ticker-item', [.text(s)]),
                span(classes: 'ticker-dot', [.text('✦')]),
              ],
            ]),
        ]),
      ]),
      div(classes: 'section skills', [
        const SectionHeader(eyebrow: 'skills', title: 'The toolbox'),
        div(classes: 'skill-grid', [
          for (final g in skills.groups)
            div(classes: 'skill-group reveal glow', [
              h3([.text(g.title)]),
              div(classes: 'skill-chips', [
                for (final s in g.skills) span(classes: 'chip', [.text(s)]),
              ]),
            ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css.keyframes('ticker-scroll', {
      'from': Styles(transform: .translate(x: 0.percent)),
      'to': Styles(transform: .translate(x: (-50).percent)),
    }),
    css('.ticker', [
      css('&').styles(
        padding: .symmetric(vertical: 1.1.rem, horizontal: 0.px),
        border: Border.symmetric(
          vertical: BorderSide.solid(color: Color('var(--line-soft)'), width: 1.px),
        ),
        overflow: .hidden,
        userSelect: .none,
        backgroundColor: Color('var(--ticker-bg)'),
        raw: {
          'mask-image': 'linear-gradient(90deg, transparent, black 12%, black 88%, transparent)',
          '-webkit-mask-image': 'linear-gradient(90deg, transparent, black 12%, black 88%, transparent)',
        },
      ),
      css('.ticker-track').styles(
        display: .flex,
        width: .maxContent,
        raw: {'animation': 'ticker-scroll 36s linear infinite'},
      ),
      css('&:hover .ticker-track').styles(
        raw: {'animation-play-state': 'paused'},
      ),
      css('.ticker-row').styles(
        display: .flex,
        alignItems: .center,
        gap: .all(1.6.rem),
        raw: {'padding-right': '1.6rem'},
      ),
      css('.ticker-item').styles(
        color: T.muted,
        fontFamily: T.mono,
        fontSize: 0.92.rem,
        whiteSpace: .noWrap,
      ),
      css('.ticker-dot').styles(
        color: T.accent,
        fontSize: 0.7.rem,
      ),
    ]),
    css('.skills', [
      css('.skill-grid').styles(
        display: .grid,
        gap: .all(1.4.rem),
        raw: {'grid-template-columns': 'repeat(auto-fit, minmax(min(19rem, 100%), 1fr))'},
      ),
      css('.skill-group', [
        css('&').styles(
          padding: .all(1.6.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(20.px),
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          backgroundColor: Color('var(--glass)'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#FFA96B55'), width: 1.px),
          transform: .translate(y: (-4).px),
        ),
        css('h3').styles(
          margin: .only(bottom: 1.rem),
          color: T.accent2,
          fontFamily: T.mono,
          fontSize: 0.9.rem,
          fontWeight: .w500,
        ),
      ]),
      css('.skill-chips').styles(
        display: .flex,
        flexWrap: .wrap,
        gap: .all(0.5.rem),
      ),
    ]),
  ];
}
