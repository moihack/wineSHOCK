#!/bin/sh

./tmnationsforever_setup.exe /SILENT

echo '#!/bin/sh

cd "C:/Users/$USERNAME/My Documents/TmForever/Bench"
rm pts.txt

cd "C:/Program Files (x86)/TmNationsForever"
./TmForever.exe /useexedir /login=$TMUSER /password=$TMPASSWORD /silent /bench=Bench.Replay.gbx /out=pts.txt

cd "C:/Users/$USERNAME/My Documents/TmForever/Bench"
cat pts.txt > $LOG_FILE' > tmnations

chmod +x ./tmnations