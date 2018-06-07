#!/bin/sh

WGETCMD=$(command -v wget | wc -l)

if [ "$WGETCMD" != "1" ]; then
  echo "wget not found! Exiting"
  exit
else
  echo "Downloading Phoronix Test Suite" | tee -a pts_setup.log
  wget https://github.com/phoronix-test-suite/phoronix-test-suite/archive/v8.0.0.zip
fi

unzip -o v8.0.0.zip &&
mv phoronix-test-suite-8.0.0 phoronix-test-suite &&
cd phoronix-test-suite

patch --strip 1 < ../0001-Wine-hello-hack.patch && 
patch --strip 1 < ../0002-Wine-system-layer-hack.patch &&
echo "PTS patched successfully" | tee -a ../pts_setup.log
