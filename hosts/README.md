# Hosts

More detailed specs are available on each seperate hosts' README.

- [thinkpad-e580](thinkpad-e580), my daily driver laptop (i7-8550U CPU, 16GB RAM, 512GB SSD)
- my cluster, a collection of spare computers that I use to host services for myself, friends, family and the internet. Each node particiaptes in a variety of decentralised networks.
  - [portege-r700-a](portege-r700-a), laptop (i5 M 520 CPU, 4GB RAM, 500GB HDD)
  - [portege-r700-b](portege-r700-b), laptop (i5 M 520 CPU, 4GB RAM, 320GB HDD)
  - [portege-z930](portege-z930), laptop (i5-3337U CPU, 6GB RAM, 128GB HDD)
  - [ga-z77-d3h](ga-z77-d3h), desktop (i7-3770 CPU, 32GB RAM, 750GB HDD + 500GB HDD)
- [my customised iso](iso), useful for installation and recovery

## Setup

1. Login as root.
2. `passwd joel`
3. `logout`
4. Login as joel.
5. `ssh-keygen -b 4096`
6. `cat ~/.ssh/id_rsa.pub` and save to `hosts/{host}/id_rsa.joel.pub`.
7. `sudo ssh-keygen -b 4096`
8. `sudo cat /root/.ssh/id_rsa.pub` and save to `hosts/{host}/id_rsa.root.pub`.
