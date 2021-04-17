#!/bin/bash

########################################################
## VS Code Settings and Extensions backup/sync script ##
## Script prints all intalled VSC extensions into a ####
## txt file to be installed on another machine #########
## Script backs up settings and keybindings cfg files ##
########################################################

echo "VS Code Settings and Extensions backup script"
echo "By Loupeznik (https://github.com/Loupeznik)"
echo "---------------------------------------------"
echo "[GENERAL] Setting up output folder"
out_folder="vscode-$(date +%Y-%m-%d)"
cfg_folder="/home/$USER/.config/Code/User/"
if [ -d $out_folder ]; then
	echo "[GENERAL] Backup for today already exists, do you wish to remove the previous backup?"
	echo "[GENERAL] Press y to continue, any other key to exit"
	while : ; do
		read -n 1 k <&1
	if [[ $k = y ]]; then
		echo ""
		echo "[GENERAL] Removing previous backup and performing a new one"
		rm -rf $out_folder
		break
	else
		echo ""
		echo "[GENERAL] Exiting"
		exit 0
	fi
	done
fi
mkdir $out_folder
echo "[SETTINGS] Backing up your config files"
if [ ! -f $cfg_folder/keybindings.json ]; then
	echo "[SETTINGS] Keybindings config file not found, backing up settings.json only"
	tar -czf $out_folder/config.tar.gz -C $cfg_folder settings.json
else
	tar -czf $out_folder/config.tar.gz -C $cfg_folder settings.json keybindings.json
fi
echo "[EXTENSIONS] Exporting your extensions"
code --list-extensions | xargs -L 1 echo code --install-extension > $out_folder/code-extensions-install
echo "[GENERAL] Backup complete"
