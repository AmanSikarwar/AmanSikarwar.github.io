---
title: VPatch
tagline: Wearable vital monitoring for neonates
featured: false
accent: "#FB7185"
icon: images/apps/VPatch.png
platforms: [Android, iOS]
tech: [Flutter, ESP32, Arduino, MQTT, BLE]
links:
  github: https://github.com/syncubator-A11/vital-monitoring-patch
---

Hardware + app system for continuous neonatal vital monitoring: an
ESP32-based wearable patch streams skin temperature, heart rate and SpO₂
over MQTT from MAX30205/MAX30105 sensors, and a Flutter app displays live
readings with history and analytics, persisting vitals locally for review.
