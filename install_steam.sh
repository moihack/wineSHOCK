#!/bin/sh
source ./pts_prerun.sh

WGETCMD=$(command -v wget | wc -l)

if [ "$WGETCMD" != "1" ]; then
  echo "wget not found! Exiting"
  exit
else
  rm SteamSetup.exe
  echo "Downloading Steam for Windows"
  wget http://media.steampowered.com/client/installer/SteamSetup.exe
fi

chmod +x SteamSetup.exe

OSNAME=$(uname -s)

if [ "$OSNAME" = "Linux" ]; then
    wine ./SteamSetup.exe /S
else
    ./SteamSetup.exe /S
fi
