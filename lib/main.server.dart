/// The entrypoint for the **server** environment, used during static pre-rendering.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'app.dart';
import 'main.server.options.dart';

const _title = 'Aman Sikarwar — Mobile App Developer & AI Engineer';
const _description =
    'Flutter and native SwiftUI apps shipped to both stores, real-time device '
    'platforms, and agentic AI products — portfolio of Aman Sikarwar.';
const _siteUrl = 'https://amansikarwar.dev/';

// ponytail: mirrors content/profile.md socials; update both when they change.
const _jsonLd = '''
{"@context":"https://schema.org","@type":"Person","name":"Aman Sikarwar",
"url":"$_siteUrl","jobTitle":"Mobile App Developer & AI Engineer",
"worksFor":{"@type":"Organization","name":"Profundis AI"},
"alumniOf":{"@type":"CollegeOrUniversity","name":"Indian Institute of Technology Mandi"},
"image":"${_siteUrl}images/profile.jpg",
"sameAs":["https://github.com/AmanSikarwar","https://linkedin.com/in/amansikarwar",
"https://x.com/amansikarwaar","https://www.instagram.com/amansikarwaar",
"https://www.youtube.com/@amansikarwaar","https://medium.com/@amansikarwar"]}
''';

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
      'twitter:card': 'summary_large_image',
      'twitter:title': _title,
      'twitter:description': _description,
      'twitter:image': '${_siteUrl}og.png',
      'twitter:creator': '@amansikarwaar',
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
      // Open Graph requires property= (not name=), so raw meta elements.
      for (final MapEntry(key: p, value: v) in {
        'og:title': _title,
        'og:description': _description,
        'og:type': 'website',
        'og:url': _siteUrl,
        'og:site_name': 'Aman Sikarwar',
        'og:image': '${_siteUrl}og.png',
        'og:image:width': '1200',
        'og:image:height': '630',
        'og:image:alt': 'Aman Sikarwar — Mobile App Developer & AI Engineer',
      }.entries)
        .element(tag: 'meta', attributes: {'property': p, 'content': v}),
      link(rel: 'canonical', href: _siteUrl),
      script(content: _jsonLd, attributes: {'type': 'application/ld+json'}),
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
