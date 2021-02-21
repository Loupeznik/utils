#!/usr/bin/python3

from pwds import db_backup_pwd # file with stored credentials
import os
import datetime
import glob
import getpass

DB_USER = 'backup'
DB_PW = db_backup_pwd
DB_NAMES = [] # names of databases to backup
SCRIPT_USER = getpass.getuser()
BACKUP_PATH = '/home/' + SCRIPT_USER + '/backup/db' # path to folder to store backups
today = datetime.date.today()

for name in DB_NAMES:
	if not os.path.exists(BACKUP_PATH):
		os.mkdir(BACKUP_PATH)
	dump = 'mysqldump --force -u ' + DB_USER + ' -p' + DB_PW + ' -B ' + name + ' > ' + BACKUP_PATH + '/' + str(today) + '_' + name+ '.sql'
	os.system(dump)
	os.chdir(BACKUP_PATH)
	tar = 'tar -czf ' + str(today) + '_' + name + '.tar.gz ' + str(today) + '_' + name + '.sql'
	os.system(tar)

if glob.glob(BACKUP_PATH + '/' + str(today) + '_*.sql'):
	for dumpfile in glob.glob(BACKUP_PATH + '/*.sql'):
		os.remove(dumpfile)
	print('[DB BACKUP] ' + str(today) + ' Databases successfuly backed up at ' + BACKUP_PATH)
