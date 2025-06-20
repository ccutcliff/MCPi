---
title: Security Overview and Hardening
module: 98
tags: [MCPi, security, hardening, best-practices, privacy]
status: draft
version: 0.1
created: 2025-06-02
updated: 2025-06-02
author: Chris
---
# Security Overview and Hardening

This module outlines MCPi's overall security posture, hardening practices, and recommended ongoing maintenance tasks to ensure the system remains secure and resilient.

## Security Principles
- **Least privilege:** Only open and allow services necessary for MCPi's operation.
- **Layered defense:** Combine network firewall, VPN, DNS filtering, and system hardening.
- **Privacy-first:** Enforce DNS leak protection and limit exposure of services externally.
- **Audit and monitor:** Maintain logs, perform regular audits, and review alerts.
- **Update promptly:** Keep OS, firmware, and software components up to date.

## Current Security Features
- UFW firewall restricts inbound connections by IP and service.
- WireGuard VPN provides encrypted remote access with strict routing rules.
- Pi-hole enforces DNS filtering and blocks ads and trackers network-wide.
- DNS leak protection via iptables forces VPN clients to use Pi-hole.
- Dynamic DNS configured with No-IP for remote access without exposing raw IP.
- Samba access limited to LAN subnet only.
- Logs available for firewall (ufw.log), Pi-hole (query logs), and WireGuard status.

## Recommended Hardening and Maintenance
- Regularly apply OS and firmware updates (consider testing on a backup system).
- Create and securely store encrypted backups of configuration files and critical data.
- Monitor logs weekly for unusual activity.
- Consider implementing intrusion detection (e.g., fail2ban) to protect SSH and VPN services.
- Secure physical access to MCPi hardware.
- Plan and implement multi-factor authentication (MFA) for critical services and VPN access.
- Regularly audit and rotate WireGuard keys and Pi-hole admin password.

## Future Security Enhancements
- Implement centralized authentication with open-source SSO (e.g., Keycloak, Authelia).
- Explore Pi-hole DNS-over-HTTPS (DoH) setup for encrypted DNS queries.
- Add alerting mechanisms for suspicious network or system events.
- Integrate hardware security modules (HSM) or trusted platform modules (TPM) if hardware supports it.

## Incident Response Plan
- Maintain a documented process for isolating MCPi from the network if compromised.
- Keep backup recovery media ready for rapid restoration.
- Review and revoke VPN keys immediately upon suspected compromise.
- Periodically test restore procedures to ensure data integrity.

---

[← Return to System Map](../MCPi_systemMap.md)