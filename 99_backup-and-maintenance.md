---
title: Backup & Maintenance
module: 99
tags: [MCPi, backup, maintenance, rpi-clone, cron, monitoring]
status: active
version: 1.0
created: 2025-05-18
updated: 2025-05-18
author: Chris
---

# Backup and Maintenance

This module tracks all system upkeep tasks and ensures **MCPi** remains stable, secure, and restorable in the event of failure.

## Objectives

- [x] Define and implement backup strategy
- [ ] Create restore image of SD card
- [ ] Automate regular maintenance tasks
- [ ] Validate system security periodically

---

## Backup Strategy

### Full System Backup (Image)

#### Option 1: `rpi-clone` (Recommended)

```bash
git clone https://github.com/billw2/rpi-clone.git
cd rpi-clone
sudo ./rpi-clone sda
```
Where `sda` is the USB target drive (verify with `lsblk`)

#### Option 2: `dd` Image Backup

```bash
sudo dd if=/dev/mmcblk0 of=/mnt/external/mcpi-backup.img bs=4M status=progress
```
**ATTENTION!**: Risk of large files and uncompressed data.

## Scheduled Backups

Add to `crontab` for weekly backups.
```cron
0 3 * * 0 /home/chris/scripts/mcpi_weekly_backup.sh
```
Consider retention policy and drive space. Log all backups.

## System Maintenance

### System Updates

```bash
sudo apt update && sudo apt upgrade -y
```

Run weekly or automate with:
```bash
0 4 * * 6 /usr/bin/apt update && /usr/bin/apt upgrade -y
```

### Disk & Resource Monitoring

- df -h for disk usage
- top or htop for memory/CPU
- Consider sysstat or vnStat for traffic

### Log Review

```bash
sudo journalctl -p 3 -xb
sudo tail -f /var/log/syslog
```

## Restore Testing

- Boot cloned SD/USB in Pi
- Confirm data and shares available
- Reconnect VPN and Pi-hole
- Calendar + Samba mount test

## Backup Contents Checklist

- Pi-hole config + blocklists
- WireGuard keys and confs
- Samba shares + mount info
- Radicale calendar .ics files
- UFW rules
- Markdown modules + checklist

All backup content ideally resides in `/mnt/external/backups/MCPi/`.

## Helpful Tools

- `rpi-clone` – Simple Pi-to-Pi backup
- `rsync` – Sync configuration or calendar files
- `cron` – Schedule automated jobs
- `ncdu` – Disk space analyzer
- `logrotate` – Clean log bloat

[← Return to System Map](../MCPi_systemMap.md)