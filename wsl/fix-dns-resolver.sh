#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "[ERROR] This script must be run as root"
   exit 1
fi

cp ./wsl.conf /etc/wsl.conf
rm /etc/resolv.conf

echo "nameserver 8.8.8.8" > /etc/resolv.conf
chattr +i /etc/resolv.conf

echo "[INFO] Finished"
