---
title: Recovery & Backup Strategy
module: 07
tags: [MCPi, recovery, backup, systemd, rsync, failover, maintenance]
status: active
version: 1.0
created: 2025-05-30
updated: 2025-05-30
author: Chris
---

# Recovery
## Overview
This module outlines the process for recovering or restoring MCPi in the event of failure, corruption, or relocation. It is designed to be understandable by someone with minimal technical experience, assuming physical access to the device and basic familiarity with navigating a desktop or terminal environment.

## Objectives
- Use `rsync`-based compressed snapshots.
- Auto-backup schedule: Managed via `systemd` timer.
- Secure access: Backup archives stored encrypted and/or inside protected directories.
- Recovery trigger: A special directory `/Recovery` is browsable when drive is externally connected.

## Backup Details
- Backup location: `/mnt/mcpi_data/backups/`
- Format: `mcpi-YYYY-MM-DD_HH-MM.tar.gz`
- Contents: Selected critical directories:
	- `/etc`
	- `/home`
	- `/var/www`
	- `/mnt/mcpi_data/configs`
	- `/mnt/mcpi_data/scripts`

### Auto Cleanup
Old backups older than 14 days are deleted automatically by the script.

### Trigger Path (External Recovery Access)
If the NAS drive is plugged into another device, the recovery archive becomes visible at:
```
/mnt/mcpi_data/Recovery/
```

## Recovery Procedure
### Option A: From the Pi (recommended)

1. Boot into Raspbian or MCPi environment
2. Open terminal:
```bash
cd /mnt/mcpi_data/backups/
tar -xzf mcpi-YYYY-MM-DD_HH-MM.tar.gz -C /
```
3. Reboot after extraction completes.

### Option B: From another machine
#### macOS (run-recovery.command)
1. Step 1
2. Step 2
3. Step 3
4. Step 4
5. Script contents below:
```sh
#!/bin/bash

DEVICE_ID=$(scutil --get ComputerName)

if [[ "$DEVICE_ID" == "MCPi" ]]; then
  osascript -e 'display alert "Access Denied" message "This recovery image cannot be opened from MCPi."'
  exit 1
fi

PASS=$(osascript -e 'Tell application "System Events" to display dialog "Enter Recovery Password:" default answer "" with hidden answer' -e 'text returned of result')

if [[ "$PASS" == "YourRecoveryPassword" ]]; then
  open "$(dirname "$0")/.."
else
  osascript -e 'display alert "Incorrect Password" message "Access denied."'
fi
```

#### Linux (`run-recovery.sh`)
1. Plug in the NAS HDD.
2. Auto-run will mount and open a window asking for a password.
3. `README.md` has all instructions needed to run recovery process and generate new SD card image.
4. If auto-run fails to load, or open new window, navigate to the drive in a window manager, and run the file for whichever system you're running.
5. Script contents below:
```sh
#!/bin/bash

DEVICE_ID=$(hostname)

# Prevent access if running on MCPi
if [[ "$DEVICE_ID" == "MCPi" ]]; then
  echo "❌ Recovery is not accessible from MCPi."
  exit 1
fi

zenity --password --title="Enter Recovery Password" | while read PASS; do
  if [[ "$PASS" == "YourRecoveryPassword" ]]; then
    xdg-open "$(dirname "$0")/.."  # Open Recovery folder
  else
    zenity --error --text="Incorrect password."
    exit 1
  fi
done
```

#### Windows (run-recovery.bat)
1. Step 1
2. Step 2
3. Step 3
4. Step 4
5. Script contents below:
```sh
@echo off
setlocal

set "DeviceName=%COMPUTERNAME%"
if /I "%DeviceName%"=="MCPI" (
    echo Access Denied. Cannot run recovery on MCPi.
    pause
    exit /b
)

set /p Password=Enter Recovery Password: 

if "%Password%"=="YourRecoveryPassword" (
    start "" "%~dp0.."
) else (
    echo Incorrect password.
    pause
)

endlocal
```

## Backup Schedule

### Location: 
```bash
/etc/systemd/system/mcpi-backup.timer
```
 
Runs daily at 3:00 AM:
```ini
[Timer]
OnCalendar=*-*-* 03:00:00
Persistent=true
```

### Paired Service: 
```bash
/etc/systemd/system/mcpi-backup.service
```

Runs:
```json
/usr/local/bin/mcpi-backup.sh
```

### Manual Run
```bash
sudo systemctl start mcpi-backup.service
```

## Passwords & Secrets
- Backup archives are stored in readable .tar.gz format for simplicity.
- Encrypted files (e.g., gocryptfs) are inaccessible unless mounted via authorized scripts.
- External access to /Recovery can be locked with filesystem permissions if desired.

## Verification
Run after backup to ensure it’s accessible:
```bash
ls -lh /mnt/mcpi_data/backups/mcpi-*.tar.gz
```

Check logs:
```bash
journalctl -u mcpi-backup.service
```

## Related Files

- `mcpi-backup.sh`: Backup script
- `mcpi-backup.service` and `mcpi-backup.timer`: `systemd` units
- `mount-pe.sh`: Mounts the encrypted PureEmpathy directory
- `/etc/fstab` or `/etc/systemd/system/mnt-mcpi_data-PureEmpathy.mount`: Optional auto-mount

## Notes

- This system is designed for redundancy and transparency.
- The goal is to make backup and recovery routine, invisible, and reliable.

  

> Reminder: If power loss or I/O interruption occurs during a backup, the archive may be corrupt. Always verify!

[← Return to System Map](../MCPi_systemMap.md)
