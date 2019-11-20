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

loop,10000
{
	cb = %clipboard%
	; Msgbox % cb
	FoundPos := RegExMatch(cb, "O)<AutoKey:active_title=(?<active_title>[^,>]*),active_class=(?<active_class>[^,>]*)>", SubPat)  ; The starting "O)" turns SubPat into an object.
	if(FoundPos && (tOld <> SubPat["active_title"] || cOld <> SubPat["active_class"])){

		tOld := SubPat["active_title"]
		cOld := SubPat["active_class"]

	;	Msgbox % "tit=" SubPat["active_title"] "`n`nclass=" SubPat["active_class"]
		; ToolTip , Text, X, Y, WhichToolTip
		tooltip, % "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"], 350, 5

	;	Msgbox % SubPat.Count() ": " SubPat.Value(1) " " SubPat.Name(2) "=" SubPat["active_class"]
		;sleep,200
	}
	sleep,150
}
tooltip,

