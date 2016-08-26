# m2wat.bat
A FreeDOS batch file to convert mTCP config files to WatTCP config files

## Depends on
* FreeDOS command.com 0.84-pre2+
* FreeDOS find 3.0a.ea+

## Features
* No interaction necessary if you have `MTCPCFG` and `WATTCP.CFG` environment vars setup

## Usage
* `set MTCPCFG=C:\FDOS\MTCP.CFG`
* `set WATTCP.CFG=C:\FDOS`
* `m2wat.bat`
Or if you have `MTCPCFG` and `WATTCP.CFG` setup in your environment, say, via `AUTOEXEC.BAT`
* `m2wat.bat`
