# wineSHOCK

## Repository with code and documentation for my ![GSoC Logo](https://summerofcode.withgoogle.com/static/img/summer-of-code-logo.svg) GSoC 2018 Wine project (Direct3D - Automated game benchmarks)

The **profiles** branch contains the test-profiles and test-suites for Phoronix-Test-Suite that I created during my Summer of Code project.

The **patsh** branch contains any **pat**ches/diffs and **sh**ell scripts I created during the project to speed up some procedures (e.g. setting up my test environment quickly from scratch)

Before diving up to the document below, let's first introduce some terms and their meanings.

Term | Meaning
------------ | -------------
ahk | [AutoHotKey](https://autohotkey.com/) - an open source scripting automation language for Windows
PTS | [Phoronix-Test-Suite](https://www.phoronix-test-suite.com/) - a cross-platform open source automation/benchmarking solution
test-profile | a set of files (scripts + xml) that is used to install and monitor the performance of a program using PTS
test-suite | a predefined collection of PTS test-profiles that installs and runs multiple profiles with one command

## Setting up PTS
To quickly setup PTS open a terminal and run:
```bash
git clone https://github.com/moihack/wineSHOCK -b patsh && cd wineSHOCK && ./pts_setup.sh
```
Afterwards open [pts_prerun.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_prerun.sh) and there input add your **WINEPREFIX** path as well as uncomment any other variables you want to use with PTS.

The [pts_setup.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_setup.sh) script does fetch a stable PTS version(v8.0.1) and patches it to report wine-version to system layer as well as solve some weird PTS localization issues (see **NOTES** below).

## Running PTS

**Note: Before running PTS each time you need to import all variables defiend in pts_prerun.sh with source command**

from phoronix-test-suite folder:
```bash
source ../pts_setup.sh
```
Now you can install a test-profile by running:

```bash
./phoronix-test-suite install {test-name} 
```

or run an installed test-profile with:
```bash
./phoronix-test-suite run {test-name} 
```

### Example installing and running the [clear_d3d microbenchmark](http://openbenchmarking.org/test/moihack/clear_d3d)

from phoronix-test-suite folder:
```bash
source ../pts_setup.sh
./phoronix-test-suite install moihack/clear_d3d
./phoronix-test-suite run moihack/clear_d3d
```

## NOTES
The PTS test-profiles contained in **profiles** branch, report that are cross-platform supporting both Windows and Linux.

However this is partially true.
The test-profiles are designed specifically for testing Wine Direct3D/gaming performance across different Wine versions.
They run (and can be used) for measuring performance on native Windows systems too.

The Linux version of the scripts is just a modification of the Windows profiles that launch games via Wine.
This allows to natively run PTS on Linux hosts without needing Cygwin,PHP and other things which could break things when running inside Wine.

This has the disadvantage that 2 separate versions have to be maintained for each test-profile.
There is currently the not-so-well-tested [USE_WINE](https://github.com/phoronix-test-suite/phoronix-test-suite/blob/master/pts-core/modules/use_wine.php) tag that one can use in a PTS test-profile. Using it will install (with automatic modifications on the fly) the Windows version of a profile on a Linux host which would not be possible otherwise.

~~Please keep in mind, that depending on the test-profile, the Linux version may differ more or less than the Windows version of the same profile.
That is because when launching wine from PTS sometimes "bugs" occurred mainly revolving around localization issues.~~
Solved thanks to [this](https://github.com/moihack/wineSHOCK/blob/patsh/0003-pts_tests.patch).

Todo: How to create a new test-profile

## Games that feature a built-in benchmark, yet do not yet have a test-profile available
Game | Notes
------------ | -------------
Devil May Cry 4 | Features standalone benchmark. Runs fine under wine. Does not output results to file/stdout. Needs ahk to launch benchmark option.
Mafia II (Steam) | Runs fine under wine. Does not output results to file/stdout. Needs ahk to launch benchmark option.
Alien: Isolation (Steam) | Runs fine under wine-staging-nine from Arch repos. Does not run with vanilla wine. See bug:
Hitman Absolution (Steam) | Runs fine under wine. Currently launching the game's benchmark crashes. See bug:
DiRT, F1 games (Steam) | Most of these games don't boot or display a blackscreen when trying to play. They output the results to an .xml file but they need ahk to navigate to the benchmark options.
Bioshock: Infinite (Steam) | Launching but hanging before the main menu.
Batman: Arkham Games (Steam) | They don't run under current wine (maybe they can boot with specific winetricks and oldest wine versions).
Middle-earth: Shadow of Mordor (Steam) | Currently does not run under wine. Needs ahk to launch benchmark option.
Call of Juarez | Features standalone DX10 benchmark. Does not run under wine due to securom complaining about some registry entries being tampered.
Rise of the Tomb Raider | Don't own it so didn't test. Should be working as Tomb Raider (2013) under wine though.
Metro 2033 : Redux (Steam) | The game runs on wine but the benchmark config app that comes with the game needs .NET and does not run under wine. The game will output an error even on Windows when trying to launch it with benchmark parameters (obtained from Process Explorer)
