import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/models.dart';
import '../styles/theme.dart';
import 'icons.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessComponent {
  const ProjectsSection({required this.projects, super.key});

  final List<Project> projects;

  static const _linkLabels = {
    'playstore': 'Play Store',
    'appstore': 'App Store',
    'github': 'GitHub',
  };

  static const _platformIcons = {
    'iOS': 'apple',
    'Android': 'android',
    'Web': 'globe',
    'CLI': 'terminal',
  };

  @override
  Component build(BuildContext context) {
    final featured = projects.where((x) => x.featured).toList();
    final rest = projects.where((x) => !x.featured).toList();

    return section(id: 'projects', classes: 'section projects', [
      const SectionHeader(eyebrow: 'projects', title: 'Apps on the shelf'),
      div(classes: 'proj-grid', [
        for (final proj in featured) _card(proj, featured: true),
      ]),
      div(classes: 'proj-grid proj-grid-small', [
        for (final proj in rest) _card(proj, featured: false),
      ]),
    ]);
  }

  Component _card(Project proj, {required bool featured}) {
    final primary = proj.links.entries.firstOrNull;

    return article(
      classes: 'proj reveal${featured ? '' : ' proj-small'}',
      styles: Styles(raw: {'--pa': proj.accent}),
      [
        div(classes: 'proj-top', [
          div(classes: 'proj-icon', [.text(proj.title[0])]),
          div(classes: 'proj-id', [
            h3([.text(proj.title)]),
            span(classes: 'proj-tagline', [.text(proj.tagline)]),
          ]),
          if (primary != null)
            a(classes: 'get', href: primary.value, target: .blank, [
              .text(primary.key == 'github' ? 'CODE' : 'GET'),
            ]),
        ]),
        if (featured) div(classes: 'md proj-body', [RawText(proj.bodyHtml)]),
        div(classes: 'proj-foot', [
          div(classes: 'proj-platforms', [
            for (final p in proj.platforms)
              if (_platformIcons[p] != null)
                span(classes: 'platform', attributes: {'title': p}, [
                  Icon(_platformIcons[p]!, size: 15),
                  .text(p),
                ]),
          ]),
          div(classes: 'proj-links', [
            for (final MapEntry(key: k, value: v) in proj.links.entries.skip(1))
              a(classes: 'proj-link', href: v, target: .blank, [.text(_linkLabels[k] ?? k)]),
          ]),
        ]),
        div(classes: 'proj-tech', [
          for (final t in proj.tech) span(classes: 'chip', [.text(t)]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.projects', [
      css('.proj-grid').styles(
        display: .grid,
        gap: .all(1.4.rem),
        raw: {'grid-template-columns': 'repeat(auto-fit, minmax(320px, 1fr))'},
      ),
      css('.proj-grid-small').styles(
        margin: .only(top: 1.4.rem),
      ),
      css('.proj', [
        css('&').styles(
          position: .relative(),
          display: .flex,
          padding: .all(1.7.rem),
          border: .all(color: T.line, width: 1.px),
          radius: .circular(22.px),
          overflow: .hidden,
          transition: Transition('all', duration: 300.ms, curve: .easeOut),
          flexDirection: .column,
          gap: .all(1.2.rem),
          backgroundColor: Color('#12172966'),
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
            'box-shadow': '0 22px 48px #00000055, 0 0 40px color-mix(in srgb, var(--pa) 12%, transparent)',
          },
        ),
        css('&:hover::before').styles(
          opacity: 1,
        ),
      ]),
      css('.proj-top').styles(
        display: .flex,
        alignItems: .center,
        gap: .all(1.rem),
      ),
      css('.proj-icon').styles(
        display: .flex,
        width: 54.px,
        height: 54.px,
        radius: .circular(15.px),
        flex: .none,
        justifyContent: .center,
        alignItems: .center,
        color: T.bg,
        fontFamily: T.display,
        fontSize: 24.px,
        fontWeight: .w800,
        raw: {
          'background': 'linear-gradient(145deg, var(--pa), color-mix(in srgb, var(--pa) 60%, #0B0E1A))',
          'box-shadow': '0 8px 20px color-mix(in srgb, var(--pa) 30%, transparent)',
        },
      ),
      css('.proj-id').styles(
        flex: .grow(1),
        raw: {'min-width': '0'},
      ),
      css('h3').styles(
        fontFamily: T.display,
        fontSize: 1.15.rem,
        fontWeight: .w700,
      ),
      css('.proj-tagline').styles(
        display: .block,
        color: T.muted,
        fontSize: 0.86.rem,
      ),
      css('.get', [
        css('&').styles(
          padding: .symmetric(vertical: 0.42.rem, horizontal: 1.1.rem),
          radius: .circular(99.px),
          flex: .none,
          transition: Transition('all', duration: 250.ms, curve: .easeOut),
          fontFamily: T.mono,
          fontSize: 0.78.rem,
          fontWeight: .w500,
          raw: {
            'color': 'var(--pa)',
            'background': 'color-mix(in srgb, var(--pa) 16%, transparent)',
          },
        ),
        css('&:hover').styles(
          color: T.bg,
          raw: {'background': 'var(--pa)'},
        ),
        css('&:active').styles(
          transform: .scale(0.94),
        ),
      ]),
      css('.proj-body p').styles(
        margin: .only(bottom: 0.7.rem),
        fontSize: 0.94.rem,
        lineHeight: 1.7.em,
      ),
      css('.proj-foot').styles(
        display: .flex,
        margin: .only(top: .auto),
        flexWrap: .wrap,
        justifyContent: .spaceBetween,
        alignItems: .center,
        gap: .all(0.6.rem),
      ),
      css('.proj-platforms').styles(
        display: .flex,
        gap: .all(0.9.rem),
      ),
      css('.platform').styles(
        display: .inlineFlex,
        alignItems: .center,
        gap: .all(0.35.rem),
        color: T.faint,
        fontSize: 0.8.rem,
      ),
      css('.proj-link', [
        css('&').styles(
          color: T.accent2,
          fontFamily: T.mono,
          fontSize: 0.8.rem,
        ),
        css('&:hover').styles(
          textDecoration: TextDecoration(line: .underline),
        ),
      ]),
      css('.proj-tech').styles(
        display: .flex,
        flexWrap: .wrap,
        gap: .all(0.45.rem),
      ),
    ]),
  ];
}
