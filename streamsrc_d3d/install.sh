#!/bin/sh

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
wine ./streamsrc_d3d_test.exe 15 > \$LOG_FILE" > streamsrc_d3d

chmod +x ./streamsrc_d3d_test.exe
chmod +x ./streamsrc_d3d