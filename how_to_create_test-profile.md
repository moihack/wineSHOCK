# How to create a new test-profile for the Phoronix-Test-Suite

## Introduction
Below we'll cover on how to create a new test-profile for the Phoronix-Test-Suite (PTS).
Since this text was written as documentation for my GSoC 2018 project, it may feature some steps related directly to the workflow of the project.
Usually these steps would have to do with testing on Linux via wine and checking if an app runs on wine.
Of course any step that do not fit your workflow/needs can be safely be skipped.

## Installation procedures and silent installation parameters

First find the program/game/standalone benchmark you want to create a test-profile for.

Perform a normal installation of the software you choosen on Windows (and also on Linux via wine if you want to create a test-profile to improve my GSoC project).
Ensure the installation completes normally on both platforms and take note for any possible extra dialogs that come up in the process and or dependencies that needed to be installed (like .NET for some installers for example).

Run the software and check if it runs without needing any extra runtimes (like DirectX, .NET , MSVC++ etc).

Now it is time to investigate if there any useful command line switches for installation and/or runtime.

Here is [a page](http://unattended.sourceforge.net/installers.php) that covers all **silent install** switches for the most common installers available.
You can use this to usually find a way to at least perform the installation of the test-profile completely silently and without the need for user interaction.

If you can't find a silent command line switch consider checking in a windows-repository like [Chocolatey](https://chocolatey.org/) and see if the installation script contains any useful command line switches.

Win-RAR and 7-Zip unpackers/installers can usually be unpacked with the standard unzip tool and/or contain a silent switch as well.

## Searching for benchmark command line arguments

Now onto finding if the software you want to create a test-profile for, can accept any benchmark command line arguments. 
Usually a google search like: **{game name} benchmark command line arguments** can reveal some useful information (e.g. Alien:Isolation).
Also check the game's installation folder and read any .txt/.pdf (in general every human readable file) as sometimes they contain information about the benchmark parameters (e.g. Hitman: Absolution).

If the game contains a separate program that adjusts parameters and launches the benchmark (e.g. Far Cry 2, Metro 2033) then you can open **[Process Explorer](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer)** to see the exact parameters that were passed to the main game/benchmark.
You can then copy them and try invoking the game from the command line with these.

You can also try inspecting the game's .exe file with the **[Strings](https://docs.microsoft.com/en-us/sysinternals/downloads/strings)** utility and search through all of the strings contained in the file for something that looks like command line arguments (usually a string starting with **-** could be a command line parameter).

Lastly if all of the above didn't lead to any results, you will have to use [AutoHotKey](https://autohotkey.com/) to press the combination of buttons required to launch the benchmark from the game's menu.

## Creating the test-profile's files

Each PTS test-profile contains a specific number of files, gathered alltogether in a folder, each one with its own special meaning.
Let's see what these files are:

**test-definition.xml:** As the name suggests, this file defines the basic information for the PTS test-profile. There you define the title of the test-profile, its description, what will the result scale be (usually **Frames Per Second** for our purpose), how many times to run the test-profile etc.
Here you also define which platforms the test-profile supports.
Usually you want to have: `<SupportedPlatforms>Windows, Linux</SupportedPlatforms>` in order to support both Windows and Linux alike.
Finally, in this file you can also include **`<TestSettings>`** options which are practical variables that you can use to pass specific arguments to your test-profile and configure it on-the-fly before each run. You can for example have a resolution and anti-alliasing option, so one time your test-profile runs at 1280x720 with 2xAA and one time at 1920x1080 with 8xAA.
Here is an example of a [test-definition.xml file](https://github.com/moihack/wineSHOCK/blob/profiles/tmnations/test-definition.xml) and of a [script making use of the `<TestSettings>` options](https://github.com/moihack/wineSHOCK/blob/profiles/3dmark2006/install_windows.sh#L54).

**results-definition:** Again as the same suggests, it is the file that the PTS parser will "ask for advice" before parsing your test-profile's logs after running.
Using the **`<OutputTemplate>`** template tag you define the regular expression which the parser has to look for to find the result.
For example:     `<OutputTemplate>average #_RESULT_# fps</OutputTemplate>` will tell the parser to search for a line containing average, than having a space and a value (which is the result in our case), another space and is followed by the word fps.
The tag `<LineBeforeHint>` can also be used to help the parser find the correct line. Using it, we inform the parser on what the line before the result line/OutputTemplate will in our log file. Note that the LineBeforeHint is not required.
Here is an example of a [results-definion.xml file](https://github.com/moihack/wineSHOCK/blob/profiles/tmnations/results-definition.xml).

**downloads.xml:** In this file you declare all of the files your test-profile needs to download from the Internet in order to install,config,run etc the software you create the test-profile for.
Here you'll usually put a link to some kind of setup.exe program and maybe some links to runtime libraries to install.
You can also supply a filesize (obtained with du -b) and an md5sum for a file, so PTS can check if a download corrupted in the process. If your profile does not need any files from the Internet you can simply skip the creation of this file.
Here is an example of a [downloads.xml file](https://github.com/moihack/wineSHOCK/blob/profiles/stalker_cs/downloads.xml)

**install_windows.sh:** In this file the installation procedure of your test-profile is defined. Usually there you invoke the installer you just downloaded using the downloads.xml file. Also, in this file you create the execution binary of your test-profile. The execution binary is basically a shell script you output from the install.sh script. The output file needs to have the same name as the name of the test-profile and also make sure it has execution rights set (chmod +x). Here is an example of an [install_windows.sh script](https://github.com/moihack/wineSHOCK/blob/profiles/stalker_cs/install_windows.sh).

**install.sh:** Like **install_windows.sh** script but for Linux platforms. Everything that applies above, applies here as well. In the case you want to benchmark wine performance your install.sh script will be heavily based on your **install_windows.sh** script.
The usual changes you will have to perform are:

1. add wine in front of every line launching an .exe file
e.g: **./crysis.exe** becomes **_wine_ ./crysis.exe**

2. replace any **"C:/pathname_here"** with __"*$WINEPREFIX/drive_c*/pathname_here"__
**Note:** you don't need to replace every reference to "C:/". For example in an ahk script, since ahk will be invoked inside wine, you can keep the reference to "C:/" as ahk will think it runs on Windows and continue finding the path normally.

Here is an example of a typical [install.sh script](https://github.com/moihack/wineSHOCK/blob/profiles/stalker_cs/install.sh).

## Optional files

There are also some files that can be found in some test-profiles and can offer some extra useful funcionality for our PTS tests.
These are:

**pre.sh:** The pre.sh script runs just before a test-profile is executed.
So if a test is going to run 3 times, the pre.sh will run just before the first runs begins and it will not run again until the test-profile is relaunched (this means that all 3 runs completed, a result was gathered and afterwards the user relaunched the test-profile).
The pre.sh script is useful if you want to configure/output a game settings file (.ini/.txt etc) with the game's selected options just before running the actual test-profile.

**interim.sh:** The interim.sh script runs in between each test-run. So if a test is going to run 3 times than the interim.sh will get executed 
between the 1st-->2nd run and 2nd-->3rd run.

**post.sh:** The post.sh script runs after all the runs of a test-profile got executed. So if a test is goin to run 3 times, post.sh will get executed after the third run got completed.

**Note:** By default pre.sh , interim.sh and post.sh run on all platforms.
However if you only want to run such a script in a specific platform, all you have to do is add the platform name at the end of the file like this: pre_linux.sh , post_windows.sh etc.

## Testing of your newly created test-profile

In order to test your newly created test-profile you can first try it locally.
Just copy the test-profile's folder (with its contents) to the following path **/home/$HOME/.phoronix-test-suite/test-profiles/local** .

Then install it from PTS by just doing:
`./phoronix-test-suite install local/your_test_profile_name`

and afterwards launch it with:
`./phoronix-test-suite run local/your_test_profile_name`

If your test seems to work fine you can then upload it to openbenchmarking.
