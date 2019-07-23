# DCS Stuff

DontCamp.com DCS community maps and tools!

## Skin package management with skindle

skindle is a program that allows a community of DCS hotshots to see one
another's sweet liveries.  Basically, it grabs an agreed-upon list of skins
that everyone should have, and installs them automatically for each wannabe
pilot who runs it.

### How to use skindle

* Ensure that you've installed [7-Zip 64-bit](https://7-zip.org/) to the
  default installation directory at `Program Files\7-Zip`
* Download the [standalone EXE file](https://github.com/DontCamp/dcs/releases)
  from the releases page.
* Run skindle.

In theory, skindle can be configured to run automatically via Steam when you
start DCS via skindle's **batch mode**. The following in the Steam launch
options for DCS might do the trick:

```C:\Windows\System32\cmd.exe /c "C:\Users\me\skindle.exe -b" & %command%```
