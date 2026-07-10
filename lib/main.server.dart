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
    // Set by CI for project-page deployments (e.g. /portfolio/).
    base: const String.fromEnvironment('BASE_PATH', defaultValue: '/'),
    meta: {
      'description': _description,
      'og:title': _title,
      'og:description': _description,
      'og:type': 'website',
    },
    head: [
      // Apply a stored theme choice before first paint (no flash of wrong theme).
      script(
        content: "try{var t=localStorage.getItem('theme');"
            "if(t)document.documentElement.setAttribute('data-theme',t)}catch(e){}",
      ),
      .element(
        tag: 'meta',
        attributes: {'name': 'theme-color', 'content': '#100C13', 'media': '(prefers-color-scheme: dark)'},
      ),
      .element(
        tag: 'meta',
        attributes: {'name': 'theme-color', 'content': '#FAF5F0', 'media': '(prefers-color-scheme: light)'},
      ),
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
