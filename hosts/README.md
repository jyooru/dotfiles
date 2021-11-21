## Setup

1. Login as root.
2. `passwd joel`
3. `logout`
4. Login as joel.
5. `ssh-keygen -b 4096`
6. `cat ~/.ssh/id_rsa.pub` and save to `hosts/{host}/id_rsa.joel.pub`.
7. `sudo ssh-keygen -b 4096`
8. `sudo cat /root/.ssh/id_rsa.pub` and save to `hosts/{host}/id_rsa.root.pub`.
