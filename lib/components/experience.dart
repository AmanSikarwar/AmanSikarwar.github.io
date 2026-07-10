import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'section_header.dart';

class ExperienceSection extends StatelessComponent {
  const ExperienceSection({required this.roles, super.key});

  final List<Experience> roles;

  @override
  Component build(BuildContext context) {
    return section(id: 'experience', classes: 'section xp', [
      const SectionHeader(eyebrow: 'experience', title: 'Where I\'ve shipped'),
      div(classes: 'xp-line', [
        for (final r in roles)
          div(classes: 'xp-item reveal', [
            div(classes: 'xp-dot', []),
            div(classes: 'xp-card', [
              div(classes: 'xp-top', [
                div([
                  h3([.text(r.role)]),
                  span(classes: 'xp-company', [.text(r.company)]),
                ]),
                div(classes: 'xp-meta', [
                  span(classes: 'xp-period', [.text(r.period)]),
                  span(classes: 'xp-loc', [.text(r.location)]),
                ]),
              ]),
              div(classes: 'md', [RawText(r.bodyHtml)]),
              div(classes: 'xp-tags', [
                for (final t in r.tags) span(classes: 'chip', [.text(t)]),
              ]),
            ]),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.xp', [
      css('.xp-line').styles(
        position: .relative(),
        padding: .only(left: 2.rem),
        raw: {
          'background':
              'linear-gradient(180deg, #7C8CFF66, #22D3EE33 70%, transparent) no-repeat left top / 2px 100%',
        },
      ),
      css('.xp-item').styles(
        position: .relative(),
        padding: .only(bottom: 3.rem),
      ),
      css('.xp-dot').styles(
        position: .absolute(top: 10.px, left: (-2.35).rem),
        width: 13.px,
        height: 13.px,
        border: .all(color: T.accent, width: 2.px),
        radius: .circular(50.percent),
        backgroundColor: T.bg,
        raw: {'box-shadow': '0 0 12px #7C8CFF88'},
      ),
      css('.xp-card', [
        css('&').styles(
          padding: .all(1.8.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(20.px),
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          backgroundColor: Color('#12172966'),
        ),
        css('&:hover').styles(
          border: .all(color: Color('#7C8CFF55'), width: 1.px),
          transform: .translate(y: (-4).px),
          raw: {'box-shadow': '0 18px 44px #00000055'},
        ),
      ]),
      css('.xp-top').styles(
        display: .flex,
        margin: .only(bottom: 1.2.rem),
        flexWrap: .wrap,
        justifyContent: .spaceBetween,
        gap: .all(0.6.rem),
      ),
      css('h3').styles(
        fontFamily: T.display,
        fontSize: 1.25.rem,
        fontWeight: .w700,
      ),
      css('.xp-company').styles(
        color: T.accent,
        fontSize: 0.95.rem,
        fontWeight: .w600,
      ),
      css('.xp-meta').styles(
        display: .flex,
        flexDirection: .column,
        alignItems: .end,
        color: T.faint,
        fontFamily: T.mono,
        fontSize: 0.8.rem,
      ),
      css('.xp-tags').styles(
        display: .flex,
        margin: .only(top: 0.4.rem),
        flexWrap: .wrap,
        gap: .all(0.5.rem),
      ),
    ]),
    // Shared chip (also used by projects/skills).
    css('.chip').styles(
      display: .inlineBlock,
      padding: .symmetric(vertical: 0.28.rem, horizontal: 0.75.rem),
      border: .all(color: T.line, width: 1.px),
      radius: .circular(99.px),
      transition: Transition('all', duration: 200.ms),
      color: T.muted,
      fontFamily: T.mono,
      fontSize: 0.75.rem,
      backgroundColor: Color('#181F3688'),
    ),
    css('.chip:hover').styles(
      border: .all(color: Color('#22D3EE66'), width: 1.px),
      color: T.text,
    ),
    css.media(.screen(maxWidth: 720.px), [
      css('.xp .xp-line').styles(padding: .only(left: 1.3.rem)),
      css('.xp .xp-dot').styles(position: .absolute(top: 10.px, left: (-1.65).rem)),
      css('.xp .xp-meta').styles(alignItems: .start),
    ]),
  ];
}
