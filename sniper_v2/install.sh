#!/bin/sh

mv "SniperEliteV2%20Benchmark%201.05.msi" "sniper.msi"

sleep 5

#install benchmark
wine msiexec /i sniper.msi /quiet /qn

echo '#!/bin/sh

documents_path=$(xdg-user-dir DOCUMENTS)

rm "$documents_path/SniperEliteV2_Benchmark/SEV2__"*.txt
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rebellion/SniperEliteV2 Benchmark/bin"
wine ./SniperEliteV2.exe
while [ ! -f "$documents_path/SniperEliteV2_Benchmark/SEV2__"*.txt ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 5

cd "$documents_path/SniperEliteV2_Benchmark"

grep "Average FPS:" SEV2__*.txt > $LOG_FILE' > sniper_v2

chmod +x ./sniper_v2

#install dx runtime so game displays properly
wine ./directx_Jun2010_redist.exe /Q /T:"C:/dxsdk"
cd "$WINEPREFIX/drive_c/dxsdk"
wine ./DXSETUP.exe /silent

#cleanup
cd ..
rm -rf dxsdk
