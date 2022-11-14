#!/usr/bin/env bash

sudo apt update -y
sudo apt install -y zsh wget git curl

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install OhMyZSH plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Download fonts to manually install later
cd ~/Downloads
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# Copy .zshrc
cp ~/.zshrc ~/.zshrc.old

cp ../dotfiles/.zshrc ~/.zshrc

# Change default shell and start ZSH
sudo chsh --shell /usr/bin/zsh $USER
zsh
