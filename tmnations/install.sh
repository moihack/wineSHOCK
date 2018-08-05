#!/bin/sh

wine ./tmnationsforever_setup.exe /VERYSILENT

unzip -o ahk.zip -d ./ahk

echo '#!/bin/sh

documents_path=$(xdg-user-dir DOCUMENTS)
cd "$documents_path/TmForever/Bench"
rm pts.txt

cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever"
wine ./TmForever.exe /useexedir /login=$TMUSER /password=$TMPWD /silent /bench=Bench.Replay.gbx /out=pts.txt

cd "$documents_path/TmForever/Bench"
cat pts.txt > $LOG_FILE' > tmnations
chmod + ./tmnations

documents_path=$(xdg-user-dir DOCUMENTS)
chmod 777 Default.SystemConfig.Gbx
mkdir -p "$documents_path/TmForever/Config"
cp Default.SystemConfig.Gbx "$documents_path/TmForever/Config/Default.SystemConfig.Gbx"
cp Default.SystemConfig.Gbx "$documents_path/TmForever/Config/Bench.SystemConfig.Gbx"

echo "; Run the launcher once to create the initial config and get rid of the dialog boxes
winwaitactive, TmForever, Your video card, 2
send {space}
Process Wait, %pid%, 10" > firstrun.ahk

cd ahk
wine ./AutoHotKeyU64.exe ../firstrun.ahk &

cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever"
wine ./TmForeverLauncher.exe /configmode /silent
