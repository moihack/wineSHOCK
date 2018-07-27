#!/bin/sh

str="$*"

echo 'Width   = 640
Height  = 480
Quality = 3
Antialias = 0
Fullscreen = 0

Last = borked

Loop, %0%  ; For each parameter:
{
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
	if(param = "-width" or param = "-height" or param = "-quality" or param = "-antialias"  or param = "-fullscreen")
	{
		Last = %param%
	}
	else
	{
		if(Last = "-width")
		{
			Width = %param%
		}
		if(Last = "-height")
		{
			Height = %param%
		}
		if(Last = "-quality")
		{
			Quality = %param%
		}
		if(Last = "-antialias")
		{
			Antialias = %param%
		}
		if(Last = "-fullscreen")
		{
			Fullscreen = %param%
		}
		Last = borked
	}
}

sleep %PHPSLEEP%000

SetTitleMatchMode, 2
winwait, TmForever
Sleep 500
WinActivate
winwaitactive, TmForever
ControlClick Button2	; Configuration
Sleep 500

send {tab 1}			; Fullscreen checkbox
ControlGet cur_fs, Checked,, Button1, Configuration
if (cur_fs != Fullscreen)
{
    ControlClick Button1, Configuration	; Toggle fullscreen
}

send {tab 1}			; Resolution control

; Tmnations only allows us to set resolutions in the combobox list. Since it is
; a combobox we can type the resolution we want, and then hit the down key to select
; the matching resolution from the list of supported resolutions. If the resolution
; is not the list this will select 640x480
;send %Width%x%Height%	; Set resolution ; it always reverts to 640x480
send {PgDn} ; select the highest available resolution
send {tab 2}{space}		; Advanced button
Sleep 500

while not WinExist("Advanced Settings")
{
    Click 320, 300  
    Sleep 500
}

; For some reason most controls cannot be adressed, so I have to hardcode
; a lot of mouse coordinates. For the same reason I cannot check the status
; of some checkboxes. For this reason the test is supplying a preconfigured
; config file that has some sane defaults(Windowed mode, customized graphics
; settings enabled, sound off[openal makes problems on some platforms])
Click 315, 82                   ; Click the presets field twice to select it
Click 315, 82
send {up 6}                     ; Go to preset none
send {down %Quality%}
Sleep 1000
send {tab} ;switch to AA settings
Sleep 1000
send {tab} ;switch to AA settings
send {up 5}                     ; MSAA disabled

Loop, %Antialias%
{
    send {down}
    Sleep, 800
}
while WinExist("Advanced Settings")
{
    Click 60, 460               ; OK
    Sleep 500
}

Click 60, 290                   ; Save

winwaitactive, TmForever
ControlClick Button5    ; Exit' > config.ahk

OSNAME=$(uname -s)

if [ "$OSNAME" = "Linux" ]; then
    cd ahk
    wine ./AutoHotKeyU64.exe ../config.ahk $str &    
    cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever"
    wine ./TmForeverLauncher.exe
else
    cd ahk
    ./AutoHotKeyU64.exe ../config.ahk $str &    
    cd "C:/Program Files (x86)/TmNationsForever"
    ./TmForeverLauncher.exe
fi
