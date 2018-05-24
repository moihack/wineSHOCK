#!/bin/sh

echo "#!/bin/sh
./drawprim_gl.bin 15 > \$LOG_FILE" > drawprim_gl
chmod a+x drawprim_gl
chmod a+x drawprim_gl.bin
