#!/bin/sh

echo "#!/bin/sh
cd \"C:\Program Files (x86)\Unigine\Heaven Benchmark 4.0\bin\"
./Heaven.exe -video_app direct3d9 -data_path ../ -sound_app null -engine_config ../data/heaven_4.0.cfg -system_script heaven/unigine.cpp -video_mode -1 -extern_define PHORONIX,RELEASE \$@ > \$LOG_FILE" > heaven_wine

# This assumes you will install to the default location
# C:\Program Files (x86)\Unigine\
./Unigine_Heaven-4.0.exe /SILENT
