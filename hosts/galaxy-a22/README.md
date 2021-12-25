## Setup

### Termux

1. `pkg install openssh`
2. `ssh-keygen -b 4096 -C "termux.galaxy-a22`
3. `cat ~/.ssh/id_rsa.pub` and save to `hosts/$(hostname)/id_rsa.pub`
4. Copy the following config:
   - `./ssh_config`
   - `/etc/ssh/ssh_known_hosts`
