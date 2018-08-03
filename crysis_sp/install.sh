#!/bin/sh

chmod +x nzd_crysis_spdemo.exe
wine ./nzd_crysis_spdemo.exe -s2 -sp"/s /v/qn"

echo '#!/bin/sh
rm "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Game/Levels/island/benchmark_gpu.log" 2> /dev/null
cd "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Bin64"

wine ./crysis.exe -dx9 -DEVMODE +map island +exec benchmark_gpu

fps=$(grep -o "Average FPS: [0-9][0-9].[0-9][0-9]" "$WINEPREFIX/drive_c/Program Files (x86)/Electronic Arts/Crytek/Crysis SP Demo/Game/Levels/island/benchmark_gpu.log" | grep -o [0-9][0-9].[0-9][0-9] | awk '\''{ total += $1; count++ } END { print total/count }'\'')

echo -e $"Crysis Benchmark Results\nAverage FPS: " $fps > $LOG_FILE
' > crysis_sp

chmod +x crysis_sp
