## Setup

### Material Files ([me.zhanghai.android.files](https://f-droid.org/packages/me.zhanghai.android.files/))

1. `ssh-keygen -b 4096 -C "me.zhanghai.android.files@galaxy-a22" -f ./me.zhanghai.android.files/id_rsa`
2. In app -> Add storage -> SFTP server:

   | Field          | Value                                    |
   | -------------- | ---------------------------------------- |
   | Hostname       | ga-z77-d3h.dev.joel.tokyo                |
   | Port           | 2201                                     |
   | Path           | srv                                      |
   | Name           | File server                              |
   | Authentication | Public key                               |
   | Username       | joel                                     |
   | Private key    | `cat ./me.zhanghai.android.files/id_rsa` |

   | Field          | Value                                    |
   | -------------- | ---------------------------------------- |
   | Hostname       | thinkpad-e580.dev.joel.tokyo             |
   | Port           |                                          |
   | Path           |                                          |
   | Name           | thinkpad-e580                            |
   | Authentication | Public key                               |
   | Username       | joel                                     |
   | Private key    | `cat ./me.zhanghai.android.files/id_rsa` |

3. `rm ./me.zhanghai.android.files/id_rsa`

### Termux ([com.termux](https://f-droid.org/en/packages/com.termux/))

1. `pkg install openssh`
2. `ssh-keygen -b 4096 -C "com.termux@galaxy-a22"`
3. `cat ~/.ssh/id_rsa.pub` and save to `hosts/galaxy-a22/com.termux/id_rsa.pub`
4. Copy the following config:
   - `./com.termux/ssh_config`
   - `/etc/ssh/ssh_known_hosts`
