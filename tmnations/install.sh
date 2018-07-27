#!/bin/sh

wine ./tmnationsforever_setup.exe /SILENT

unzip -o ahk.zip -d ./ahk

echo '#!/bin/sh
mypwd=$PWD
cd "TmForever/Bench"
rm pts.txt

cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever"
wine ./TmForever.exe /useexedir /login=$TMUSER /password=$TMPWD /silent /bench=Bench.Replay.gbx /out=pts.txt

cd "$mypwd/TmForever/Bench"
cat pts.txt > $LOG_FILE' > tmnations
chmod + ./tmnations

chmod 777 Default.SystemConfig.Gbx
mypwd=$PWD
mkdir -p "$mypwd/TmForever/Config"
cp Default.SystemConfig.Gbx "$mypwd/TmForever/Config/Default.SystemConfig.Gbx"
cp Default.SystemConfig.Gbx "$mypwd/TmForever/Config/Bench.SystemConfig.Gbx"

echo "; Run the launcher once to create the initial config and get rid of the dialog boxes
winwaitactive, TmForever, Your video card, 2
send {space}
Process Wait, %pid%, 10" > firstrun.ahk

cd ahk
wine ./AutoHotKeyU64.exe ../firstrun.ahk &

cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever"
wine ./TmForeverLauncher.exe /configmode /silent
