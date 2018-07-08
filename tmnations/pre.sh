#!/bin/sh

chmod 444 Default.SystemConfig.Gbx

OSNAME=$(uname -s)

if [ "$OSNAME" = "Linux" ]; then
    mkdir -p "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever/TmForever/Config"
    cp Default.SystemConfig.Gbx "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever/TmForever/Config/Default.SystemConfig.Gbx"
    cp Default.SystemConfig.Gbx "$WINEPREFIX/drive_c/Program Files (x86)/TmNationsForever/TmForever/Config/Bench.SystemConfig.Gbx"
else
    mkdir -p "C:/Users/$USERNAME/My Documents/TmForever/Config"
    cp Default.SystemConfig.Gbx "C:/Users/$USERNAME/My Documents/TmForever/Config/Default.SystemConfig.Gbx"
    cp Default.SystemConfig.Gbx "C:/Users/$USERNAME/My Documents/TmForever/Config/Bench.SystemConfig.Gbx"
fi
