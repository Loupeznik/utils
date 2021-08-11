#/bin/bash

#######################################################
## Docker-containerized MySQL database backup script ##
## Dumps selected databases from a container to a    ##
## pre-defined location on the filesystem. Takes the ##
############ container name as an argument ############
#######################################################

BACKUP_DATE=$(date +%Y-%m-%d)
BACKUP_DIR=/var/db/backups
BACKUP_USER=backup
BACKUP_PW=
CONTAINER_NAME=$1
DATABASES=()

if [ $# -eq 0 ]
  then
    echo "WARNING: A container name must be supplied!"
	echo "USAGE: ./mysql_backup_docker.sh some_mysql_container"	
fi

for index in ${DATABASES[@]}; do
	docker exec -i $CONTAINER_NAME mysqldump -u$BACKUP_USER -p$BACKUP_PW \
	${DATABASES[index]} --skip-comments > $BACKUP_DIR/$BACKUP_DATE-${DATABASES[index]}.sql
done
