# Utility scripts

<img alt="Python" src="https://img.shields.io/badge/python%20-%2314354C.svg?&style=for-the-badge&logo=python&logoColor=white"/><img alt="Shell Script" src="https://img.shields.io/badge/shell_script%20-%23121011.svg?&style=for-the-badge&logo=gnu-bash&logoColor=white"/>

## Repo description

Set of custom utility scripts made for working mainly with Linux systems

## Included scripts

### backup_utils

Utilities for backing up files on Linux systems. Written in bash.

- backup_to_mega
  - Script for backing up files to Mega.nz cloud drive
- db_backup
  - Script for backing up MySQL databases via mysqldump
- vscode-backup
  - Script for backing up Visual Studio Code configuration files and extensions

### setup_utils

Scripts for automatically setting up various Linux programs and utilities. Written in bash.

- ts3server-setup
  - Script for setting up TeamSpeak 3 server on Debian-based distros. It also sets up additional packages like Apache2, PHP, dotnet 3.1, [TS3AudioBot](https://github.com/Splamy/TS3AudioBot) and [TS3Viewer dashboard](https://github.com/Loupeznik/ts3viewer-php).

### teamspeak3_linux_utils

Scripts for working with TeamSpeak3 server logs and TeamSpeak3 server service configuration files.

### pdf_utils
- pdfmerger
  - Merges various PDF files

### dotfiles

Custom dotfiles for Linux

### prometheus

Configuration and service files for Prometheus (monitoring system)

### cloud_utils

Scripts useful with emphemeral cloud machines (eg. Google Cloud Shell), mainly used for setting up the machine's temporary working environment and executing
various scripts and tasks.

### flutter

Collection of scripts to automate publishing of Flutter applications

## Unmaintained or not very useful utilities

### mwRenamer

Python script for fixing CoD: Modern Warfare (2019) crashes. The issue causing the crashes has since been resolved, so this is kinda useless now.

### nmap_scan

Python script for nmap scanning operations. The script was never fully implemented and only serves some basic functions.
