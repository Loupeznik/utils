#!/bin/bash

###################
## NEEDS TESTING ##
###################

cmd="$(certbot certificates)"
domains=("dzarsky.eu" "rtl.sytes.net") #certificates for hosts in order shown with "$cmd"
re="VALID: [0-9]{1,2}[^0-9]"
#nr=0
linenr=0
updated=0

if [[ $cmd =~ "Found the following certs:" ]]; then
    #echo "Found existing certificates"
		if echo "$cmd" | grep -c "Domains: " > 0 ; then
            ###############################################################################################################################
            ####### APPENDING TO domains ARRAY DOES NOT APPEAR TO WORK FOR SOME REASON, HARDCODED VALUES FROM "$cmd" INTO THE ARRAY #######
            ###############################################################################################################################
			#echo "$cmd" | grep "Domains: " | sed 's/Domains: //' | while read -r line; do
			#echo "$line" #debug
			#domains+="$line"
			#nr+=1
			#done
			echo "$cmd" | grep -oP "$re" |  sed 's/VALID: //'| while read -r line; do
			#echo "$line" #debug
			#expdates+=("$line")
				if [[ "$line" < 3 ]]; then
					certbot renew --cert-name "${domains[$linenr]}"
					linenr+=1
					echo "Successfully updated SSL certificate for ${domains[$linenr]}"
					updated+=1
				else
					linenr+=1
				fi
			done
		fi
fi

if [[ "$updated" > 0 ]]; then
	echo "Some certificates have been updated"
	service apache2 restart
else
	#echo "No certificates to update"
	exit 0
fi
