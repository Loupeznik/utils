#!/bin/bash

########################################################
### THIS SCRIPT REMOVES ALL EXITED DOCKER CONTAINERS ###
########################################################

echo "Exited Docker Container Remover Script"
echo "By Loupeznik (https://github.com/Loupeznik)"
echo "---------------------------------------------"

# CHECK IF SCRIPT IS RUN AS ROOT
if [[ $EUID -ne 0 ]]; then
   echo "[ERROR] This script must be run as root"
   exit 1
fi

if [[ $(docker ps -a | grep Exited | cut -c 1-12) ]]; then
  echo "[GENERAL] Removing all exited containers"
  docker rm $(docker ps -a | grep Exited | cut -c 1-12)
  echo "[GENERAL] Listed containers have been removed"
else
  echo "[GENERAL] No exited containers found"
fi
