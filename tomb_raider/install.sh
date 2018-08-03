#!/bin/sh

echo '#!/bin/sh

CWD=$PWD

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
rm benchmarkresult*.txt

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam"

if [ "$STEAMUSER" = "" ]; then
    wine ./Steam.exe -applaunch 203160 -benchmarkini $CWD/tomb.ini &
else
    wine ./Steam.exe -silent -login $STEAMUSER $STEAMPWD -applaunch 203160 -benchmarkini $CWD/tomb.ini &
fi

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"

while [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider/benchmarkresult"*.txt ]
do
  sleep 5 #check again in 5 seconds if benchmark finished running
done

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam"
wine ./Steam.exe -shutdown
sleep 5

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
head -n 7 benchmarkresult*.txt > $LOG_FILE' > tomb_raider

chmod +x tomb_raider

#Create registry entry for TR so the game will launch normally without displaying the menu
wine reg add "HKCU\\software\\Crystal Dynamics\\Tomb Raider\\Graphics"
