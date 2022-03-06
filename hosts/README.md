# Hosts

More detailed specs are available on each seperate hosts' README.

- [thinkpad-e580](thinkpad-e580#readme), my daily driver laptop (i7-8550U CPU, 16GB RAM, 512GB SSD)
- my cluster, a collection of spare computers that I use to host services for myself, friends, family and the internet. Each node participates in a variety of decentralised networks.
  - [portege-r700-a](portege-r700-a#readme), laptop (i5 M 520 CPU, 4GB RAM, 500GB HDD)
  - [portege-r700-b](portege-r700-b#readme), laptop (i5 M 520 CPU, 4GB RAM, 320GB HDD)
  - [portege-z930](portege-z930#readme), laptop (i5-3337U CPU, 6GB RAM, 128GB SSD)
  - [ga-z77-d3h](ga-z77-d3h#readme), desktop (i7-3770 CPU, 32GB RAM, 750GB HDD + 500GB HDD)

## Setup

### Passwords and Keys

1. Login as root.
2. `passwd joel`
3. `logout`
4. Login as joel.
5. `ssh-keygen -b 4096`
6. `cat ~/.ssh/id_rsa.pub` and save to `hosts/$(hostname)/keys/ssh-joel.pub`.
7. `sudo ssh-keygen -b 4096`
8. `sudo cat /root/.ssh/id_rsa.pub` and save to `hosts/$(hostname)/keys/ssh-root.pub`.

### Services

#### nix-serve

1. Login as root.
   `sudo su`
2. `cd /var`
3. `nix-store --generate-binary-cache-key nix.$(hostname).joel.tokyo binary-cache.pem binary-cache.pub`
4. Enable the nix-serve service. <!-- chown: invalid user: ‘nix-serve’ -->
5. `chown nix-serve binary-cache.pem && chmod 600 binary-cache.pem`
6. `cat /var/binary-cache.pub` and save to `hosts/$(hostname)/keys/binary-cache.pub`
