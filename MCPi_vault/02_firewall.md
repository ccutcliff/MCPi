---
title: Firewall
module: 02
tags: [MCPi, module, security, ufw, firewall]
status: complete
version: 1.1
created: 2025-05-18
updated: 2025-06-02
author: Chris
dependencies: [01]
tested_on: [Raspberry Pi OS Lite (Bullseye 32-bit)]
last_tested: 2025-05-18
---
# Firewall
This module documents MCPi’s firewall configuration using UFW (Uncomplicated Firewall) to secure exposed services and log inbound access attempts.

## Objectives
- [x] Install and enable UFW
- [x] Create baseline allow rules for essential services
- [x] Block all non-specified inbound traffic
- [x] Enable logging
- [x] Verify rule set persists across reboots

## Current UFW Rules
```bash
sudo ufw status verbose
```

Example output:
```bash
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       192.168.1.0/24   # SSH (LAN only)
51820/udp                  ALLOW       Anywhere         # WireGuard VPN
137,138/udp                ALLOW       192.168.1.0/24   # Samba NetBIOS
139,445/tcp                ALLOW       192.168.1.0/24   # Samba SMB
53/udp                     ALLOW       192.168.1.0/24   # DNS (Pi-hole)
80,443/tcp                 ALLOW       192.168.1.0/24   # HTTP/S (future use)
5232/tcp                   ALLOW       192.168.1.0/24   # Radicale (CalDAV)
```

##  Verification Steps
- Use sudo ufw status verbose to confirm all expected rules
- Confirm services function as expected from allowed IPs
- Use external VPN to test denial from unauthorized IPs

## Hardening Tasks
- External nmap scan from VPN tunnel
- Compare ufw status with saved backup script
- Regularly audit logs with:
```bash
sudo less /var/log/ufw.log
```

##  Files and Tools
- `/etc/ufw/`
- `ufw CLI`
- Optional restore script: `scripts/ufw-restore.sh` (recommended to create)

## Notes
- Only LAN subnets have Samba access — ensures no open SMB ports to WAN/VPN
- WireGuard UDP port exposed intentionally for VPN access
- Logging set to low to capture basic event data without overfilling logs

[← Return to System Map](../MCPi_systemMap.md)
