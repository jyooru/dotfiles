---
layout: page
title: Setup
---

## Passwords and Keys

1. Login as root.
2. `passwd joel`
3. `logout`
4. Login as joel.
5. `ssh-keygen -b 4096`
6. `cat ~/.ssh/id_rsa.pub` and save to `hosts/$(hostname)/keys/ssh-joel.pub`.
7. `sudo ssh-keygen -b 4096`
8. `sudo cat /root/.ssh/id_rsa.pub` and save to `hosts/$(hostname)/keys/ssh-root.pub`.

## Services

### nix-serve

1. Login as root.
   `sudo su`
2. `cd /var`
3. `nix-store --generate-binary-cache-key nix.$(hostname).joel.tokyo binary-cache.pem binary-cache.pub`
4. Enable the nix-serve service. <!-- chown: invalid user: ‘nix-serve’ -->
5. `chown nix-serve binary-cache.pem && chmod 600 binary-cache.pem`
6. `cat /var/binary-cache.pub` and save to `hosts/$(hostname)/keys/binary-cache.pub`
