#!/bin/sh

./tmnationsforever_setup.exe /SILENT

unzip -o ahk.zip -d ./ahk

echo '#!/bin/sh
cd "C:/Users/$USERNAME/My Documents/TmForever/Bench"
rm pts.txt

cd "C:/Program Files (x86)/TmNationsForever"
./TmForever.exe /useexedir /login=$TMUSER /password=$TMPWD /silent /bench=Bench.Replay.gbx /out=pts.txt

cd "C:/Users/$USERNAME/My Documents/TmForever/Bench"
cat pts.txt > $LOG_FILE' > tmnations
chmod + ./tmnations

chmod 777 Default.SystemConfig.Gbx

mkdir -p "C:/Users/$USERNAME/My Documents/TmForever/Config"
cp Default.SystemConfig.Gbx "C:/Users/$USERNAME/My Documents/TmForever/Config/Default.SystemConfig.Gbx"
cp Default.SystemConfig.Gbx "C:/Users/$USERNAME/My Documents/TmForever/Config/Bench.SystemConfig.Gbx"

echo "; Run the launcher once to create the initial config and get rid of the dialog boxes
winwaitactive, TmForever, Your video card, 2
send {space}
Process Wait, %pid%, 10" > firstrun.ahk

cd ahk
./AutoHotKeyU64.exe ../firstrun.ahk &

cd "C:/Program Files (x86)/TmNationsForever"
./TmForeverLauncher.exe /configmode /silent
