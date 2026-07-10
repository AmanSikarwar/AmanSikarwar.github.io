/// The entrypoint for the **server** environment, used during static pre-rendering.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

const _title = 'Aman Sikarwar — Mobile App Developer';
const _description =
    'Native iOS (SwiftUI) and Flutter developer with App Store–shipped apps — '
    'from pixel-perfect UI to real-time backends and cloud infrastructure.';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    title: _title,
    lang: 'en',
    meta: {
      'description': _description,
      'og:title': _title,
      'og:description': _description,
      'og:type': 'website',
      'theme-color': '#0B0E1A',
    },
    head: [
      link(rel: 'icon', type: 'image/svg+xml', href: 'icon.svg'),
      link(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
      link(rel: 'preconnect', href: 'https://fonts.gstatic.com', attributes: {'crossorigin': ''}),
      link(
        rel: 'stylesheet',
        href: 'https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=JetBrains+Mono:wght@400;500&display=swap',
      ),
    ],
    body: App(),
  ));
}
