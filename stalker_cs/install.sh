#!/bin/sh

wine ./stkcs-bench-setup.exe /SILENT

echo '#!/bin/sh
rm "$WINEPREFIX/drive_c/users/Public/Documents/ClearSkyBench/_appdata_/sunshaftsbenchmark.result"
cd "$WINEPREFIX/drive_c/Program Files (x86)/ClearSky Benchmark"
wine bin_test/xrEngine.exe -ltx test.ltx -openautomate sunshaftsbenchmark.test &

while [ ! -f "$WINEPREFIX/drive_c/users/Public/Documents/ClearSkyBench/_appdata_/sunshaftsbenchmark.result" ]
do
  sleep 10 #check again in 10 seconds if benchmark finished running
done

sleep 10 #wait for XR engine to exit and write all output to file
#xrEngine.exe tends to crash instead of closing properly when launched from PTS
#so we just kill it to make sure the test continues

killall xrEngine.exe

cd "$WINEPREFIX/drive_c/users/Public/Documents/ClearSkyBench/_appdata_"

grep average sunshaftsbenchmark.result > $LOG_FILE' > stalker_cs

chmod +x ./stalker_cs
