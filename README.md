# amansikarwar — portfolio

Personal portfolio of **Aman Sikarwar**, Mobile App Developer. Built with
[Jaspr](https://jaspr.site) (Dart) as a fully static site.

## Editing content

All portfolio content lives in `/content` as markdown with YAML frontmatter —
no Dart changes needed to update it:

```
content/
  profile.md         # name, tagline, bio, socials, stats
  skills.md          # skill ticker + grouped skills
  experience/*.md    # one file per role
  projects/*.md      # one file per project (accent color, links, tech, ...)
```

Content is parsed at build time and baked into the HTML. Sanity-check it with:

```sh
dart run tool/check_content.dart
```

## Develop & build

```sh
jaspr serve    # dev server on http://localhost:8080
jaspr build    # static output in build/jaspr/
```

## Deploy

Pushes to `main` deploy to GitHub Pages via `.github/workflows/deploy.yml`.
The base path is derived from the repository name automatically (user page
vs. project page).
