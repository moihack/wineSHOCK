#!/bin/sh

mv "aliens-vs-predator-D3D11-Benchmark-v1.03.msi" "aliens.msi"

#install mono - installer needs .NET 3.5 SP1 or higher
wine msiexec /i wine-mono-4.7.3.msi /qn

#install benchmark
wine msiexec /i aliens.msi /quiet /qn

echo '#!/bin/sh

documents_path=$(xdg-user-dir DOCUMENTS)

rm "$documents_path/AvP_D3D11_Benchmark/AvP_"*.txt
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rebellion/AvP D3D11 Benchmark"
wine ./AvP_D3D11_Benchmark.exe -config="$documents_path/AvP_D3D11_Benchmark/config.txt"

while [ ! -f "$documents_path/AvP_D3D11_Benchmark/AvP_"*.txt ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 5

cd "$documents_path/AvP_D3D11_Benchmark"

grep "Average FPS:" AvP_*.txt > $LOG_FILE' > aliens

chmod +x ./aliens

#install dx runtime so game displays properly
wine ./directx_Jun2010_redist.exe /Q /T:"C:/dxsdk"
cd "$WINEPREFIX/drive_c/dxsdk"
wine ./DXSETUP.exe /silent

#cleanup
cd ..
rm -rf dxsdk
