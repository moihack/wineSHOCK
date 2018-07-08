#!/bin/sh

wine ./tmnationsforever_setup.exe /VERYSILENT /SUPPRESSMSGBOXES

echo '#!/bin/sh

cd "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever/TmForever/Config"
rm pts.txt

cd ../..
wine ./TmForever.exe /useexedir /login=$TMUSER /password=$TMPASSWORD /silent /bench=Bench.Replay.gbx /out=pts.txt

cd "TmForever/Bench"
cat pts.txt > $LOG_FILE' > tmnations

chmod +x ./tmnations
