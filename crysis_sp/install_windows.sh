#!/bin/sh

echo 'SetTitleMatchMode, 2
WinWaitActive, Crysis(R) SP Demo
Sleep 10000 ; Sleep enough time so Next button loads up
Send, {Enter}
WinWait, , License Agreement
Sleep 1000
Send, {Up} ; Agree to Terms
Sleep 1000
Send, {Enter}; Next
;probably localized message below
WinWait, , InstallShield Wizard Completed; Wait for installation to complete
Sleep 8000 ; Sleep enough time so finish button loads up
Send, {Enter}; Finish;' > install.ahk

unzip -o ahk.zip -d ./ahk
cd ahk
./AutoHotKeyU64.exe ../install.ahk &
cd ..

chmod +x nzd_crysis_spdemo.exe
./nzd_crysis_spdemo.exe -s2 -sp"/s /vINSTALLDIR=C:\pts-benchmarks\crysis"

echo '#!/bin/sh
rm "C:/pts-benchmarks/crysis/Game/Levels/island/benchmark_gpu.log" 2> /dev/null
cd "C:/pts-benchmarks/crysis/Bin64"

./crysis.exe -dx9 -DEVMODE +map island +exec benchmark_gpu
mygrep=$(grep -o "Average FPS: [0-9][0-9].[0-9][0-9]" "C:/pts-benchmarks/crysis/Game/Levels/island/benchmark_gpu.log" | grep -o [0-9][0-9].[0-9][0-9])

fps=0
while read -r line
do
	fps=$(echo "$fps+$line" | bc -l)
done <<< "$mygrep"
fps=$(echo "$fps/4" | bc -l | cut -c1-5)
echo -e $"Crysis Benchmark Results\nAverage FPS: " $fps > $LOG_FILE
' > crysis_sp

chmod +x crysis_sp
