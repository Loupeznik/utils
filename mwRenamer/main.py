import psutil 
import os.path
from os import path
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
    if (checkIfProcessRunning('ModernWarfare.exe') and path.exists(r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe")):
        #přejmenovat soubor
        #čekat na ukončení procesu
        #přejmenovat soubor
        #prompt pro opakování nebo zavření programu
        print('Proces je zapnutý')
        os.rename(r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe",r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe1")
        try:
            while(psutil.pid_exists(checkPid())):
                pass
        except:
            os.rename(r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe1",r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe")
            print('Proces je vypnutý. Resetovat?')
            inp = input()
            if inp == 'y':
                init()
            else:
                exit()

    else:
        if path.exists(r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe1"):
            #přejmenovat soubor
            os.rename(r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe1",r"G:\Battle.net\cod\Call of Duty Modern Warfare\ModernWarfare.exe")
        else:
            print('Proces nenalezen. Resetovat?')
            inp = input()
            if inp == 'y':
                init()
            else:
                exit()

init()
