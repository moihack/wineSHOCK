#!/bin/sh

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
wine ./dynbuffer_d3d_test.exe 15 > \$LOG_FILE" > dynbuffer_d3d

chmod +x ./dynbuffer_d3d_test.exe
chmod +x ./dynbuffer_d3d