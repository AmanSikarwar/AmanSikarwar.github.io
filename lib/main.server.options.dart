// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:portfolio/components/about.dart' as _about;
import 'package:portfolio/components/experience.dart' as _experience;
import 'package:portfolio/components/hero.dart' as _hero;
import 'package:portfolio/components/nav.dart' as _nav;
import 'package:portfolio/components/phone_frame.dart' as _phone_frame;
import 'package:portfolio/components/projects.dart' as _projects;
import 'package:portfolio/components/section_header.dart' as _section_header;
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
    ..._about.About.styles,
    ..._experience.ExperienceSection.styles,
    ..._hero.Hero.styles,
    ..._nav.Nav.styles,
    ..._phone_frame.PhoneFrame.styles,
    ..._projects.ProjectsSection.styles,
    ..._section_header.SectionHeader.styles,
  ],
);
