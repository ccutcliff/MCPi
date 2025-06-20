---
title: MCPi System Map
tags: [system-map, overview, mcpivault]
created: 2025-05-18
updated: 2025-05-18
description: "Central index of modular configuration for the Master Control Pi (MCPi) a Raspberry Pi home server."
---

# MCPi System Map

Welcome to the Master Control Pi (MCPi) server hub. Use this as your control panel for all core modules and active tasks. Click through to individual module files for full setup details.

## Modules
| Module | Description |
|--------|-------------|
| [Core Config](modules/00_core-config.md) | Hostname, users, SSH keys, apt hygiene |
| [Networking](modules/01_networking.md) | Static IP, DNS, router setup |
| [Firewall](modules/02_firewall.md) | UFW config, logging, default deny |
| [DNS + VPN](modules/03_dns-ads-vpn.md) | Pi-hole, WireGuard, DNS redirect |
| [Storage & NAS](modules/04_storage-nas.md) | Drive mount, Samba config |
| [Media Server](modules/05_media-server.md) | (Optional) DLNA or Jellyfin |
| [Calendar Server](modules/06_calendar-server.md) | Radicale setup, DAV sync |
| [Backup & Maintenance](modules/99_backup-and-maintenance.md) | SD backup, cron jobs, clone strategy |

## Active Tasks
> Pulled from [MCPi_checklist.md](MCPi_checklist.md)
- [ ] Finalize Radicale access on all devices
- [ ] Test remote NAS access over VPN
- [ ] Verify UFW rules against restore script
- [ ] Perform external port scan (nmap) from VPN
- [ ] Save and test a full SD card backup

## Notes
- This vault is synced between your Raspberry Pi and MacBook via Samba.
- Store all `.md` files in this folder or subfolders to keep the structure modular and maintainable.
- For a full setup status and completed items, see: [MCPi_setupChecklist.md](MCPi_checklist.md)