---
title: Networking
module: 01
tags: [MCPi, module, networking, dhcpcd, avahi, dns]
status: complete
version: 1.1
created: 2025-05-18
updated: 2025-06-02
author: Chris
dependencies: [00]
tested_on: [Raspberry Pi OS Lite (Bullseye 32-bit)]
last_tested: 2025-05-18
---

# Networking

This module covers MCPi’s core network configuration, ensuring stable LAN communication, consistent DNS resolution, and integration with future modules. It establishes the base layer for remote access and network-aware services.

## Objectives

- [x] Assign a static IP address to MCPi
- [x] Configure reliable local hostname resolution
- [x] Ensure DHCP reservation via router
- [x] Enable `.local` name resolution using mDNS (Avahi)
- [x] Test name and IP accessibility from LAN devices

---

## Configuration Summary

| Setting                  | Value                  | Notes                                  |
|--------------------------|------------------------|----------------------------------------|
| Static IP                | `192.168.1.99`         | Set manually in `dhcpcd.conf`          |
| Hostname                 | `mcpi.local`           | Also reflected in `/etc/hostname`      |
| Router DHCP Reservation  | Enabled (MAC binding)  | Ensures IP consistency                 |
| mDNS                     | Avahi Daemon enabled   | Enables `.local` hostname lookup       |
| DNS Resolver             | Local Pi-hole instance | Set in `/etc/resolv.conf` or DHCP push|

---

## Configuration Steps

### Set Static IP
Edit `/etc/dhcpcd.conf`:
```conf
interface eth0
static ip_address=192.168.1.99/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1
```
### Set Hostname
```bash
sudo hostnamectl set-hostname mcpi
```
Ensure hostname matches in:
- `/etc/hostname`
- `/etc/hosts`
### Enable Avahi for mDNS
```bash
sudo apt install avahi-daemon -y
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon
```

## Verification
- Test from another LAN device:
```bash
ping mcpi.local
ssh pi@mcpi.local
```
- Ensure Avahi is running:
```bash
sudo systemctl status avahi-daemon
```
- Check router DHCP lease/reservation shows the correct hostname
- If .local fails, confirm:
    - Device supports mDNS (macOS, iOS do natively)
    - Firewall or VPN isn’t interfering

## Files Modified
- /etc/dhcpcd.conf
- /etc/hostname
- /etc/hosts
- DHCP config via router interface (manual)

## Notes
- Keep the static IP outside the DHCP pool to prevent conflicts.
- mDNS works best on Apple devices out-of-the-box; Windows may require extra configuration.
- If running a VPN, you may need to bind services to the local IP or configure additional routes.

## Troubleshooting
- Hostname not resolving: Restart Avahi and ensure it’s enabled:
```bash
sudo systemctl restart avahi-daemon
```
- No SSH access: Try raw IP (ssh pi@192.168.1.99) and confirm firewall isn’t blocking port 22.
- DNS issues: Verify resolv.conf points to Pi-hole or another known-good DNS server.

[← Return to System Map](../MCPi_systemMap.md)