---
title: DNS, Ad Blocking, and VPN
module: 03
tags: [MCPi, module, security, pihole, wireguard, dns, vpn, privacy]
status: complete
version: 1.2
created: 2025-05-18
updated: 2025-05-21
author: Chris
dependencies: [01, 02]
tested_on: [Raspberry Pi OS Lite (Bullseye, 32-bit)]
last_tested: 2025-05-21
---
# DNS, Ad Blocking, and VPN
This module consolidates privacy-related services: DNS filtering through Pi-hole, DNSSEC-enabled forwarding, and encrypted remote access via WireGuard VPN.

## Objectives
- [x] Pi-hole installed and active
- [x] Static IP assigned and resolvable
- [x] DNS forwarding and blocking rules configured
- [x] WireGuard VPN server operational
- [x] iPhone WireGuard profile exported and imported
- [x] VPN-enforced DNS leak protection added
- [x] Remote NAS access tested over VPN
- [x] Maritza WireGuard profile created, imported, and verified
- [ ] 
## Pi-hole Configuration
- **Interface**: `eth0` (static IP)
- **Web UI**: `http://192.168.1.99/admin`
- **Blocklists**: Default + additional custom entries
- **Conditional forwarding**: Enabled (optional for LAN hostname resolution)

Pi-hole handles local DNS queries and upstream forwarding (e.g., to Cloudflare DNS over HTTPS).

## WireGuard Configuration
- **Server port**: `51820`/ UDP
- **Tunnel interface**: `wg0`
- **Keypair**: Stored at `/etc/wireguard/`
- **Client config file**: `iPhone.conf`
- **Status check**:
```bash
  sudo wg show
```

Example `iPhone.conf`:
```bash
[Interface]
PrivateKey = <iphone-private.key>
Address = 10.0.0.*/24
DNS = 10.0.0.1

[Peer]
# Peer name, e.g. "iPhone"
PublicKey = <server_public.key>
Endpoint = cmrk.ddns.net:51820
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
```

## Firewall and Routing Rules
WireGuard server (`wg0`) automatically applies the following `iptables` rules when activated with `wg-quick`:
```bash
# Enable traffic forwarding for VPN
iptables -A FORWARD -i wg0 -j ACCEPT
iptables -A FORWARD -o wg0 -j ACCEPT

# NAT all VPN traffic through the Pi's physical network interface
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Redirect all VPN DNS traffic to Pi-hole (TCP + UDP port 53)
iptables -t nat -A PREROUTING -i wg0 -p udp --dport 53 -j DNAT --to-destination 10.0.0.1
iptables -t nat -A PREROUTING -i wg0 -p tcp --dport 53 -j DNAT --to-destination 10.0.0.1
```

## DNS Leak Protection
These rules ensure DNS requests from any VPN client are forced through Pi-hole, regardless of app behavior or client-side config. No hardcoded external DNS resolvers (e.g., Google, Cloudflare) can bypass this route.

## Testing Steps
    ✅ Test DNS filtering locally (block known ad domains)
    ✅ Test VPN connection from mobile network
    ✅ Check DNS leak status while connected; all DNS resolves via Pi-hole
    ✅ Confirm local network access (e.g., SMB share) via VPN tunnel

## Files and Paths
	/etc/wireguard/wg0.conf
    /etc/pihole/
    /etc/dnsmasq.d/
    /etc/wireguard/clients/
	    /chris-iphone.conf
	    /maritza-iphone.conf
	    /chris-macbook.conf
	    /maritza-macbook.conf

## Notes
- Dynamic DNS is configured using No-IP (`ddclient`)
- DNS leak test results confirmed:
	- **Public IP**: Home IP (expected when routing full traffic)
	- **DNS servers**: Cloudflare (routed via Pi-hole, as intended)
- Future enhancement: Pi-hole as DNS-over-HTTPS server (via `cloudflare`)
- VPN keeps all outbound traffic private while away from home
- DNS leak protection verified via `iptables` firewall rules
- Remote NAS access confirmed over VPN from mobile network

[← Return to System Map](../MCPi_systemMap.md)
