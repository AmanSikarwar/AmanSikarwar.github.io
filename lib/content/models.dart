/// Typed views over the markdown content in /content.
///
/// All fields come from frontmatter; `bodyHtml` is the rendered markdown body.
library;

class Profile {
  const Profile({
    required this.name,
    required this.role,
    required this.tagline,
    required this.intro,
    required this.email,
    required this.location,
    required this.socials,
    required this.stats,
    required this.availability,
    required this.web3formsKey,
    required this.bodyHtml,
    this.photo,
  });

  final String name;
  final String role;
  final String tagline;
  final String intro;
  final String email;
  final String location;
  final Map<String, String> socials;
  final List<({String value, String label})> stats;
  final String availability;

  /// Web3Forms access key; empty hides the contact form.
  final String web3formsKey;

  /// Relative path to the profile photo (under web/), null to omit.
  final String? photo;
  final String bodyHtml;
}

class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.tags,
    required this.bodyHtml,
  });

  final String company;
  final String role;
  final String period;
  final String location;
  final List<String> tags;
  final String bodyHtml;
}

class Project {
  const Project({
    required this.title,
    required this.tagline,
    required this.featured,
    required this.accent,
    required this.platforms,
    required this.tech,
    required this.links,
    required this.bodyHtml,
    this.role,
    this.icon,
    this.phone = true,
  });

  final String title;
  final String tagline;
  final bool featured;

  /// Whether the app may appear on the hero phone's home screen.
  final bool phone;
  final String accent;
  final List<String> platforms;
  final List<String> tech;
  final Map<String, String> links;
  final String? role;

  /// Relative path to the real app icon (under web/); letter tile if null.
  final String? icon;
  final String bodyHtml;

  /// Anchor id of this project's card, e.g. "syncubator-control".
  String get slug =>
      title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');
}

class Contribution {
  const Contribution({
    required this.project,
    required this.context,
    required this.stars,
    required this.lang,
    required this.accent,
    required this.pr,
    required this.merged,
    required this.bodyHtml,
  });

  final String project;

  /// One-line description of the upstream project.
  final String context;
  final String stars;
  final String lang;
  final String accent;

  /// Pull request URL; the repo URL is everything before `/pull/`.
  final String pr;
  final bool merged;
  final String bodyHtml;
}

class SkillGroup {
  const SkillGroup({required this.title, required this.icon, required this.skills});

  final String title;
  final String icon;
  final List<String> skills;
}

class Skills {
  const Skills({required this.ticker, required this.groups});

  final List<String> ticker;
  final List<SkillGroup> groups;
}

class SiteContent {
  const SiteContent({
    required this.profile,
    required this.experience,
    required this.projects,
    required this.contributions,
    required this.skills,
  });

  final Profile profile;
  final List<Experience> experience;
  final List<Project> projects;
  final List<Contribution> contributions;
  final Skills skills;
}
