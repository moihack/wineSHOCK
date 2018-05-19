#!/bin/sh

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
wine ./drawprim_d3d_test.exe 15 > \$LOG_FILE" > drawprim_d3d

chmod +x ./drawprim_d3d_test.exe
chmod +x ./drawprim_d3d