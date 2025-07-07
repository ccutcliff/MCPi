---
title: Media Server Configuration
module: 05
tags: [MCPi, media, jellyfin, streaming, DLNA]
status: planned
version: 1.0
created: 2025-05-18
updated: 2025-05-18
author: Chris
---

# Media Server Configuration

This module outlines plans and configuration steps for turning MCPi into a lightweight media server, capable of streaming local content to other devices on the network.

## Objectives

- [ ] Install and configure a media server (e.g. Jellyfin)
- [ ] Serve content from `/mnt/grid/media`
- [ ] Enable DLNA support
- [ ] Confirm playback on local and remote devices

## Media Server Options

### Jellyfin (Preferred)

Free and open-source alternative to Plex.

```bash
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
sudo apt install jellyfin
```

Access at: `http://<192.168.1.99:8096`

### MiniDLNA (Lightweight)

```bash
sudo apt install minidlna
```

Edit config:

```ini
media_dir=/mnt/mcpi_data/grid/media
friendly_name=MCPi DLNA
```

Restart service:

```bash
sudo systemctl restart minidlna
```

### Firewall Rules (if needed)

```bash
sudo ufw allow 8096/tcp  # for Jellyfin
sudo ufw allow 8200/tcp  # for DLNA control
sudo ufw allow 1900/udp  # for DLNA discovery
```

## Future Enhancements

- Enable remote media access via VPN
- Optional: Subtitle download integration
- Optional: Mobile app support (Jellyfin apps exist for iOS/Android)

## Notes

- Media server integration is optional but aligns with the Pi’s role as a home utility server.
- Resource use should be monitored; DLNA is lighter than Jellyfin but lacks rich UI.

[← Return to System Map](../MCPi_systemMap.md)
