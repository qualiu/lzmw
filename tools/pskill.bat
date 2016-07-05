@echo off
rem Kill process by id list or commandline matching
rem lzmw -f "\.bat$" -it "^\s*(@?echo)\s+off\b" -o "$1 on" -N 9 -R -p .
rem lzmw -f "\.bat$" -it "^\s*(@?echo)\s+on\b" -o "$1 off" -N 9 -R -p .

SetLocal EnableExtensions EnableDelayedExpansion

rem @echo %* | findstr "[A-Za-z]">nul && call :KillByRegex %* || call :KillByPID %*

if "%~1" == "" (
    echo Usage   : %0  process-match-options or process-id-list
    echo Example : %0  -i -t "java.*-X\S+|cmd.exe"  ---- kill process by commandline matching, more info run : lzmw.exe
    echo Example : %0  2030 3021                    ---- kill process by id
    exit /b 0
)

set allArgs=%*
set allArgs=%allArgs:|= %
set allArgs=%allArgs:"=%
@SET "NotNumber=" & for /f "delims=0123456789 " %%a in ("%allArgs%") do @set NotNumber=%%a

if defined NotNumber (
    rem echo Kill process by pid list: %*
    psall %*
    rem for %%a in (%*) do call set "xpids=/pid %%a %xpids%"
    rem if not "%xpids%" == "" taskkill /f %xpids%
    for /F "tokens=2" %%a in (' psall %* -PAC ') do taskkill /f /pid %%a
) else (
    rem @echo Kill process by regex : %*
    rem for /F "tokens=2" %%a in ('psall -it %* -PAC') do (call set "xpids=/pid %%a %xpids%")
    rem for /F "tokens=2" %%a in ('psall -it %* -PAC') do (set "xpids=/pid %%a %xpids%")
    rem for /F "tokens=2" %%a in ('psall -it %* -PAC') do ( set "xpids=/pid %%a !xpids!" )
    rem for /F "tokens=2" %%a in ('psall -it %* -PAC') do ( set xpids=/pid %%a !xpids! )
    rem if not "%xpids%" == "" taskkill /f %xpids%
    for %%a in ( %* ) do taskkill /f /pid %%a
)
