# WSL tools

## fix-dns-resolver

This script fixes the DNS resolver in WSL. Running `fix-dns-resolver.sh` script as root will fix the DNS resolution problems. The DNS server will be set to `8.8.8.8`, this can be changed in the script directly. Tested with Ubuntu 20.04 and higher.

### Installing without cloning the repo

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf # First fix the DNS manually

apt install -y wget
wget https://raw.githubusercontent.com/loupeznik/utils/master/wsl/wsl.conf
wget -O - https://raw.githubusercontent.com/loupeznik/utils/master/wsl/fix-dns-resolver.sh | sudo bash
```
