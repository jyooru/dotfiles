# dotfiles

my linux [dotfiles](https://dotfiles.github.io/)

## installation

clone the repo:

```sh
git clone https://github.com/jyooru/dotfiles.git ~/.dotfiles
```

run [install.sh](install.sh):

```sh
cd ~/.dotfiles
./install.sh
```

### certificate

to install a cyberhound certificate automatically, run the following command on the needed network:

```bash
curl -Lks "https://raw.githubusercontent.com/jyooru/dotfiles/main/install/certificate.sh" > /tmp/certificate.sh &&
chmod +x /tmp/certificate.sh &&
/tmp/certificate.sh &&
rm /tmp/certificate.sh
```

## license

see [license](license) for details
