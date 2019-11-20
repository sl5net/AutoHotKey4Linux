; https://www.autohotkey.com/boards/viewtopic.php?f=13&t=60112&p=302111#p302111
; https://github.com/sl5net/AutoHotKey4Linux
; 

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
while(1)
{
	cb = %clipboard%
	; Msgbox % cb
	FoundPos := RegExMatch(cb, "O)<AutoKey:active_title=(?<active_title>[^,>]*),active_class=(?<active_class>[^,>]*),key='(?<key>[^,>']*)'>", SubPat)  ; The starting "O)" turns SubPat into an object.
	;if(FoundPos && (tOld <> SubPat["active_title"] || cOld <> SubPat["active_class"])){
	if(FoundPos){
		if(keyOld <> SubPat["key"]){
			clipboard := cbBackupt
			keyOld := SubPat["key"]
			tOld := SubPat["active_title"]
			cOld := SubPat["active_class"]
			tooltip, % "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"] "`nkey=" SubPat["key"], 350, 5
		}
	}else
	   cbBackupt = %clipboard%

	sleep,150
}
tooltip,tö

