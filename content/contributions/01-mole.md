---
project: Mole
context: Clean, uninstall, analyze and monitor your Mac from the terminal
stars: 58k
lang: Shell
accent: "#FACC15"
pr: https://github.com/tw93/Mole/pull/838
merged: true
---

Reworked the orphaned-service detection in Mole's cleanup engine. Instead of
a hardcoded list of known orphan patterns, services are now detected
generically: each launchd plist is checked for whether its backing binary
still exists and whether a package manager owns it, with a protect-list
guarding against false positives. Also added cleanup of stub-only app
containers left behind by uninstalled apps, and extended the test suite to
cover the new behavior.
