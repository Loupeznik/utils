#!/usr/bin/env python3

import os
import subprocess
import io
import re

def check_dir(dir):
    result = os.path.exists(dir)
    if result:
        pass
    else:
        os.mkdir(dir)

def scan(ip,cmd):
    try:
        #cmd = os.system('nmap -T4 -A -v -Pn ' + ip)
        res_dir = 'output'
        check_dir(res_dir)
        res_path = res_dir + '/' + ip + '.txt'
        f = open(res_path,'a')
        print('Prerequisities satisfied, begin scan...')
        print('This might take a while...')
        #cmd = 'nmap -T4 -A -v -Pn ' + ip #customize nmap parameters if needed
        with subprocess.Popen(cmd, stdout = subprocess.PIPE, shell=True) as proc:
            f.write('###Record start###\n')
            f.write('###CMD: ' + cmd + '###\n')
            for line in io.TextIOWrapper(proc.stdout,encoding='utf-8'):
                f.write(line)
            f.write('###Record end###\n')
        f.close()
        print ('Scan complete, results stored in ' + res_path)
    except Exception as e:
        print('Unable to perform scan -> exception: ' + str(e))

def is_ip(userinput):
    regex = r'\b(?:\d{1,3}\.){3}\d{1,3}\b'
    ip = re.search(regex,userinput)
    if ip is None:
        return False
    return True


print('Insert IP to scan:')
ip = input()
print('Select scan mode:\n 1. Aggressive service scan (-sV -sC -A)\n 2. All ports scan (-sV -p-)')
userCmd = input()
if is_ip(ip):
    if int(userCmd) > 0 and int(userCmd) < 3:
        if userCmd == '1':
            cmd = 'nmap -sV -sC -A -T4 -Pn ' + ip
        elif userCmd == '2':
            cmd = 'nmap -sV -p- -T4 -Pn ' + ip
        scan(ip,cmd)
else:
    print('Inserted value does not seem to be an IP adress')
