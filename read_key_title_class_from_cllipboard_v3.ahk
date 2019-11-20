; https://www.autohotkey.com/boards/viewtopic.php?f=13&t=60112&p=302111#p302111
; https://github.com/sl5net/AutoHotKey4Linux
;  dddd ssss <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v2.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl><AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v2.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.esc>

#NoEnv              ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn
#SingleInstance Force
SendMode Input      ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode 2
SetBatchLines, -1

; WinGetTitle, at, A ; MsgBox, The active window is "%Title%". 

; <AutoKey:active_title=active_title,active_class=active_class>
tOld := ""
cOld := ""
keyOld := ""
; Key.esc
; Expected Examples of Version 1:
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key=Key.up>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key=Key.ctrl>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key='f'>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>
cbBackup := clipboard
while(1)
{
	cb = %clipboard%
	; press_key ; release_key
	; (?<pressORrelease>(press|release))_key
	FoundPos := RegExMatch(cb, "O)<AutoKey:active_title=(?<active_title>[^,>]*),active_class=(?<active_class>[^,>]*),(?<pressORrelease>(press|release))_key=(?<key>[^,>]*)>", SubPat)  ; The starting "O)" turns SubPat into an object.
	if(FoundPos){
		clipboard := cbBackup
		if(keyOld <> SubPat["key"]){

if(SubPat["key"] == "Key.esc")
	ExitApp

keyOld := SubPat["key"]
			tOld := SubPat["active_title"]
			cOld := SubPat["active_class"]
			tip := "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"] "`npressORrelease=" SubPat["pressORrelease"]  "`nkey=" SubPat["key"] "`nBackup=" cbBackup, 350, 5
			tooltip, % tip, 350, 5
			msgbox,% tip
		}
	}else{
	   cbBackup := cb
	}
	;FoundPos:=0
	Sleep,1500
}
tooltip,
