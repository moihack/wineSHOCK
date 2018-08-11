#!/bin/sh

#you must source this file before running PTS from a new terminal window

#(un)comment any variable you may need below
#you must keep WINEPREFIX at all times,
#unless you set it somewhere else (e.g. bash.rc)

export WINEPREFIX=~/.wine #CAUTION! Needed for all tests! 
export WINEDEBUG=-all
export WINE_VERSION=`wine --version` #Needed for PTS to report wine version to system-layer
export TEST_RESULTS_NAME="$WINE_VERSION"
export TEST_RESULTS_IDENTIFIER="`hostname -s`-st: $WINE_VERSION"
export WINEDLLOVERRIDES="mscoree,mshtml=" #Disable wine pop-ups for Mono and Gecko not being installed
#export TMUSER="" #your TrackMania Nations Forever username - for tmnations test-profile
#export TMPWD=""  #your TrackMania Nations Forever password - for tmnations test-profile

#settings Steam credentials here is not needed if your Steam (wine) is set to remember password and autologin in your account
#export STEAMUSER="" #your Steam username - for test-profiles that require Steam, like Tomb Raider (2013) test-profile
#export STEAMPWD=""  #your Steam password - for test-profiles that require Steam, like Tomb Raider (2013) test-profile

export KEY_3DMARK06="" #this should be set to your 3DMark06 Professional Edition serial-number
