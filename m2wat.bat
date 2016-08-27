@echo off
:: -- m2wat.bat --
:: -- Copyright (c) 2016, Louis P. Santillan <lpsantil@gmail.com>
:: -- All rights reserved.

:: -- Usage: m2wat.bat

:: ---------- CHECK ENVIRONMENT ----------
:: -- Check for properly setup environment
IF "%MTCPCFG%"=="" goto MTCPCFGERR
IF "%WATTCP.CFG%"=="" goto WATTCPCFGERR

:: -- Check if the mTCP config file exists
IF NOT EXIST %MTCPCFG% goto INPUTERR

:: -- Determine if we're writing the new config
IF "%1"=="/W" goto WRITE
:: -- Otherwise we parse the mTCP config
goto PARSE-MTCP-CFG
:: ---------- CHECK ENVIRONMENT ----------

:: ---------- WRITE ----------
:: -- Convert mTCP config vars to WatTCP config vars
:WRITE
IF "%2"=="IPADDR" echo my_ip=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="NETMASK" echo netmask=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="GATEWAY" echo gateway=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="NAMESERVER" echo nameserver=%3>>%WATTCP.CFG%\wattcp.cfg
goto END
:: ---------- WRITE ----------

:: ---------- PARSE MTCP CFG ----------
:PARSE-MTCP-CFG

:: -- Clear out the old junk first
:CLEAR-OLD-FILES
echo. >%WATTCP.CFG%\wattcp.cfg

:IPADDR
find "IPADDR" <%MTCPCFG% |set /P M2WCFG=
call %0 /W %M2WCFG%>>%WATTCP.CFG%\wattcp.cfg
:NETMASK
find "NETMASK" <%MTCPCFG% |set /P M2WCFG=
call %0 /W %M2WCFG%>>%WATTCP.CFG%\wattcp.cfg
:GATEWAY
find "GATEWAY" <%MTCPCFG% |set /P M2WCFG=
call %0 /W %M2WCFG%>>%WATTCP.CFG%\wattcp.cfg
:NAMESERVER
find "NAMESERVER" <%MTCPCFG% |set /P M2WCFG=
call %0 /W %M2WCFG%>>%WATTCP.CFG%\wattcp.cfg
goto END
:: ---------- PARSE MTCP CFG ----------

:: ---------- ERRORS ----------
:MTCPCFGERR
echo MTCPCFG environment variable is not set
goto END

:WATTCPCFGERR
echo WATTCP.CFG environment variable is not set
goto END

:INPUTERR
echo %MTCPCFG% does not exist
goto END
:: ---------- ERRORS ----------

:: ---------- END ----------
:END
set M2WCFG=
