#!/bin/sh

chmod +x Unigine_Heaven-4.0.exe
wine ./Unigine_Heaven-4.0.exe

echo "#!/bin/sh
cd \"$HOME.wine/drive_c/Program Files (x86)/Unigine/Heaven Benchmark 4.0/bin/\"
wine ./Heaven.exe -video_app direct3d9 -data_path ../ -sound_app null -engine_config ../data/heaven_4.0.cfg -system_script heaven/unigine.cpp -video_mode -1 -extern_define PHORONIX,RELEASE \$@ > \$LOG_FILE" > heaven_wine
chmod +x heaven_wine
