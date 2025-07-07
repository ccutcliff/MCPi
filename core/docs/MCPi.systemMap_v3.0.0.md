MCPi_ver3.0.0
---
title: Main Operating System
module: 00
category: infrastructure
tags: [MCPi, module, ssh, security, infrastructure]
status: complete
version: 1.2.0
created: 2025-06-28
updated: 2025-07-07T04:10 -07:00:00
author: Chris
dependencies: []
tested_on: [Raspberry Pi OS Lite (Bullseye 32-bit)]
last_tested: 2025-05-18
compatibility: [armhf, arm64]
license: MIT
---
# MCPi – Version 3.0.0

## Overview
MCPi v3.0.0 marks the shift to a **modular containerized system**, with each service isolated into its own Docker-based module. This version prioritizes maintainability, disaster recovery, and long-term modular evolution.

## Project Goals (v3.0.0)

- Modular, container-first architecture
- Portable and versioned service setup
- Isolated and recoverable environments
- Public documentation with private infrastructure

## Version History

- **v1.0.0** – Bare metal setup. Core services installed manually.
- **v2.0.0** – Containerization introduced. Services moved to Docker.
- **v3.0.0** – Modularization begins. Each service becomes a versioned module.

## Active Modules

| Module        | Version | Status       |
|---------------|---------|--------------|
| noip-client   | 1.0     | Stable       |
| ~~pihole~~    | 0.9     | Inactive     |
| samba-nas     | 2.0     | Stable       |
| wireguard*    | 1.0     | Stable       |
| adguard       | 1.0     | Stable       |
| caddy         | 1.0     | Stable       |
| homer         | 1.0     | Stable       |
| wg-easy       | 0.9     | In-progress  |
| authentik     | 0.1     | In-progress  |

```bash
MCPi/
├── docker-compose.yml         # Top-level that can "include" others or just serve as root
├── .env                       # Shared variables
├── services/
│   ├── adguard/
│   │   ├── docker-compose.yml
│   │   └── README.md
│   ├── nextcloud/
│   ├── caddy/
│   ├── homer/                 # Landing page for intranet - `https://home.mcpi.lan/`
│   └── watchtower/            # Planned Healthchecks and Container monitoring, real-time to dashboard
├── monitoring/
│   └── docker-compose.yml     # For planned Netdata or Prometheus stack
└── docs/
    └── MCPi_ver3.0.0.md        # High-level layout of services, ports, etc.
```
## MCPi Service Stack

| Service      | Folder         | Description                     |
|--------------|----------------|---------------------------------|
| Caddy        | `services/caddy/`      | Reverse proxy with HTTPS       |
| Homer        | `services/homer/`      | Dashboard                      |
| Nextcloud    | `services/nextcloud/`  | Self-hosted file sync          |
| Pi-hole      | `services/pihole/`     | DNS sinkhole & ad blocker      |
| WireGuard    | `services/wg-easy/`    | VPN with Web UI                |
| Monitoring   | `services/monitoring/` | Netdata or Prometheus stack    |

SSH Keys versus Login

## MCPi Module Install Order

> This file outlines the preferred order for container/module installation.

1. DNS - Pi-hole, AdGuard Home
2. Reverse Proxy - Caddy
3. NAS FS - Samba
4. Remote Access - WireGuard VPN
5. DDNS - No-IP Client
6. Dashboard - Homer
