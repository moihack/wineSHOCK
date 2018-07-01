#!/bin/sh

echo '#################################
[Display Settings]
Resolution_Width = 1280

Resolution_Height = 720

###### 1 = On, 0 = Off ###### 
MotionBlur = 0

###### 1 = On, 0 = Off ###### 
AmbientOcclusion = 0

###### 1 = On, 0 = Off ###### 
VSync = 0

###### 1 = On, 0 = Off ###### 
ReduceMouseLag = 0

###### 0 = Low, 1 = Medium, 2 = High, 3 = Ultra ###### 
TextureDetail = 3

###### 0 = Low, 1 = Medium, 2 = High, 3 = Ultra ###### 
ShadowDetail = 1

###### 0 = Off, 1 = Low, 2 = Medium, 3 = High ###### 
AntiAliasing = 1

###### 0 = Low, 1 = Medium, 2 = High, 3 = Ultra ###### 
DrawDistance = 2

###### 1 = Off, highest value is 16 ###### 
AnisotropicFiltering = 1

###### 0.0 = None, 1.0 = Full ###### 
Brightness = 0.0

###### 1 = On, 0 = Off ###### 
Stereo3D = 0

###### 1 = On, 0 = Off ###### 
Stereo3DScoped = 0

###### 0.0 = None, 1.2 = Full ###### 
Stereo3DStrength = 0.0

###### 0 = Off, 1 = On ###### 
ComputeShader = 0

###### 0 = Off, 1 = Low, 2 = Medium, 3 = High ###### 
AdvancedShadows = 0

###### 0 = Off, 1 = 2.25x, 2 = 4.0x ###### 
Supersampling = 0' > Settings.ini

chmod 444 Settings.ini

OSNAME=$(uname -s)

if [ "$OSNAME" = "Linux" ]; then
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/My Documents/SniperEliteV2_Benchmark"
    #in case cp is alias to cp -i
    /bin/cp -rf Settings.ini "$WINEPREFIX/drive_c/users/$USER/My Documents/SniperEliteV2_Benchmark/Settings.ini"
else
    mkdir -p "C:/Users/$USERNAME/My Documents/SniperEliteV2_Benchmark"
    /bin/cp -rf Settings.ini "C:/Users/$USERNAME/My Documents/SniperEliteV2_Benchmark/Settings.ini"
fi
