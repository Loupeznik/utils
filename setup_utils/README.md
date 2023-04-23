# Setup utils

## zsh-setup

Sets up zsh and oh-my-zsh for local user. To install, simply run the `zsh-setup.sh` script (as non-root user)

Currently supported distributions:
- Debian-based
- Arch-based
- RHEL-based
- SUSE-based

### Installing without cloning the repo

```bash
apt install -y wget
wget -O - https://raw.githubusercontent.com/loupeznik/utils/master/setup_utils/zsh-setup.sh | bash
```
