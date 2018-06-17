#!/bin/sh

echo '#!/bin/sh

CWD=$PWD

cd "C:/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
rm benchmarkresult*.txt

cd "C:/Program Files (x86)/Steam"

./Steam.exe -applaunch 203160 -benchmarkini "C:/Users/$USERNAME/.phoronix-test-suite/installed-tests/local/tomb_raider/tomb.ini" &

cd "C:/Program Files (x86)/Steam/steamapps/common/Tomb Raider"

while [ ! -f "C:/Program Files (x86)/Steam/steamapps/common/Tomb Raider/benchmarkresult"*.txt ]
do
  sleep 5 #check again in 5 seconds if benchmark finished running
done

cd "C:/Program Files (x86)/Steam"
./Steam.exe -shutdown
sleep 5

cd "C:/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
head -n 7 benchmarkresult*.txt > $LOG_FILE' > tomb_raider

chmod +x tomb_raider
