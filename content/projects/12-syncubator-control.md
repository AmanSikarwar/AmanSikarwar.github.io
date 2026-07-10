---
title: Syncubator Control
tagline: Remote monitoring & control for a neonatal incubator
featured: false
accent: "#2DD4BF"
icon: images/apps/syncubator.png
platforms: [Android, iOS]
tech: [Flutter, InfluxDB, AWS IoT Core, MQTT, Provider, Syncfusion]
links: {}
---

Companion app for the Syncubator neonatal incubator: live vitals dashboard
(heart rate, SpO₂, skin temperature) with historical charts, system
parameters like humidity, oxygen and bed angle, remote controls for
phototherapy, ambient lights and the radiant heater, plus a camera feed —
sensor data polled from InfluxDB and bridged to AWS IoT Core over MQTT/TLS.
