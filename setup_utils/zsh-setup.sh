#!/usr/bin/env bash

source /etc/os-release

if [[ "$ID_LIKE" == *"debian"* ]]; then
    echo "Detected Debian-based distribution. Using apt to install packages."
    sudo apt update
    sudo apt install -y zsh wget git curl
elif [[ "$ID_LIKE" == *"centos"* || "$ID_LIKE" == *"fedora"* || "$ID_LIKE" == *"rhel"* || "$ID" == "fedora" ]]; then
    echo "Detected RHEL-based distribution. Using yum to install packages."
    sudo yum install -y --skip-broken zsh wget git curl
elif [[ "$ID_LIKE" == *"suse"* || "$ID_LIKE" == *"opensuse"* ]]; then
    echo "Detected SUSE-based distribution. Using zypper to install packages."
    sudo zypper refresh
    sudo zypper install -y zsh wget git curl
elif [[ "$ID_LIKE" == *"arch"* ]]; then
    echo "Detected Arch Linux. Using pacman to install packages."
    sudo pacman -Syu
    sudo pacman -S --noconfirm zsh wget git curl
else
    echo "Unsupported distribution family."
    exit 1
fi

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install OhMyZSH plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Download fonts to manually install later
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P /tmp

if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p ~/.local/share/fonts
fi

mv /tmp/MesloLGS\ NF\ Regular.ttf ~/.local/share/fonts

# Copy .zshrc
cp ~/.zshrc ~/.zshrc.old

if [ -e "../dotfiles/.zshrc" ]; then
    cp "../dotfiles/.zshrc" ~/.zshrc
else
    curl -o ~/.zshrc https://raw.githubusercontent.com/Loupeznik/utils/master/dotfiles/.zshrc
fi

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >>! ~/.zshrc

# Change default shell and start ZSH
sudo chsh --shell /usr/bin/zsh $USER
zsh
