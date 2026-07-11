import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';
import 'section_header.dart';

class ContributionsSection extends StatelessComponent {
  const ContributionsSection({required this.contributions, super.key});

  final List<Contribution> contributions;

  @override
  Component build(BuildContext context) {
    return section(id: 'oss', classes: 'section oss', [
      const SectionHeader(eyebrow: 'open source', title: 'Patches sent upstream'),
      div(classes: 'oss-grid', [
        for (final c in contributions) _card(c),
      ]),
    ]);
  }

  Component _card(Contribution c) {
    final prNumber = c.pr.split('/').last;
    final repo = c.pr.split('/pull/').first;

    return article(classes: 'oss-card reveal glow', styles: Styles(raw: {'--pa': c.accent}), [
      div(classes: 'oss-top', [
        div(classes: 'oss-id', [
          h3([a(href: repo, target: .blank, [.text(c.project)])]),
          span(classes: 'oss-context', [.text(c.context)]),
        ]),
        span(classes: 'oss-badge${c.merged ? '' : ' open'}', [
          .text(c.merged ? 'MERGED' : 'OPEN'),
        ]),
      ]),
      div(classes: 'md oss-body', [RawText(c.bodyHtml)]),
      div(classes: 'oss-foot', [
        span(classes: 'oss-meta', [.text('★ ${c.stars}')]),
        span(classes: 'oss-meta', [.text(c.lang)]),
        a(classes: 'oss-pr', href: c.pr, target: .blank, [
          Icon('github', size: 15),
          .text('PR #$prNumber'),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.oss', [
      css('.oss-grid').styles(
        display: .grid,
        gap: .all(1.4.rem),
        raw: {'grid-template-columns': 'repeat(auto-fit, minmax(min(21rem, 100%), 1fr))'},
      ),
      css('.oss-card', [
        css('&').styles(
          display: .flex,
          position: .relative(),
          padding: .all(1.7.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(22.px),
          overflow: .hidden,
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          flexDirection: .column,
          gap: .all(1.rem),
          backgroundColor: Color('var(--glass)'),
        ),
        css('&::before').styles(
          content: '',
          position: .absolute(top: 0.px, left: 0.px, right: 0.px),
          height: 2.px,
          opacity: 0,
          transition: Transition('opacity', duration: 300.ms),
          raw: {'background': 'linear-gradient(90deg, transparent, var(--pa), transparent)'},
        ),
        css('&:hover').styles(
          transform: .translate(y: (-6).px),
          raw: {
            'border-color': 'color-mix(in srgb, var(--pa) 45%, transparent)',
            'box-shadow': '0 22px 48px var(--shadow), 0 0 40px color-mix(in srgb, var(--pa) 12%, transparent)',
          },
        ),
        css('&:hover::before').styles(
          opacity: 1,
        ),
      ]),
      css('.oss-top').styles(
        display: .flex,
        justifyContent: .spaceBetween,
        alignItems: .start,
        gap: .all(1.rem),
      ),
      css('h3 a', [
        css('&').styles(
          color: T.text,
          fontFamily: T.display,
          fontSize: 1.15.rem,
          fontWeight: .w700,
        ),
        css('&:hover').styles(
          raw: {'color': 'var(--pa)'},
        ),
      ]),
      css('.oss-context').styles(
        display: .block,
        margin: .only(top: 0.15.rem),
        color: T.muted,
        fontSize: 0.86.rem,
      ),
      css('.oss-badge').styles(
        padding: .symmetric(vertical: 0.3.rem, horizontal: 0.7.rem),
        radius: .circular(99.px),
        flex: .none,
        color: Color('#34D399'),
        fontFamily: T.mono,
        fontSize: 0.7.rem,
        fontWeight: .w600,
        backgroundColor: Color('#34D3991F'),
      ),
      css('.oss-badge.open').styles(
        color: T.accent2,
        backgroundColor: Color('#FF7A9C1F'),
      ),
      css('.oss-body p').styles(
        margin: .only(bottom: 0.rem),
        fontSize: 0.94.rem,
        lineHeight: 1.7.em,
      ),
      css('.oss-foot').styles(
        display: .flex,
        margin: .only(top: .auto),
        alignItems: .center,
        gap: .all(1.1.rem),
      ),
      css('.oss-meta').styles(
        color: T.faint,
        fontFamily: T.mono,
        fontSize: 0.8.rem,
      ),
      css('.oss-pr', [
        css('&').styles(
          display: .inlineFlex,
          margin: .only(left: .auto),
          alignItems: .center,
          gap: .all(0.4.rem),
          color: T.accent2,
          fontFamily: T.mono,
          fontSize: 0.8.rem,
        ),
        css('&:hover').styles(
          textDecoration: TextDecoration(line: .underline),
        ),
      ]),
    ]),
  ];
}
