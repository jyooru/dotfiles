## Setup

### Termux ([com.termux](https://f-droid.org/en/packages/com.termux/))

1. `pkg install openssh`
2. `ssh-keygen -b 4096 -C "com.termux@galaxy-a22"`
3. `cat ~/.ssh/id_rsa.pub` and save to `hosts/galaxy-a22/com.termux/id_rsa.pub`
4. Copy the following config:
   - `./com.termux/ssh_config`
   - `/etc/ssh/ssh_known_hosts`
