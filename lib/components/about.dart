import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'section_header.dart';

class About extends StatelessComponent {
  const About({required this.profile, super.key});

  final Profile profile;

  @override
  Component build(BuildContext context) {
    return section(id: 'about', classes: 'section about', [
      const SectionHeader(eyebrow: 'about', title: 'Builder of apps, end to end'),
      div(classes: 'about-grid', [
        div(classes: 'md about-bio reveal', [RawText(profile.bodyHtml)]),
        div(classes: 'about-stats', [
          for (final s in profile.stats)
            div(classes: 'stat reveal', [
              strong([.text(s.value)]),
              span([.text(s.label)]),
            ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.about', [
      css('.about-grid').styles(
        display: .grid,
        gridTemplate: GridTemplate(columns: GridTracks([GridTrack(.fr(1.5)), GridTrack(.fr(1))])),
        gap: .all(4.rem),
      ),
      css('.about-stats').styles(
        display: .flex,
        flexDirection: .column,
        gap: .all(1.rem),
      ),
      css('.stat', [
        css('&').styles(
          padding: .symmetric(vertical: 1.2.rem, horizontal: 1.5.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(18.px),
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          backgroundColor: Color('#12172966'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#7C8CFF55'), width: 1.px),
          transform: .translate(x: 6.px),
        ),
        css('strong').styles(
          display: .block,
          fontFamily: T.display,
          fontSize: 2.rem,
          fontWeight: .w800,
          raw: {
            'background': T.gradient,
            '-webkit-background-clip': 'text',
            'background-clip': 'text',
            '-webkit-text-fill-color': 'transparent',
          },
        ),
        css('span').styles(
          color: T.muted,
          fontSize: 0.92.rem,
        ),
      ]),
    ]),
    // Shared markdown-body styling (used by about, experience, projects).
    css('.md', [
      css('p').styles(
        margin: .only(bottom: 1.1.rem),
        color: T.muted,
        fontSize: 1.02.rem,
        lineHeight: 1.8.em,
      ),
      css('strong').styles(
        color: T.text,
        fontWeight: .w600,
      ),
      css('ul').styles(
        padding: .only(left: 1.2.rem),
        listStyle: .none,
      ),
      css('li').styles(
        position: .relative(),
        padding: .only(left: 0.4.rem),
        margin: .only(bottom: 0.7.rem),
        color: T.muted,
        lineHeight: 1.7.em,
      ),
      css('li::before').styles(
        content: '▸',
        position: .absolute(left: (-1).rem),
        color: T.accent2,
      ),
    ]),
    css.media(.screen(maxWidth: 860.px), [
      css('.about .about-grid').styles(
        gridTemplate: GridTemplate(columns: GridTracks([GridTrack(.fr(1))])),
        gap: .all(2.5.rem),
      ),
    ]),
  ];
}
