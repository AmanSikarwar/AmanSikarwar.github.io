/// Reads and parses the markdown files in /content. Server-only (dart:io):
/// runs during static pre-rendering, never in the browser.
library;

import 'dart:io';

import 'package:markdown/markdown.dart' as md;
import 'package:yaml/yaml.dart';

import 'models.dart';

typedef _Doc = ({Map<String, dynamic> meta, String bodyHtml});

_Doc _parse(File file) {
  final raw = file.readAsStringSync();
  final match = RegExp(r'^---\n(.*?)\n---\n?(.*)$', dotAll: true).firstMatch(raw);
  if (match == null) return (meta: <String, dynamic>{}, bodyHtml: _html(raw));
  final meta = loadYaml(match.group(1)!);
  return (
    meta: Map<String, dynamic>.from((_toPlain(meta) as Map?) ?? {}),
    bodyHtml: _html(match.group(2)!.trim()),
  );
}

String _html(String markdown) =>
    md.markdownToHtml(markdown, inlineSyntaxes: [md.InlineHtmlSyntax()]).trim();

/// Recursively converts YamlMap/YamlList to plain Dart maps/lists.
Object? _toPlain(Object? node) => switch (node) {
      YamlMap m => {for (final e in m.entries) e.key.toString(): _toPlain(e.value)},
      YamlList l => [for (final e in l) _toPlain(e)],
      _ => node,
    };

List<File> _filesIn(String dir) =>
    (Directory(dir).listSync().whereType<File>().where((f) => f.path.endsWith('.md')).toList()
      ..sort((a, b) => a.path.compareTo(b.path)));

Map<String, String> _stringMap(Object? v) =>
    {for (final e in ((v as Map?) ?? {}).entries) e.key.toString(): e.value.toString()};

List<String> _stringList(Object? v) => [for (final e in (v as List?) ?? []) e.toString()];

SiteContent loadContent({String root = 'content'}) {
  final p = _parse(File('$root/profile.md'));
  final profile = Profile(
    name: p.meta['name'] as String,
    role: p.meta['role'] as String,
    tagline: p.meta['tagline'] as String,
    intro: (p.meta['intro'] as String).trim(),
    email: p.meta['email'] as String,
    location: p.meta['location'] as String,
    socials: _stringMap(p.meta['socials']),
    stats: [
      for (final s in (p.meta['stats'] as List?) ?? [])
        (value: s['value'] as String, label: s['label'] as String),
    ],
    availability: p.meta['availability'] as String,
    web3formsKey: (p.meta['web3forms_key'] as String?) ?? '',
    bodyHtml: p.bodyHtml,
  );

  final experience = [
    for (final f in _filesIn('$root/experience'))
      () {
        final d = _parse(f);
        return Experience(
          company: d.meta['company'] as String,
          role: d.meta['role'] as String,
          period: d.meta['period'] as String,
          location: d.meta['location'] as String,
          tags: _stringList(d.meta['tags']),
          bodyHtml: d.bodyHtml,
        );
      }(),
  ];

  final projects = [
    for (final f in _filesIn('$root/projects'))
      () {
        final d = _parse(f);
        return Project(
          title: d.meta['title'] as String,
          tagline: d.meta['tagline'] as String,
          featured: (d.meta['featured'] as bool?) ?? false,
          accent: d.meta['accent'] as String,
          platforms: _stringList(d.meta['platforms']),
          tech: _stringList(d.meta['tech']),
          links: _stringMap(d.meta['links']),
          role: d.meta['role'] as String?,
          bodyHtml: d.bodyHtml,
        );
      }(),
  ];

  final s = _parse(File('$root/skills.md'));
  final skills = Skills(
    ticker: _stringList(s.meta['ticker']),
    groups: [
      for (final g in (s.meta['groups'] as List?) ?? [])
        SkillGroup(
          title: g['title'] as String,
          icon: g['icon'] as String,
          skills: _stringList(g['skills']),
        ),
    ],
  );

  return SiteContent(profile: profile, experience: experience, projects: projects, skills: skills);
}
