import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Single-page portfolio. Sections are assembled here.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return main_([
      h1([.text('Aman Sikarwar')]),
    ]);
  }
}
