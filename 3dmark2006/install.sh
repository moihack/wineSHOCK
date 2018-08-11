#!/bin/sh

echo "[InstallShield Silent]
Version=v7.00
File=Response File
[File Transfer]
OverwrittenReadOnly=NoToAll
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-DlgOrder]
Dlg0={7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdWelcome-0
Count=5
Dlg1={7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdLicense2-0
Dlg2={7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdAskDestPath-0
Dlg3={7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdStartCopy2-0
Dlg4={7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdFinish-0
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdWelcome-0]
Result=1
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdLicense2-0]
Result=1
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdAskDestPath-0]
szDir=C:\Program Files (x86)\Futuremark\3DMark06
Result=1
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdStartCopy2-0]
Result=1
[Application]
Name=3DMark06
Version=1.2.1
Company=Futuremark Corporation
Lang=0409
[{7F3AD00A-1819-4B15-BB7D-08B3586336D7}-SdFinish-0]
Result=1
bOpt1=0
bOpt2=0" > setup.iss

echo "SetTitleMatchMode, 2
WinWaitActive, Please Register
Sleep 1000
ControlFocus, Edit1
Send %1%
Sleep 1000
Send {Tab}
Sleep 500
Send {Enter}
Sleep 500
Send {Tab}
Sleep 500
Send {Enter}
Sleep 2000
Send !{f4}
Sleep 2000
Send !{f4}" > activate_3dmark06.ahk

echo '#!/bin/sh

for i in $*
do
    if [[ "$i" == "-width" || "$i" == "-height" || "$i" == "-antialias" || "$i" == "-filtering" ]]
    then
        Last=$i
    else
        if [ "$Last" == "-width" ]; then
            Width=$i
        elif [ "$Last" == "-height" ]; then
            Height=$i
        elif [ "$Last" == "-antialias" ]; then
            Antialias=$i
        elif [ "$Last" == "-filtering" ]; then
            Filtering=$i
        fi
        Last="borked"
    fi
done

x=x #dirty hack for resolution output
cd "$WINEPREFIX/drive_c/Program Files (x86)/Futuremark/3DMark06"
rm "log"*.html myres.3dr

wine ./3DMark06.exe -nosysteminfo -nosplash -res=$Width$x$Height -aa=$Antialias -filter=$Filtering -gt2 -verbose myres.3dr
sleep 5

grep -o "(.* fps)" log*.html > $LOG_FILE' > 3dmark2006

chmod +x ./3dmark2006
wine ./3dmark06.exe /s /f1"./setup.iss"

unzip -o ahk.zip -d ./ahk
cd ahk
wine ./AutoHotKeyU64.exe ../activate_3dmark06.ahk $KEY_3DMARK06 &
cd ..

#install dx runtime so game displays properly
wine ./directx_Jun2010_redist.exe /Q /T:"C:/dxsdk"
cd "$WINEPREFIX/drive_c/dxsdk"
wine ./DXSETUP.exe /silent

#cleanup
cd ..
rm -rf dxsdk

cd "$WINEPREFIX/drive_c/Program Files (x86)/Futuremark/3DMark06"
wine ./3DMark06.exe -nosysteminfo
