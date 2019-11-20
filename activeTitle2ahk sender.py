# /home/seeh/.config/autokey/data/Sample Scripts/activeTitle2ahk sender.py
import time
# import /home/seeh/.config/autokey/*

tOld = ""
cOld = ""
active_title = ""
active_class = ""
clipboardBackup = ""
for x in range(0, 5000):
    active_title = window.get_active_title()
    active_class = window.get_active_class()
    # time.sleep(0.2)
    if (tOld != active_title) or (cOld != active_class):
        tOld = active_title
        cOld = active_class
        str = "<AutoKey:active_title=" + active_title + ",active_class=" + active_class + ">"
        strLen = len(str)
        clipboardBackup = clipboard.get_clipboard()
        time.sleep(0.1)
        clipboard.fill_clipboard(str)
        time.sleep(0.2)
        clipboard.fill_clipboard(clipboardBackup)
        time.sleep(0.8)
    else:
        time.sleep(0.2)

keyboard.send_keys("\n# bye bye")

