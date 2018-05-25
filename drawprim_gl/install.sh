#!/bin/sh

unzip -j -o "freeglut-MinGW.zip" "freeglut/bin/freeglut.dll" "freeglut.dll"
unzip -j -o "glew-2.1.0-win32.zip" "glew-2.1.0/bin/Release/Win32/glew32.dll" "glew32.dll"

rm freeglut-MinGW.zip glew-2.1.0-win32.zip

echo "#!/bin/sh
ping 127.0.0.1 -n %PHPSLEEP% > /dev/null
wine ./drawprim_gl_test.exe 15 > \$LOG_FILE" > drawprim_gl

chmod +x drawprim_gl_test.exe
chmod +x drawprim_gl