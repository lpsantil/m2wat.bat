@echo off
REM -- m2wat.bat --
REM -- Copyright (c) 2016, Louis P. Santillan <lpsantil@gmail.com>
REM -- All rights reserved.

REM -- Usage: m2wat.bat

REM ---------- CHECK ENVIRONMENT ----------
REM -- Check for properly setup environment
IF "%MTCPCFG%"=="" goto MTCPCFGERR
IF "%WATTCP.CFG%"=="" goto WATTCPCFGERR

REM -- Check if the mTCP config file exists
IF NOT EXIST %MTCPCFG% goto INPUTERR

REM -- Determine if we're writing the new config
IF "%1"=="/W" goto WRITE
REM -- Otherwise we parse the mTCP config
goto PARSE-MTCP-CFG
REM ---------- CHECK ENVIRONMENT ----------

REM ---------- WRITE ----------
REM -- Convert mTCP config vars to WatTCP config vars
:WRITE
IF "%2"=="IPADDR" echo my_ip=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="NETMASK" echo netmask=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="GATEWAY" echo gateway=%3>>%WATTCP.CFG%\wattcp.cfg
IF "%2"=="NAMESERVER" echo nameserver=%3>>%WATTCP.CFG%\wattcp.cfg
goto END
REM ---------- WRITE ----------

REM ---------- PARSE MTCP CFG ----------
:PARSE-MTCP-CFG

REM -- Clear out the old junk first
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
REM ---------- PARSE MTCP CFG ----------

REM ---------- ERRORS ----------
:MTCPCFGERR
echo MTCPCFG environment variable is not set
goto END

:WATTCPCFGERR
echo WATTCP.CFG environment variable is not set
goto END

:INPUTERR
echo %MTCPCFG% does not exist
goto END
REM ---------- ERRORS ----------

REM ---------- END ----------
:END
set M2WCFG=
