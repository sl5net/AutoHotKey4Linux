# AutoHotKey4Linux version 0.00000001 Alpha
AutoHotKey wrapper, for using AutoHotKey in Linux  

using AutoKey, AutoHotKey, wine

You need to install first:

wine for Linux  and 
AutoHotKey and  
AutoKey for Linux

# Motivation:

  - The (normal) AutoHotkey installation on Linux with Wine currently has 
  difficulty interrogating the keyboard without this tool.
  - The transfer of keystrokes to VirtualBox guests 
  without to focus the guest can thus be made possible.


# example 191130-214520:

https://github.com/sl5net/AutoHotKey4Linux/blob/master/read_strg_numers.ahk#L118]
listens to CTRL+1 and sends then a message with 
information where its coming from (window title, window class) 

			;....
			if(SubPat["key"] == "Key.esc")
				ExitApp
			tip := "tit=" SubPat["active_title"] "`nclass=" SubPat["active_class"] "`npressORrelease=" SubPat["pressORrelease"]  "`nkey=" SubPat["key"] "`nBackup=" cbBackup
			if(pressORreleaseOld=="press" && keyOld == "Key.ctrl"){
				tooltip,% ":-) " tip " `n(line=" A_LineNumber ")`n" keyHistory
				if(SubPat["pressORrelease"]=="press" && SubPat["key"] == "'1'"){
					msgbox,% ":-) " tip " `n(line=" A_LineNumber ")`n" keyHistory
				}
			} else{
				tooltip,% tip " `n(line=" A_LineNumber ")`n" keyHistory 
			}
			;....


