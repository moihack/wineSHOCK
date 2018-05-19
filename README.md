# wineSHOCK
Collection of test-profiles for Phoronix Test Suite (PTS) .

The PTS test-profiles contained in this repo report that are cross-platform supporting both Windows and Linux.

However this is partially true.
The test-profiles are designed specifically for testing Wine performance across different Wine versions.
They run (and can be used) for measuring performance on native Windows systems.

The Linux version of the scripts however is just a modification of the Windows profiles that runs from inside Wine.
This allows to natively run PTS on Linux hosts without needing Cygwin,PHP and other things which might cause problems when running inside Wine.
