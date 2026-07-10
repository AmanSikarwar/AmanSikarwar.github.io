// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:portfolio/components/hero.dart' as _hero;
import 'package:portfolio/components/nav.dart' as _nav;
import 'package:portfolio/components/phone_frame.dart' as _phone_frame;
import 'package:portfolio/styles/theme.dart' as _theme;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  styles: () => [
    ..._theme.globalStyles,
    ..._hero.Hero.styles,
    ..._nav.Nav.styles,
    ..._phone_frame.PhoneFrame.styles,
  ],
);
