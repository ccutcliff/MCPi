---
title: Storage and NAS Configuration
module: 04
tags: [MCPi, samba, nas, storage, file sharing]
status: complete
version: 1.1
created: 2025-05-18
updated: 2025-05-20
author: Chris
---

# Storage & NAS Configuration
This module documents the persistent mounting of an external USB drive and the configuration of Samba to enable networked file sharing, turning MCPi into a basic NAS.

## Objectives
- [x] External USB drive mounted persistently
- [x] Samba installed and configured
- [x] Shared folders created and permissions verified
- [x] Accessible from macOS and local network
- [x] User Maritza added with read/write access
- [x] Permissions masked to group-only
- [x] Remote access tested over VPN

## Mount Configuration
Persistent mount to `/mnt/mcpi_data` via `/etc/fstab`:
```bash
UUID=<drive-uuid> /mnt/mcpi_data ext4 defaults,nofail 0 2
```
Check UUID:
```bash
sudo blkid
```
Confirm mount:
```bash
df -h
```
**Primary Share Folder:**
```bash
/mnt/mcpi_data/shared/grid
```

## Samba Setup
Install:
```bash
sudo apt install samba
```
Edit `/etc/samba/smb.conf`:
```ini
[grid]
   comment = The Grid - Shared Storage
   path = /mnt/mcpi_data/shared/grid
   browseable = yes
   read only = no
   guest ok = no
   valid users = chris maritza
   create mask = 0660
   directory mask = 2770
   force group = mcpiusers
```
Restart Samba:
```bash
sudo systemctl restart smbd
```
Add Samba users:
```bash
sudo smbpasswd -a chris
sudo smbpasswd -a maritza
```
Ensure group membership:
```bash
sudo usermod -aG mcpiusers chris
sudo usermod -aG mcpiusers maritza
```

## Shell Umask (File Creation Permissions)
Update `~/.bashrc` for group-write defaults:
```bash
umask 0007
```
Apply changes:
```bash
source ~/.bashrc
```

## Firewall Rules
Allow Samba traffic on LAN:
```bash
sudo ufw allow from 192.168.1.0/24 to any app Samba
```
Check status:
```bash
sudo ufw status verbose
```

## Shares Overview
Run:
```bash
smbclient --list=MCPi
```
Expected output:
```bash
Sharename       Type    Comment
---------       ----    -------
Grid            Disk    The Grid - Shared Storage
MCPi-setup      Disk    MCPi System Info
IPC$            IPC     IPC Service (Samba 4.13.13-Debian)
SMB1 disabled -- no workgroup available
```

## User Permissions
|User|Access|Notes|
|---|---|---|
|chris|read/write|Full access|
|maritza|read/write|Group mcpiusers, Samba user|

## Recovery Share — MCPi-setup
Provide read-only access to MCPi documentation:
```ini
[MCPi-setup]
   path = /mnt/mcpi_data/mcpi_setup
   comment = MCPi Setup Documentation
   browseable = yes
   read only = yes
   valid users = maritza
```

## Validation & Testing
|Task|Status|Notes|
|---|---|---|
|Drive auto-mounts at boot|✅|Verified via /etc/fstab|
|Samba share visible from macOS|✅|Connected via Finder|
|smbclient login works (Chris)|✅|File transfer confirmed|
|File permissions via Samba OK|✅|0660 / group-owned mcpiusers|
|Shell umask adjusted|✅|umask 0007 confirms perms|
|Maritza access verified|✅|Read/write to grid share|
|MCPi-setup share verified|✅|Read-only works as expected|

## File Locations
- Mount config: `/etc/fstab`
- Samba config: `/etc/samba/smb.conf`
- Mount path: `/mnt/mcpi_data/`
- Shared folder: `/mnt/mcpi_data/shared/grid/`
- Setup docs: `/mnt/mcpi_data/mcpi_setup/`

## Notes
- Auto-mount confirmed stable on reboot.
- All shared files inherit `mcpiusers` group ownership.
- Maritza and Chris have full access to shared storage.
- Additional backup, sync, or encryption features may be added later.

## Roadmap Considerations (Potential Upgrades)

- Add `Syncthing` or `rsync` for secure remote file sync
- Consider encrypted at-rest storage with `LUKS` or `eCryptfs` 
- Add storage usage monitoring via cron + email/log
- Automate drive health checks (SMART, fsck monitoring)

[← Return to System Map](../MCPi_systemMap.md)
