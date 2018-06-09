#!/bin/sh

chmod +x nzd_crysis_spdemo.exe
./nzd_crysis_spdemo.exe -s2 -sp"/s /v/qn"

echo '#!/bin/sh
rm "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Game/Levels/island/benchmark_gpu.log" 2> /dev/null
cd "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Bin64"

./crysis.exe -dx9 -DEVMODE +map island +exec benchmark_gpu
mygrep=$(grep -o "Average FPS: [0-9][0-9].[0-9][0-9]" "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Game/Levels/island/benchmark_gpu.log" | grep -o [0-9][0-9].[0-9][0-9])

fps=0
while read -r line
do
	fps=$(echo "$fps+$line" | bc -l)
done <<< "$mygrep"
fps=$(echo "$fps/4" | bc -l | cut -c1-5)
echo -e $"Crysis Benchmark Results\nAverage FPS: " $fps > $LOG_FILE
' > crysis_sp

chmod +x crysis_sp
