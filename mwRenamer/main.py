import psutil 
import os.path
from os import path
import time
#import subprocess


def checkIfProcessRunning(processName):
    for proc in psutil.process_iter():
        try:
            if processName.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
            return False

def checkPid():
    process = filter(lambda p: p.name() == 'ModernWarfare.exe', psutil.process_iter())
    for i in process:
        return i.pid

def init():
    codPath = r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe"
    codPathAlt = r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe1"
    if (checkIfProcessRunning('ModernWarfare.exe') and path.exists(codPath)):
        #přejmenovat soubor
        #čekat na ukončení procesu
        #přejmenovat soubor
        #prompt pro opakování nebo zavření programu
        print('Proces je zapnutý')
        os.rename(codPath,codPathAlt)
        try:
            while(psutil.pid_exists(checkPid())):
                time.sleep(10)
                pass
        except:
            os.rename(codPathAlt,codPath)
            print('Proces je vypnutý. Resetovat?')
            inp = input()
            if inp == 'y':
                init()
            else:
                exit()

    else:
        if path.exists(codPathAlt):
            #přejmenovat soubor
            os.rename(codPathAlt,codPath)
        else:
            print('Proces nenalezen. Resetovat?')
            inp = input()
            if inp == 'y':
                init()
            else:
                exit()

init()
