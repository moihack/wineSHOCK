# wineSHOCK
Collection of patches and scripts for my GSoC 2018 Wine project

The patsh branch contains my PATches for Phoronix Test Suite (PTS) to be used for my Summer of Code project and some SHell scripts to automate some tasks.

When starting out, you can use the pts_setup.sh script which downloads PTS version 8 and applies some small patches to detect wine version when on Linux.

When running PTS on Linux and before running any tests from the profiles branch you want to source the pts_prerun.sh script (e.g. source ./pts_prerun.sh && phoronix-test-suite run <test-name>) before actually running the tests.
This script sets some variables needed for the test profiles to install at the correct locations and use the default system wine prefix.
