#!/bin/sh

echo '
QualityLevel = 4
RenderAPI = 9
Fullscreen = 0
ExclusiveFullscreen = 0
AspectRatio = 0
Brightness = 1000
Contrast = 500
VSyncMode = 1
FullscreenWidth = 1280
FullscreenHeight = 720
FullscreenRefreshRate = 60
AdapterId = 0
DX11AdapterId = 0
DX11OutputId = 0
StereoEnabled = 0
StereoDepth = 500
StereoStrength = 500
TextureQuality = 2
BestTextureFilter = 1
HairQuality = 0
AntiAliasingMode = 1
ShadowMode = 1
ShadowResolution = 1
SSAOMode = 1
DOFQuality = 1
ReflectionQuality = 1
LODScale = 2
EnablePostProcess = 0
EnableMotionBlur = 0
EnableScreenEffects = 0
EnableHighPrecisionRT = 0
EnableTessellation = 0
EnableGDI_Cursor = 1' > tomb.ini

echo '#!/bin/sh

CWD=$PWD

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
rm benchmarkresult*.txt

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam"

#wine ./Steam.exe -silent -login $STEAMUSER $STEAMPASSWD -applaunch 203160 -benchmarkini tomb.ini

wine ./Steam.exe -applaunch 203160 -benchmarkini $CWD/tomb.ini &

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"

#!/bin/sh

while [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider/benchmarkresult"*.txt ]
do
  sleep 5 #check again in 5 seconds if benchmark finished running
done

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam"
wine ./Steam.exe -shutdown
sleep 5

cd "$WINEPREFIX/drive_c/Program Files (x86)/Steam/steamapps/common/Tomb Raider"
head -n 7 benchmarkresult*.txt > $LOG_FILE' > tomb_raider

chmod +x tomb_raider
