#!/bin/sh

echo '# -config=name_of_your_config.txt
#
# -report=name_of_report_file.txt
#

# Video resolution, Width and Height
#
# Defaults to Windows resolution if commented out.
Width: 1280
Height: 720

# Texture Quality: 
#
# 0 = Low, 1 = Medium, 2 = High 3 = Very High
# Defaults to 2 if commented out.
Texture Quality: 1

# Shadow Quality: 
#
# 0 = Off, 1 = Low, 2 = Medium, 3 = High
# Defaults to 3 if commented out.
Shadow Quality: 0

# Anistropic Filtering
#
# Range of 1 to 16 
# Defaults to 16 if commented out.
Anisotropic Filtering: 1

# Screen Space Ambient Occlusion
#
# 0 = Off, 1 = On
# Defaults to 1 if commented out.
SSAO: 0

# Vertical Sync 
#
# 0 = Off, 1 = On
# Defaults to 0 if commented out.
Vertical Sync: 0

# DX11 Tessellation
#
# 0 = Off, 1 = On
# Defaults to 1 if commented out.
DX11 Tessellation: 0

# DX11 Advanced shadow sampling
#
# 0 = Off, 1 = On 
# Defaults to 1 if commented out.
DX11 Advanced Shadows: 0

# DX11 Full Screen Anti-Aliasing Sample Count
#
# 1 = Off, 2 = 2xAA, 4 = 4XAA
# Defaults to 1 if commented out.
DX11 MSAA Samples: 1
' > config.txt

chmod 444 config.txt

OSNAME=$(uname -s)

if [ "$OSNAME" = "Linux" ]; then
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/My Documents/AvP_D3D11_Benchmark"
    #in case cp is alias to cp -i
    /bin/cp -rf config.txt "$WINEPREFIX/drive_c/users/$USER/My Documents/AvP_D3D11_Benchmark/config.txt"
else
    mkdir -p "C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark"
    /bin/cp -rf config.txt "C:/Users/$USERNAME/My Documents/AvP_D3D11_Benchmark/config.txt"
fi
