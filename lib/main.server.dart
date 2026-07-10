/// The entrypoint for the **server** environment, used during static pre-rendering.
library;

import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    title: 'Aman Sikarwar — Mobile App Developer',
    lang: 'en',
    body: App(),
  ));
}
