#!/bin/sh

export WINEPREFIX=~/ptsprefix
export WINEPREFIX=~/.wine
export WINEDEBUG=-all
export WINE_VERSION=`wine --version`
export TEST_RESULTS_NAME="$WINE_VERSION"
export TEST_RESULTS_IDENTIFIER="`hostname -s`-st: $WINE_VERSION"
export WINEDLLOVERRIDES="mscoree,mshtml="
