@echo off
rem Kill process by id list or commandline matching
rem lzmw -f "\.bat$" -it "^\s*(@?echo)\s+off\b" -o "$1 on" -N 9 -R -p .
rem lzmw -f "\.bat$" -it "^\s*(@?echo)\s+on\b" -o "$1 off" -N 9 -R -p .

SetLocal EnableDelayedExpansion

rem @echo %* | findstr "[A-Za-z]">nul && call :KillByRegex %* || call :KillByPID %*

if "%~1" == "" (
    echo Usage   : %0  process-match-options or process-id-list
    echo Example : %0  -i -t "java.*-X\S+|cmd.exe"  ---- kill process by commandline matching, more info run : lzmw.exe
    echo Example : %0  2030 3021                    ---- kill process by id
    exit /b 5
)

set allArgs=%*
set allArgs=%allArgs:|= %
set allArgs=%allArgs:"=%
set "NotNumber=" & for /f "delims=0123456789 " %%a in ("%allArgs%") do @set NotNumber=%%a

set pids=
if defined NotNumber (
    call psall %*
    for /F "tokens=2" %%a in ('call psall %* -PAC ') do if "!pids!"=="" ( set "pids=/pid %%a" ) else ( set "pids=!pids! /pid %%a" )
) else (
    for %%a in ( %* ) do if "!pids!"=="" ( set "pids=/pid %%a" ) else ( set "pids=!pids! /pid %%a" )
)

taskkill /f !pids!
