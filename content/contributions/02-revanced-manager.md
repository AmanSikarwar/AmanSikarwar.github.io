---
project: ReVanced Manager
context: Flutter app to patch and manage ReVanced on Android
stars: 28k
lang: Flutter
accent: "#7CB8FF"
pr: https://github.com/ReVanced/revanced-manager/pull/772
merged: true
---

Modernized the app's networking and notification stack. Re-implemented the
HTTP cache interceptor on dio_cache_interceptor after the unmaintained
dio_http_cache_lts blocked upgrading dio, migrated flutter_local_notifications
across its breaking changes, replaced native_dio_client with
native_dio_adapter, and pruned unused dependencies along the way.
