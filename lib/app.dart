import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'components/hero.dart';
import 'components/nav.dart';
import 'content/loader.dart';

/// Single-page portfolio. Loads /content at build time and assembles sections.
/// Server-only: static pre-rendering bakes the content into HTML.
class App extends AsyncStatelessComponent {
  const App({super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final content = loadContent();

    return .fragment([
      Nav(email: content.profile.email),
      main_([
        Hero(profile: content.profile, projects: content.projects),
      ]),
    ]);
  }
}
