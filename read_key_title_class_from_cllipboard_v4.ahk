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



CoordMode, ToolTip, Screen  ; Place ToolTips at absolute screen coordinates.
; CoordMode, ToolTip  ; Same effect as the above because "screen" is the default.

cbBackup := ""
tOld := ""
cOld := ""
keyOld := ""
keyHistory := ""
keyHistoryOld := ""

; some simple test:
tip = Welcome to %A_ScriptName%
tooltip, % tip, 350, 10
sleep,100
WinActivate , AutoKey  ; this probably not working into Linux
sleep,100
Send,`; %tip% ; this kind of sending is not working into Linux
sleep,1000
msgbox,,% tip,% clipboard,1 ; works :)

; check regEx is working
; cb := "<AutoKey:active_title=*/read_key_title.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>"
cb := "<AutoKey:active_title=title,active_class=class,press_key=k>" ; most simple form
regEx := "O)<AutoKey:active_title=(?<active_title>[^,>]*),active_class=(?<active_class>[^,>]*),(?<pressORrelease>(press|release))_key=(?<key>[^,>]*)>"
FoundPos := RegExMatch(cb, regEx, SubPat)  ; The starting "O)" turns SubPat into an object.
if(FoundPos){
	tip := "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"] "`npressORrelease=" SubPat["pressORrelease"]  "`nkey=" SubPat["key"] "`nBackup=" cbBackup, 350, 5
	tooltip, % tip, 350, 10
	msgbox,,REGEX found :),% tip,1 ; works :)
	tooltip,
}else{
	msgbox,,ERROR ,% regEx
	exitApp
}

; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v3.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>


; WinGetTitle, at, A ; MsgBox, The active window is "%Title%". 
; fast gut 

; <AutoKey:active_title=active_title,active_class=active_class>
; testtesttesttes ttesttesttestttesttesttest <st <st <st <st <st <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v3.ahk - Mousepad,active_class=mousepad.Mousepad,release_key='v'>
; Key.esc
; Expected Examples of Version 1:
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key=Key.up>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key=Key.ctrl>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,key='f'>
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>

; test    mmmmöö

; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v3.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>
cbBackup := clipboard
cbBackup2 := clipboard
if(!regEx)
	msgbox,ERROR !regEx
while(1){
	cb := clipboard
	if(!cb){ 
		tooltip,% "empty cp. (line=" A_LineNumber ")`n" keyHistory
		sleep,40
		continue
	}
;	msgbox,,% cb,% "key=" cb " line=" A_LineNumber,1 ; works :)     
;	tooltip,% "cb=" cb "`nclipboard=" clipboard " `n(line=" A_LineNumber ")`n" keyHistory, 350, 10
	if(keyHistoryOld != keyHistory)
		tooltip,% "(line=" A_LineNumber ")`n" keyHistory, 400, 150,5
	; The starting "O)" turns SubPat into an object. 
; <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v3.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.esc>
; okokokoko rrr

	FoundPos := RegExMatch(cb, regEx, SubPat)  ; The starting "O)" turns SubPat into an object.
	if(FoundPos){
		tooltip,% "key=" cb " line=" A_LineNumber ; works :)
		if(cbBackup){
			;while(cp <> cbBackup && A_Index<100 && RegExMatch(clipboard, regEx)){
				clipboard := cbBackup
				Sleep,15
			;}
			if(RegExMatch(clipboard, regEx))
			   clipboard := cbBackup2
		}
		;msgbox,,% A_LineNumber,% A_LineNumber,1 ; works :)aaaaaa
		if(keyOld <> SubPat["key"]){

			if(SubPat["key"] == "Key.esc")
				ExitApp
			keyOld := SubPat["key"]
			keyHistoryOld := keyHistory
			keyHistory .= keyOld
			tOld := SubPat["active_title"]
			cOld := SubPat["active_class"]
			tip := "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"] "`npressORrelease=" SubPat["pressORrelease"]  "`nkey=" SubPat["key"] "`nBackup=" cbBackup, 350, 5
			;msgbox,,% tip,% A_LineNumber,1 ; works :)
			;tooltip, % tip, 350, 10
;			tooltip, % tip, 350, 10
	tooltip,% " `n(line=" A_LineNumber ")`n" keyHistory
			;msgbox,,% "",% tip,1 ; works :)
			while(A_Index<100 && RegExMatch(clipboard, regEx)){
				if(!cbBackup)
					break
				clipboard := cbBackup
				Sleep,15
			}
			if(RegExMatch(clipboard, regEx))
			   clipboard := cbBackup2
		       cbBackup2 := cbBackup
		       cbBackup = %clipboard%
		}
	} ; found nothing
	; `n `n  <AutoKey:active_title=*/home/seeh/skripts/ahk/read_key_title_class_from_cllipboard_v3.ahk - Mousepad,active_class=mousepad.Mousepad,press_key=Key.ctrl>
	Sleep,10 ; 70, 30, 10 works at my machine with 3% CPU
}
tooltip,

