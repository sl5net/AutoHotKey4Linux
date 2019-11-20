# this script needs to be started from AutoKey

import subprocess
import threading
import time
import re
from pynput.keyboard import Key, Listener
from typing import NamedTuple, Union, List

from autokey import iomediator

def on_press(key): # Example: <AutoKey:active_title=AutoKey,active_class=autokey-gtk.Autokey-gtk,key='k'>
    # if key == Key.esc:
    #    return False
    print('{0} pressed'.format(key))
    key2 = '{0}'.format(key)
    active_title = window.get_active_title()
    active_class = window.get_active_class()
    str = "<AutoKey:active_title=" + active_title + ",active_class=" + active_class + ",press_key=" + key2 + ">"
    # v <AutoKey:active_title=AutoKey,active_class=autokey-gtk.Autokey-gtk,key=Key.ctrl>v<AutoKey:active_title=AutoKey,active_class=autokey-gtk.Autokey-gtk,key=Key.ctrl>
    clipboard.fill_clipboard(str)
    # strLen = len(str)
    # clipboard.fill_clipboard("testsetstt")  # <======= works!!! inside of AutoKey GUIx
    tOld = active_title 
    cOld = active_class
    # clipboardBackup = clipboard.get_clipboard()
    # time.sleep(0.1)
    # time.sleep(0.2)
    # clipboard.fill_clipboard(clipboardBackup)


def on_release(key):
    if key == Key.esc:
        return False
    print('{0} pressed'.format(key))
    key2 = '{0}'.format(key)
    active_title = window.get_active_title()
    active_class = window.get_active_class()
    str = "<AutoKey:active_title=" + active_title + ",active_class=" + active_class + ",release_key=" + key2 + ">"
    # v <AutoKey:active_title=AutoKey,active_class=autokey-gtk.Autokey-gtk,key=Key.ctrl>v<AutoKey:active_title=AutoKey,active_class=autokey-gtk.Autokey-gtk,key=Key.ctrl>
    clipboard.fill_clipboard(str)
    # strLen = len(str)
    # clipboard.fill_clipboard("testsetstt")  # <======= works!!! inside of AutoKey GUIx
    tOld = active_title 
    cOld = active_class


# Collect events until released tkk j dea
with Listener(
        on_press=on_press,
        on_release=on_release) as listener:
    listener.join()
