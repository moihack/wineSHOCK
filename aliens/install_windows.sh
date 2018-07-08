#!/bin/sh

mv "aliens-vs-predator-D3D11-Benchmark-v1.03.msi" "aliens.msi"

#/quiet /qn does not invoke consent.exe(UAC) from bash
#running it via cmd /c does not solve the issue either
#hence we have to display some minimal GUI (/qb) to make UAC prompt appear
"C:/Windows/System32/msiexec.exe" /i aliens.msi /qb

echo '#!/bin/sh
rm "C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark/AvP_"*.txt
cd "C:/Program Files (x86)/Rebellion/AvP D3D11 Benchmark"
./AvP_D3D11_Benchmark.exe -config="C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark/config.txt"

while [ ! -f "C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark/AvP_"*.txt ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 5

cd "C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark"

grep "Average FPS:" AvP_*.txt > $LOG_FILE' > aliens

chmod +x ./aliens
