#!/bin/bash

mega-login username password #placeholder values
folders="$(mega-ls)"
cur_month="$(date +%Y-%m)"
db_folder="/home/pi/backup/db"
temp_folder="/home/pi/scripts/temp"
free=""
if [[ $folders == *$cur_month* ]]; then
	mega-logout 1>/dev/null
	echo MEGA BACKUP -- Záloha neúspěšná (záloha pro tento měsíc již existuje)
	exit 0
else
	mega-mkdir "$cur_month"
	for file in "$db_folder"/*; do
		if [[ $file == *$cur_month* ]]; then
			mega-put -q "$file" /"$cur_month"/
		fi
	done
	tar -czf "$temp_folder"/scripts.tar.gz /home/pi/scripts 2>/dev/null
	mega-put -q "$temp_folder"/scripts.tar.gz /"$cur_month"/
	# z nějakého kvalitního důvodu nefunguje -q přepínač vždy na posledním mega-put příkazu #
	# vyřešeno přesměrováním všeho outputu do /dev/null 				        #
	tar -czf "$temp_folder"/www.tar.gz /var/www/ 2>/dev/null
	mega-put "$temp_folder"/www.tar.gz /"$cur_month"/ &>/dev/null
	rm "$temp_folder"/*
	echo MEGA BACKUP -- záloha úspěšně provedena pro "$cur_month"
fi
mega-logout 1>/dev/null
