/// Self-check: parses all /content markdown and asserts the shape is sane.
/// Run from repo root: dart run tool/check_content.dart
library;

import 'package:portfolio/content/loader.dart';

void main() {
  final c = loadContent();
  assert(c.profile.name == 'Aman Sikarwar');
  assert(c.profile.socials.containsKey('github'));
  assert(c.profile.stats.isNotEmpty);
  assert(c.profile.bodyHtml.contains('<p>'));
  assert(c.experience.length == 2);
  assert(c.experience.first.bodyHtml.contains('<li>'));
  assert(c.projects.length == 14);
  assert(c.projects.where((p) => p.featured).length == 3);
  assert(c.projects.every((p) => p.accent.startsWith('#')));
  assert(c.skills.ticker.isNotEmpty && c.skills.groups.length == 5);
  print('content OK: ${c.projects.length} projects, ${c.experience.length} roles');
}
