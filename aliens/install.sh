#!/bin/sh

mv "aliens-vs-predator-D3D11-Benchmark-v1.03.msi" "aliens.msi"

wine msiexec /i aliens.msi /quiet /qn

echo '#!/bin/sh
rm "/home/$USER/Documents/AvP_D3D11_Benchmark/AvP_"*.txt
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rebellion/AvP D3D11 Benchmark"
wine ./AvP_D3D11_Benchmark.exe -config="/home/$USER/Documents/AvP_D3D11_Benchmark/config.txt"

while [ ! -f "/home/$USER/Documents/AvP_D3D11_Benchmark/AvP_"*.txt ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 5

cd "/home/$USER/Documents/AvP_D3D11_Benchmark"

grep "Average FPS:" AvP_*.txt > $LOG_FILE' > aliens

chmod +x ./aliens
