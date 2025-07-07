---
title: MCPi Roadmap
tags: [roadmap, progress, system-planning]
created: 2025-05-23
updated: 2025-05-23
description: "Versioned roadmap for MCPi modules, updates, and future enhancements."
---

# MCPi Roadmap

> This roadmap tracks the evolution of MCPi across major versions and modules.  
> For completed steps, see the Checklist.

## Roadmap Philosophy

MCPi uses a modular versioning approach to track core functionality upgrades, security hardening, feature expansion, and infrastructure resilience. This allows each service to evolve without affecting the others. Versions are cumulative, with rollback notes when necessary.

## Version Log

### Completed
- Hostname, users, SSH lockdown `00_core-config`
- Static IP & Pi-hole DNS routing `01_networking`, `03_dns-ads-vpn`
- Pi-hole running and resolving local `.lan` domains
- WireGuard VPN connects and tunnels traffic privately
- Samba NAS is up and accessible from local network
- Firewall rules set to default deny + custom service allow list

### Notes

- VPN handshake success: major milestone
- Pi-hole resolves `pihole.mcpi.lan`, but admin redirect still returns `403` on direct access
- Radicale server up, but multi-device auth is inconsistent

### In Progress

- Finalize Radicale credentials across devices `06_calendar-server`
- Conduct external port scan from remote VPN (`nmap`) `03_dns-ads-vpn`
- Confirm firewall restores consistently from script `02_firewall`
- Add reverse proxy config to handle `403` from Pi-hole root
- Add admin redirect middleware in Caddy for friendly Pi-hole interface

### Planned

- Save a working clone image via `rpi-clone` or `dd`
- Restore test to verify integrity
- Add cron-based job rotation (e.g., Pi-hole gravity update, WireGuard health check)
- Explore snapshot backup of config `.md` files to Git

### Proposed

- DLNA or Jellyfin media server `05_media-server`
- Encrypted external cloud sync
- Tailscale or Cloudflare Tunnel integration
- Web-based dashboard to serve `.md` content (Obsidian Publish-style or static site)

### Module Review to add to roadmap
- Add a centralized Security Overview module (done — 98_security.md draft started).
    
- Implement fail2ban or similar for brute force protection on SSH and VPN.
    
- Consider multi-factor authentication on VPN clients.
    
- Schedule periodic WireGuard key rotation and password updates.
    
- Monitor and alert on unusual VPN or firewall logs.
    
- Add encrypted backups with an automated schedule.
    
- Evaluate dynamic DNS provider security or move to self-hosted DDNS if feasible.

| Feature | Justification |
|--------|----------------|
| **Syncthing/rsync** | For remote file sync/backup across devices |
| **Encrypted storage** | Add protection for sensitive NAS data |
| **Storage monitoring** | Alert for drive space or failure risk |
| **Health check automation** | Add resilience via SMART, fsck, etc. |

## Linked Resources

- [System Map](MCPi_systemMap)
- [Checklist](MCPi_checklist)
- [Backup & Maintenance](99_backup-and-maintenance)
