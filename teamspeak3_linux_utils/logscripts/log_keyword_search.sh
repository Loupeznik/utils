#!/bin/sh

userinput="$1"

do_get(){ 
	log_file=$(ls -tp logs/ | head -1)
	local arg="$1"
	echo "### Starting grep search ###"
	if grep "$arg" logs/$log_file;
	then
		echo "### Search complete ###"
	else
		echo "### No results matching given keywords found in log ###"
	fi
}

do_get "$userinput"
