#!/bin/bash

mega-login username password #placeholder values
folders="$(mega-ls)"
cur_month="$(date +%Y-%m)"
db_folder="/home/$USER/backup/db"
temp_folder="/home/$USER/scripts/temp"
stime=$(date +"%s")
echo "[MEGA BACKUP] Starting backup script"
if [[ $folders == *$cur_month* ]]; then
	mega-logout 1>/dev/null
	echo "[MEGA BACKUP] Backup not successfull (backup for this month already exists)"
	exit 0
else
	[ ! -d "$temp_folder" ] && mkdir -p "$temp_folder"
	mega-mkdir "$cur_month"
	echo "[MEGA BACKUP] Backing up database dumps"
	for file in "$db_folder"/*; do
		if [[ $file == *$cur_month* ]]; then
			mega-put -q "$file" /"$cur_month"/
		fi
	done
	echo "[MEGA BACKUP] Backing up scripts directory"
	tar -czf "$temp_folder"/scripts.tar.gz -C /home/$USER/scripts/ *.sh *.py 2>/dev/null
	mega-put -q "$temp_folder"/scripts.tar.gz /"$cur_month"/			        #
	echo "[MEGA BACKUP] Backing up www directory"
	tar -czf "$temp_folder"/www.tar.gz -C /var/ www 2>/dev/null
	mega-put "$temp_folder"/www.tar.gz /"$cur_month"/ &>/dev/null
	echo "[MEGA BACKUP] Removing backup archives from local storage"
	rm "$temp_folder"/*
	echo "[MEGA BACKUP] Backup successfull for $cur_month"
fi
etime=$(date +"%s")
timediff=$(($etime-$stime))
echo "[MEGA BACKUP] Script took $(($timediff / 60)) minutes and $(($timediff % 60)) seconds to finish"
mega-logout 1>/dev/null
