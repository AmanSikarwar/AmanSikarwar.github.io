import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../styles/theme.dart';

/// Eyebrow styled as a code comment + display title.
class SectionHeader extends StatelessComponent {
  const SectionHeader({required this.eyebrow, required this.title, super.key});

  final String eyebrow;
  final String title;

  @override
  Component build(BuildContext context) {
    return div(classes: 'sec-head reveal', [
      span(classes: 'sec-eyebrow', [.text('// $eyebrow')]),
      h2([.text(title)]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.sec-head', [
      css('&').styles(
        margin: .only(bottom: 3.rem),
      ),
      css('.sec-eyebrow').styles(
        color: T.accent2,
        fontFamily: T.mono,
        fontSize: 0.88.rem,
      ),
      css('h2').styles(
        margin: .only(top: 0.6.rem),
        fontFamily: T.display,
        fontWeight: .w800,
        letterSpacing: (-0.5).px,
        lineHeight: 1.1.em,
        raw: {'font-size': 'clamp(1.9rem, 4vw, 2.7rem)'},
      ),
    ]),
  ];
}
