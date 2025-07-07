---
title: Calendar Server (Radicale)
module: 06
tags: [MCPi, calendar, radicale, CalDAV, ICS, family]
status: active
version: 1.0
created: 2025-05-18
updated: 2025-05-18
author: Chris
---

# Calendar Server (Radicale)

This module documents the installation and configuration of a self-hosted calendar server using **Radicale**, providing CalDAV support for shared calendar access across family devices.

## Objectives

- [x] Install and run Radicale
- [ ] Finalize access across all user devices
- [ ] Harden security and authentication
- [ ] Maintain shared calendar structure

## Installation (Debian-based)

```bash
sudo apt update
sudo apt install radicale
```

Confirm it's running:
```bash
sudo systemctl status radicale
```

## Access URL

By default, Radicale runs on:
```ini
http://192.168.1.99:5232
```

To change to secure HTTPS (optional), configure Nginx or use a self-signed cert with a reverse proxy.

## User Authentication

Radicale uses plain-text auth by default (not ideal for WAN access).
Example `.htpasswd` file generation:
```bash
sudo apt install apache2-utils
htpasswd -c /etc/radicale/users chris
```

Then update Radicale config to use that file.

## Shared Calendars

Folder path: `~/.config/radicale/collections/`

Suggested structure:
```text
~/.config/radicale/collections/
└── family/
    ├── reagan.ics
    ├── kennedy.ics
    ├── chris.ics
    └── maritza.ics
```

## Integration Notes

- Apple Calendar supports CalDAV directly.
- Calendar URLs will be of the form:
```text
http://<MCPi_IP>:5232/<user>/<calendar>.ics
```

- Authentication required on most devices.
- If using VPN, local IPs can still resolve.

## Firewall Rules

```bash
sudo ufw allow 5232/tcp
```

Consider limiting to local/VPN subnets only.

## Future Enhancements

- Set up HTTPS with reverse proxy
- Sync with mobile devices automatically
- Export calendar backups regularly
- Add Web UI (e.g., Baïkal or Radicale-UI)

[← Return to System Map](../MCPi_systemMap.md)
