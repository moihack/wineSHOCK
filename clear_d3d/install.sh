#!/bin/sh

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
wine ./clear_d3d_test.exe 15 > \$LOG_FILE" > clear_d3d

chmod +x ./clear_d3d_test.exe
chmod +x ./clear_d3d