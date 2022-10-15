#!/usr/bin/env bash

# CHECK IF SCRIPT IS RUN AS ROOT
if [[ $EUID -ne 0 ]]; then
   echo "[ERROR] This script must be run as root"
   exit 1
fi

# Check if arguments are present
if [[ $# -eq 0 ]]; then
    echo "[ERROR] No arguments supplied - Specify the OCR language as the first argument"
    exit 1
fi

# Check if language exists
package=$(apt-cache search --names-only "^tesseract-ocr-$1")

if [[ -z "$package" ]]; then
   echo "[ERROR] Package for specified language not found"
fi

# INSTALL NEEDED PACKAGES
echo "[INFO] Installing packages"
apt install -y ocrmypdf tesseract-ocr-$1 &>/dev/null

# SET ORIGIN FILE LOCATION AND BEGIN OCR
read -p "Enter a PDF location: " input
echo "[INFO] Performing OCR on $input"
ocrmypdf -l $1 $input output.pdf
