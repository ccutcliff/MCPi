---
title: Core Configuration
module: 00
tags: [MCPi, module, core, ssh, security]
status: complete
version: 1.2
created: 2025-05-18
updated: 2025-06-02
author: Chris
dependencies: [none]
tested_on: [Raspberry Pi OS Lite (Bullseye 32-bit)]
last_tested: 2025-05-18
---

# Core Configuration

This module defines the foundational setup for MCPi. It includes hostname, timezone, user management, basic package setup, and SSH hardening. All other modules build on this configuration.

## Overview
- Hostname: `mcpi`
- User: `pi` (default; consider adding a secondary admin user if desired)
- OS: Raspberry Pi OS (Debian-based)
- SSH: Public key auth, password login disabled
- Packages: UFW, fail2ban, sudo, curl, wget, git, openssh-server

## Configuration Steps

### Set Hostname
```bash
sudo hostnamectl set-hostname mcpi
```
### Update & Upgrade System
```bash
sudo apt update && sudo apt upgrade -y
```

### Create Secondary Admin User (optional)
```bash
sudo adduser chris
sudo usermod -aG sudo chris
```

### Setup SSH Access
- Ensure openssh-server is installed.
- Copy your public key to the Pi:
```bash
ssh-copy-id pi@<pi-ip>
```
- Edit /etc/ssh/sshd_config:
```bash
PasswordAuthentication no
PermitRootLogin no
```
- Restart SSH:
```bash
sudo systemctl restart ssh
```

### Install Essential Packages
```bash
# Security
sudo apt install ufw fail2ban -y

# Admin Tools
sudo apt install sudo curl wget git -y
```

## Security Notes
- UFW is configured in its own module.
- Fail2ban defaults are sufficient for SSH.
- Root login is disabled.
- SSH key authentication is mandatory.
- ⚠️ If enabling remote access, consider changing SSH port and implementing login rate-limits.

## Verification
- Hostname correctly set
- OS up to date
- SSH accessible by key only
- Basic security packages installed

## Notes
- Consider setting up motd or a login banner for informational or legal purposes.
- Store SSH private keys securely.
- Monitor logs via journalctl -u ssh for any suspicious activity.

[← Return to System Map](../MCPi_systemMap.md)


# ========== Old ==========
---
title: Core Configuration
module: 00
tags: [MCPi, module, core, ssh, security]
status: complete
version: 1.0
created: 2025-05-18
updated: 2025-05-18
author: Chris
dependencies: []
tested_on: [Raspberry Pi OS Bookworm (32-bit)]
last_tested: 2025-05-18
---

---
title: Core Configuration
module: 00
tags: [MCPi, module, layer:core, service:ssh, security]
status: complete
version: 1.1
created: 2025-05-18
updated: 2025-06-02
author: Chris
dependencies: []
tested_on: [Raspberry Pi OS Bookworm (32-bit)]
last_tested: 2025-05-18
---
