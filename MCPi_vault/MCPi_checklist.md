# MCPi Setup Checklist

Use this to track progress as you configure your modular Raspberry Pi server.

## COMPLETE
- [x] [Firewall configured and logged via UFW](02_firewall.md)
- [x] [WireGuard VPN operational](03_dns-ads-vpn.md)
- [x] [Samba NAS drive mounted and shared](04_storage-nas.md)
- [x] [Pi-hole active and blocking ads](03_dns-ads-vpn.md)
- [x] [Radicale calendar server installed](06_calendar-server.md)
- [x] [Confirm full Samba accessibility from Mac](04_storage-nas.md)

## IN PROGRESS
- [ ] [Finalize Radicale access on all devices](06_calendar-server.md)
- [x] [Test remote NAS access over VPN](04_storage-nas.md)

## TESTING & HARDENING
- [x] Confirm Pi-hole DNS is LAN-restricted (port 53 not open to internet)
- [ ] Verify UFW rules against restore script (`02_firewall.md`)
- [ ] Perform external port scan (`nmap`) via VPN (`03_dns-ads-vpn.md`)
- [ ] Save and test full SD card backup (`99_backup-and-maintenance.md`)

## SYSTEM EXTENSIONS
- [ ] Backup system image with `rpi-clone` or `dd` (`99_backup-and-maintenance.md`)
- [ ] Setup automated maintenance cron jobs (`99_backup-and-maintenance.md`)
- [ ] Integrate `.md` files into shared web dashboard (optional future module)

[← Return to System Map](../MCPi_systemMap.md)
