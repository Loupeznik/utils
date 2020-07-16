#!/usr/bin/python3
#Zkontrolovat obsah složky s texty proti databázi a smazat nepoužívané soubory

import os
import mysql.connector
import pwds
import datetime

def check_files(folder,dbuname,dbpwd):
	folder_abs = '/var/www/rtl/admin/pages/' + folder
	db = mysql.connector.connect(host='localhost',user=dbuname,password=dbpwd,database='troznov')
	cursor = db.cursor()
	cursor.execute('SELECT maDATUMCAS FROM main')
	dbres = cursor.fetchall()
	reslist = []
	edited_filecount = 0
	dir_structure = os.listdir(folder_abs)
	
	for res in dbres:
		res_date = res[0]
		reslist.append(str(res_date.date()))
	
	for item in dir_structure:
		fullname = os.path.join(folder_abs,item)
		for itemdate in reslist:
			if itemdate in item:
				continue
			else:
				edited_filecount += 1
				os.remove(fullname)
				#print('noitemdate') #debug
		
	print ('Bylo odstraněno {} souborů'.format(edited_filecount))

check_files('main',pwds.troznov_uname,pwds.troznov_pwd)
