::============================================================
:: Kill processes by their id or command line matching pattern.
:: Will show the processes info with colors before killing.
::============================================================
@echo off

SetLocal EnableDelayedExpansion

rem @echo %* | findstr "[A-Za-z]">nul && call :KillByRegex %* || call :KillByPID %*
if "%~1" == ""       set ToShowUsage=1
if "%~1" == "-h"     set ToShowUsage=1
if "%~1" == "--help" set ToShowUsage=1
if "%~1" == "/?"     set ToShowUsage=1

set ThisDir=%~dp0
if %ThisDir:~-1%==\ set ThisDir=%ThisDir:~0,-1%

where lzmw.exe 2>nul >nul || if not exist %ThisDir%\lzmw.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %ThisDir%\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%ThisDir%;%PATH%"
for /f "tokens=*" %%a in ('where lzmw.exe 2^>nul') do set "lzmwPath=%%a"

if "%ToShowUsage%" == "1" (
    echo To see lzmw.exe matching options just run %lzmwPath% | lzmw -PA -ie "options|\S*lzmw\S*" -x lzmw
    echo Usage   : %~n0  process-match-options or process-id-list | lzmw -PA -e "option\w*|\b(id)\b" -x %~n0
    echo Example : %~n0  -i -t "java.*-X\S+|cmd.exe" -x C:\Windows --nx Windows\System32 ---- kill processes by commandline matching | lzmw -PA -e "\s+-+\w+|lzmw" -x %~n0
    echo Example : %~n0    -it "java.*-X\S+|cmd.exe" -x C:\Windows --nx Windows\System32 --nt lzmw\.exe ---- kill processes by commandline matching | lzmw -PA -e "\s+-+\w+|lzmw" -x %~n0
    echo Example : %~n0  2030 3021 19980                  ---- kill process by id | lzmw -PA -e "(\s+\d+|\bid\b)" -x %~n0
    exit /b 0
)

:: Test args for lzmw.exe
lzmw -z test-string %* >nul 2>nul
if %ERRORLEVEL% LSS 0 (
    echo Error parameters for %~nx0: %* , test with: -z test-string: | lzmw -aPA -t "Error.*for \S+(.*(test with.*(-z (test-string))))"
    lzmw -z test-string %*
    exit /b -1
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

lzmw -z "!pids!" -t "\d+" >nul || taskkill /f !pids!
