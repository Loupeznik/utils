#/usr/bin/env bash

# CHECK IF SCRIPT IS RUN AS ROOT
if [[ $EUID -ne 0 ]]; then
   echo "[ERROR] This script must be run as root"
   exit 1
fi

# INSTALL NEEDED PACKAGES
apt install ocrmypdf tesseract-ocr-ces
wget https://github.com/schollz/croc/releases/download/v9.2.0/croc_9.2.0_Linux-64bit.deb
dpkg -i croc_9.1.4_Linux-64bit.deb
rm croc_9.1.4_Linux-64bit.deb

# SET ORIGIN FILE LOCATION AND BEGIN OCR
read -p "Enter a PDF location: " input
ocrmypdf -l ces $input output.pdf
