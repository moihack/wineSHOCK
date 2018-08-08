# wineSHOCK

# Code and Documentation for my ![GSoC Logo](https://summerofcode.withgoogle.com/static/img/summer-of-code-logo.svg) GSoC 2018 Wine project (Direct3D - Automated game benchmarks)

## Repository Structure

The **profiles** branch contains the test-profiles and test-suites for Phoronix-Test-Suite that I created during my Summer of Code project.

The **patsh** branch contains any **pat**ches and **sh**ell scripts I created during the project to speed up some procedures (e.g. setting up my test environment quickly from scratch) and/or patching Phoronix-Test-Suite to better fit the project's purpose. 

The **master** branch contains documentation and more detailed info about the project.

## Basic Terms

Let's first introduce some terms and their meanings.

Term | Meaning
------------ | -------------
ahk | [AutoHotKey](https://autohotkey.com/) - an open source scripting automation language for Windows
PTS | [Phoronix-Test-Suite](https://www.phoronix-test-suite.com/) - a cross-platform open source automation/benchmarking solution
test-profile | a set of files (scripts + xml) that is used to install and monitor the performance of a program using PTS
test-suite | a predefined collection of PTS test-profiles that installs and runs multiple profiles with one command

## Setting up PTS

First make sure you have installed at least php-cli for your Linux distribution.

To quickly setup PTS open a terminal and run:
```bash
git clone https://github.com/moihack/wineSHOCK -b patsh && cd wineSHOCK && ./pts_setup.sh
```
Afterwards open [pts_prerun.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_prerun.sh) and there edit your **WINEPREFIX** path if necessary, as well as (un)comment any variables you want to become available to PTS.

The [pts_setup.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_setup.sh) script does fetch a stable PTS version(v8.0.1) and patches it to report wine-version to system layer as well as solve some weird PTS localization issues (see **NOTES** below).

## Running PTS

**Note:** Before running PTS __*in a new terminal window*__ you need to import all variables defiend in [pts_prerun.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_prerun.sh) with source command

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
#Make all necessary variables available to PTS
source ../pts_setup.sh

#Install clear overhead Direct3D microbenchmark from my openbenchmarking.org repository
./phoronix-test-suite install moihack/clear_d3d

#Run the test
./phoronix-test-suite run moihack/clear_d3d
```

**To run PTS on _Windows_**, first grab PTS [8.0.1 release](https://github.com/phoronix-test-suite/phoronix-test-suite/archive/v8.0.1.zip) and unpack it anywhere in your computer. You will also need **PHP _for Windows_** and **Cygwin**. 

Afterwards simply open a command prompt window in phoronix-test-suite folder and run:
```bash
phoronix-test-suite.bat install {test-name}
#or
phoronix-test-suite.at run {test-name}
```

**Note:** PTS does *not* need the [pts_prerun.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_prerun.sh) to run on Windows.

## Test-Profiles created during GSoC 2018
Game | Notes
------------ | -------------
[3DMark06](http://openbenchmarking.org/test/moihack/3dmark2006) | Works only for 3DMark06 Professional Edition. Needs ahk and the variable **key** in [pts_prerun.sh](https://github.com/moihack/wineSHOCK/blob/patsh/pts_prerun.sh) being set to your 3DMark06 Professional Edition serial number.
[Aliens vs. Predator DirectX 11 Benchmark Tool](http://openbenchmarking.org/test/moihack/aliens) | Standalone benchmark tool. Needs .NET 3.5 SP1 for the installer. Needs DirectX June 2010 runtime otherwise it displays a blackscreen while still putting stress on the GPU and completing successfully.
[Crysis Single Player Demo](http://openbenchmarking.org/test/moihack/crysis_sp) | Standalone benchmark tool. Boots to black screen when launched with dx10. [Bug:45125](https://bugs.winehq.org/show_bug.cgi?id=45125) 
[Far Cry 2 (Steam)](http://openbenchmarking.org/test/moihack/far_cry_2)  | Does not need Steam to be running, but the test-profile searches for the game's executable in Steam's folder. ~~Needs localization hack.~~ Install the game manually on Linux using **Steam for Windows running via wine**.
[S.T.A.L.K.E.R.: Clear Sky Benchmark Tool](http://openbenchmarking.org/test/moihack/stalker_cs) | Standalone benchmark tool. Outputs results to Public Windows user folder. 
[Sniper Elite V2 Benchmark Tool](http://openbenchmarking.org/test/moihack/sniper_v2) | Needs DirectX June 2010 runtime otherwise it displays a blackscreen while still putting stress on the GPU and completing successfully. The needed runtime gets installed automatically. It currently displays some textures with weird white/washed-out color. See [Bug:45402](https://bugs.winehq.org/show_bug.cgi?id=45402) 
[TrackMania Nations Forever](http://openbenchmarking.org/test/moihack/tmnations) | Game that uses a proprietary binary format for saving its settings. Needs ahk for configuring the game. ~~Needs localization hack.~~ Setting resolution via ahk does not work but the code is left there commented for future revisions. Based on the [profile by Stefan Dösinger](https://openbenchmarking.org/test/stefandoesinger/tmnations).
[Tomb Raider (2013) (Steam)](http://openbenchmarking.org/test/moihack/tomb_raider)| A license has to be manually accepted the first time the game runs. Didn't want to use ahk only for this and complicate the test-profile. Install the game manually on Linux using **Steam for Windows running via wine**.
[Unigine Heaven](http://openbenchmarking.org/test/moihack/heaven_wine) | The popular standalone Heaven benchmark. We run the test with dx9 renderer.
[World in Conflict - DEMO](http://openbenchmarking.org/test/moihack/worldinconflict) | DEMO of the game featuring the same benchmark as the full version. Needs ahk for automated installation. Uses ahk for configuring the game's config file. *Configuring can be rewritten in bash*. Based on the [profile by Stefan Dösinger](https://openbenchmarking.org/test/stefandoesinger/worldinconflict). ~~Needs localization hack. Needs system-wide english locale set otherwise it won't run from PTS.~~
[Direct3D microbenchmarks](http://openbenchmarking.org/suite/moihack/direct3d_microbenchmarks) | A test-suite of the Direct3D microbenchmarks by Stefan Dösinger.
[OpenGL microbenchmarks](http://openbenchmarking.org/suite/moihack/opengl_microbenchmarks) | A test-suite of the OpenGL microbenchmarks by Stefan Dösinger. | PTS had trouble downloading the freeglut libraries, so wget had to be used during the installation in order to fetch the needed libraries.

The full list of available tests can be found at the [profiles branch](https://github.com/moihack/wineSHOCK/tree/profiles) or at my [openbenchmarking repository](http://openbenchmarking.org/user/moihack).

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

## [**How to create a new test-profile**](https://github.com/moihack/wineSHOCK/how_to_create_test-profile.md)
_In order for this document to stay "small" in size I've decided to cover the instructions on how to create a new test-profile for PTS in a separate file._

## Future Improvements

### Changes to improve the test-profiles
* Add support for configuring game settings via PTS. Currently most profiles run with the same settings each time without asking the user. Only 3DMark06, TrackMania and World in Conflict support being re-configured via PTS for the time being.
* Use forward slash in all profiles when possible.
* Do some clean-up to save some code lines. Some while loops that are checking if a benchmark finished running can potentially be deleted.
* Re-write World in Conflict - DEMO to use bash instead of ahk and make use of pre.sh script to config the game.
* Try to get the Windows and Linux version identical so USE_WINE tag can be used for some profiles.

### Games that feature a built-in benchmark, yet do not have a test-profile available
Game | Notes
------------ | -------------
Devil May Cry 4 | Features standalone benchmark. Runs fine under wine. Does not output results to file/stdout. Needs ahk to launch benchmark.
Mafia II (Steam) | Runs fine under wine. Does not output results to file/stdout. Needs ahk to launch benchmark.
Alien: Isolation (Steam) | Runs fine under [wine-staging-nine from Arch repos](https://www.archlinux.org/packages/multilib/x86_64/wine-staging-nine/). Does not run with vanilla wine. See [Bug:45216](https://bugs.winehq.org/show_bug.cgi?id=45216)
Hitman Absolution (Steam) | Runs fine under wine. Currently launching the game's benchmark crashes. See [Bug:45215/43584](https://bugs.winehq.org/show_bug.cgi?id=43584)
DiRT, F1 games (Steam) | Most of these games don't boot or display a blackscreen when trying to play. They output the results to an .xml file but they need ahk to navigate to the benchmark options.
Bioshock: Infinite (Steam) | Launching but hanging before the main menu.
Batman: Arkham Games (Steam) | They don't run under current wine (maybe they can boot with specific winetricks and oldest wine versions).
Middle-earth: Shadow of Mordor (Steam) | Currently does not run under wine. Needs ahk to launch benchmark.
Call of Juarez | Features standalone DX10 benchmark. Does not run under wine due to securom complaining about some registry entries being tampered.
Rise of the Tomb Raider | Don't own it so didn't test. Should be working as Tomb Raider (2013) under wine though.
Metro 2033 : Redux (Steam) | The game runs on wine but the benchmark config app that comes with the game needs .NET and does not run under wine. The game will output an error even on Windows when trying to launch it with benchmark parameters (obtained from Process Explorer)
Just Cause 2 (Steam) | Does not boot under wine currently. Does not output to file/stdout. Needs ahk to launch benchmark.
Sid Meier's Civilization® V (Steam) | Does not work under wine. The launcher shows up but game quits with error (possibly related to DRM issues). Offers benchmarking command line options though.
Sleeping Dogs: Definitive Edition (Steam) | Does not work under wine. Needs ahk to launch benchmark. Does not output results to file/stdout.
