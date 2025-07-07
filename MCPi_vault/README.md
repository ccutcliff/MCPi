# Master Control Pi (MCPi)

> Privacy by default, not privilege.

**MCPi** is a modular, privacy-focused home server system built on a Raspberry Pi. It brings together open-source tools for DNS blocking, secure VPN access, local-first storage, calendar syncing, and media streaming—all in a single, self-hosted platform.

Designed to be understandable, replicable, and respectful of your data.

---

## 🧩 Core Modules

| Module | Description |
|--------|-------------|
| 🔧 [Core Config](modules/00_core-config.md) | Hostname, SSH keys, apt hygiene |
| 🌐 [Networking](modules/01_networking.md) | Static IP, DNS, and router setup |
| 🔥 [Firewall](modules/02_firewall.md) | UFW config, logging, and protection |
| 🛡️ [DNS + VPN](modules/03_dns-ads-vpn.md) | Pi-hole, WireGuard, encrypted tunneling |
| 💾 [Storage & NAS](modules/04_storage-nas.md) | External drive, Samba configuration |
| 🎞️ [Media Server](modules/05_media-server.md) | (Optional) DLNA or Jellyfin setup |
| 📅 [Calendar Server](modules/06_calendar-server.md) | Radicale for CalDAV syncing |
| 💽 [Backup & Maintenance](modules/99_backup-and-maintenance.md) | SD backups, maintenance tasks |

Each module is self-contained and documented to support iteration, troubleshooting, and knowledge transfer.

---

## 📋 Active Setup Tasks

> See [MCPi_checklist.md](MCPi_checklist.md) for full task tracking.

- [ ] Finalize Radicale access on all devices
- [ ] Test remote NAS access over VPN
- [ ] Verify UFW rules against restore script
- [ ] Perform external port scan (nmap) from VPN
- [ ] Save and test a full SD card backup

---

## 🎯 Project Goals

- 🧠 **Understandable Infrastructure** – If you can read a `.md` file, you can maintain this system
- 🔐 **Privacy by Design** – Full control over your DNS, backups, and user data
- 🧰 **Modular & Maintainable** – Each part can be independently updated, replaced, or removed
- 🌍 **Remote, Secure Access** – VPN + firewall rules let you securely access your home network from anywhere
- 💾 **Local-First** – Calendar, files, and media are yours—and stay that way

---

## 🛠️ Built With

- **Raspberry Pi OS Lite**
- **Pi-hole** for DNS ad/tracker blocking
- **WireGuard** for secure remote VPN access
- **Samba** for LAN-based file sharing
- **Radicale** for private calendar hosting
- **UFW** (Uncomplicated Firewall)
- **bash**, `cron`, and `nmap`

---

## 📜 License

- **Scripts and configuration files**: MIT License — see [`LICENSE`](LICENSE)
- **Documentation and guides**: Creative Commons Attribution 4.0 — see [`LICENSE_DOCS`](LICENSE_DOCS)

---

## ⚙️ About the Author

Hi, I'm Chris. I built MCPi to learn, tinker, and prove that open-source tools can power secure, private networks—without the cloud, and without breaking the bank.

I'm seeking opportunities in:
- 🔄 Process improvement
- 📈 Project management
- 🧩 Open-source infrastructure design (like this!)

Let’s connect!

---
