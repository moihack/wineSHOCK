#!/bin/sh

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
./clear_d3d_test.exe 15 > \$LOG_FILE" > clear_d3d