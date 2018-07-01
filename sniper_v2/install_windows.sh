#!/bin/sh

echo '#!/bin/sh
"C:/Windows/System32/msiexec.exe" /i sniper.msi /qb' > sniper.sh
chmod +x ./sniper.sh

#/quiet /qn does not invoke consent.exe(UAC) from bash
#running it via cmd /c does not solve the issue either
#hence we have to display some minimal GUI (/qb) to make UAC prompt appear

mv "SniperEliteV2%20Benchmark%201.05.msi" "sniper.msi"

sleep 5

./sniper.sh


echo '#!/bin/sh
rm "C:/Users/$USERNAME/My Documents/SniperEliteV2_Benchmark/SEV2__"*.txt
cd "C:/Program Files (x86)/Rebellion/SniperEliteV2 Benchmark/bin"
./SniperEliteV2.exe
while [ ! -f "C:/Users/$USERNAME/My Documents/SniperEliteV2_Benchmark/SEV2__"*.txt ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 5

cd "C:/Users/$USERNAME/My Documents/SniperEliteV2_Benchmark"

grep "Average FPS:" SEV2__*.txt > $LOG_FILE' > sniper_v2

chmod +x ./sniper_v2
