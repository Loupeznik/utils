#!/bin/bash

# TEAMSPEAK3 SERVER SETUP SCRIPT CREATED BY Loupeznik (https://github.com/Loupeznik)
# THIS SCRIPT IS DIRECTED TOWARDS DEBIAN/UBUNTU BASED DISTROS AND REQUIRES TO BE RUN AS ROOT
# ADDITIONAL (MANUAL) SETUP FOR WEB DASHBOARD AND TS3AUDIOBOT IS NEEDED

# CHECK IF SCRIPT IS RUN AS ROOT
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# UPGRADE AND INSTALL PACKAGES
apt update && apt upgrade -y
apt install python3 python3-pip php php-curl apache2 certbot python-certbot-apache composer libopus-dev ffmpeg wget curl unzip tar git -y
# SET UP DIRECTORIES
mkdir /home/teamspeak/
useradd teamspeak -d /home/teamspeak
mkdir /tmp/ts3-setup/
cd /tmp/ts3-setup/
# SET UP TS3AUDIOBOT AND DEPENDENCIES
wget https://github.com/Splamy/TS3AudioBot/releases/download/0.11.0/TS3AudioBot_dotnet_core_3.1.zip
wget https://download.visualstudio.microsoft.com/download/pr/f54a9098-69e6-4914-8fa8-42cb4ed05e65/9daae40d4a0ea4ad7aa2fc014b5f20db/dotnet-runtime-3.1.12-linux-x64.tar.gz
mkdir /opt/dotnet
tar -zxvf dotnet-runtime-3.1.12-linux-x64.tar.gz -C /opt/dotnet
mv dotnet/* /opt/dotnet
ln -s /opt/dotnet/dotnet /usr/bin/dotnet
mkdir /home/teamspeak/ts3audiobot
unzip TS3AudioBot_dotnet_core_3.1.zip -d /home/teamspeak/ts3audiobot
mkdir /home/teamspeak/ts3audiobot/music
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
# DOWNLOAD TEAMSPEAK3 SERVER
mkdir /home/teamspeak/teamspeak3
wget https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_linux_amd64-3.13.3.tar.bz2
tar -xvf teamspeak3-server_linux_amd64-3.13.3.tar.bz2
mv teamspeak3-server_linux_amd64/* /home/teamspeak/teamspeak3
chown -R teamspeak:teamspeak /home/teamspeak/
# SET UP SERVICES
git clone https://github.com/Loupeznik/utils.git
mv utils/teamspeak3_linux_utils/init/teamspeak /etc/init.d
mv utils/teamspeak3_linux_utils/init/ts3audiobot.service /etc/systemd/system
chmod +x /etc/init.d/teamspeak && chmod +x /etc/systemd/system/ts3audiobot.service
# SET UP VIEWER AND CORRECT PERMISSIONS
cd /var/www/html
rm index.*
git clone https://github.com/Loupeznik/ts3viewer-php.git .
composer require planetteamspeak/ts3-php-framework
chown -R www-data:www-data ./
chown -R www-data:www-data /home/teamspeak/ts3audiobot/music
# ACTIVATE SERVICES, CLEAN UP
systemctl enable ts3audiobot.service
update-rc.d teamspeak defaults
rm -rf /tmp/ts3-setup/
apt autoremove
# START SERVICES
service apache2 start
service teamspeak start
service teamspeak status >> /tmp/creds
echo "Script complete, TeamSpeak 3 server credentials can be found in /tmp/creds"
