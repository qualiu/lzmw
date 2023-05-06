::============================================================
:: Kill processes by their id or command line matching pattern.
:: Will show the processes info with colors before killing.
:: This scripts depends and will call psall.bat.
::
:: Latest version in: https://github.com/qualiu/msrTools/
::============================================================
@echo off

SetLocal EnableDelayedExpansion
where lzmw.exe 2>nul >nul || if not exist %~dp0\lzmw.exe powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %~dp0\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%~dp0;%PATH%"

lzmw -z "LostArg%~1" -t "^LostArg(|-h|--help|/\?)$" > nul || (
    echo To see lzmw.exe matching options just run: lzmw --help | lzmw -PA -ie "options|\S*lzmw\S*" -x lzmw
    echo Usage   : %~n0  process-match-options or process-id-list | lzmw -PA -e "option\w*|\b(id)\b" -x %~n0
    echo Example : %~n0  -i -t "java.*-X\S+|cmd.exe" -x C:\Windows --nx Windows\System32 ---- kill processes by commandline matching | lzmw -PA -e "\s+-+\w+|lzmw" -x %~n0
    echo Example : %~n0    -it "java.*-X\S+|cmd.exe" -x C:\Windows --nx Windows\System32 --nt lzmw\.exe ---- kill processes by commandline matching | lzmw -PA -e "\s+-+\w+|lzmw" -x %~n0
    echo Example : %~n0  2030 3021 19980          ---- kill processes by id | lzmw -PA -e "\s+(\d+|\bid\b)" -x %~n0
    :: echo Should not use -P -A -C and their combination. | lzmw -PA -t "(-[PAC]+)|\w+"
    exit /b 0
)

:: Test args for lzmw.exe
lzmw -z justTestArgs %* >nul 2>nul
if %ERRORLEVEL% LSS 0 (
    echo Error parameters for %~nx0: %* , test with: -z justTestArgs: | lzmw -aPA -t "Error.*for (\S+)" -e "test with"
    lzmw -z justTestArgs %*
    exit /b -1
)

:: ==================================================================================
:: set allArgs=%*
:: set allArgs=%allArgs:|= %
:: set allArgs=%allArgs:"=%
:: for /f "delims=0123456789 " %%a in ("%allArgs%") do set NotAllNumbersAsPIDs=true
:: ==================================================================================

echo %* | lzmw -t "(^|\s+)(-[PACIMO]+|-[UDHT]\s*\d+|-c\s*.*)" -o "" -aPAC | lzmw -t "[^\d ]" >nul
if !ERRORLEVEL! GTR 0 set NotAllNumbersAsPIDs=true

lzmw -z justTestArgs %* -P >nul 2>nul
if !ERRORLEVEL! NEQ -1 set NoPathToPsAll=-P

lzmw -z justTestArgs %* -A >nul 2>nul
if !ERRORLEVEL! NEQ -1 set NoInfoToPsAll=-A

call psall.bat %* !NoPathToPsAll! -c Before killing processes %~nx0 calls psall.bat to check and display.

if !ERRORLEVEL! LSS 1 exit /b !ERRORLEVEL!

set pids=
if "!NotAllNumbersAsPIDs!" == "true" (
    for /f "tokens=*" %%a in ('call psall.bat %* !NoPathToPsAll! !NoInfoToPsAll! ^| lzmw -t "^\d+\t(\d+).*" -o "/pid \1" -PAC ^| lzmw -S -t "\s+" -o " " -PAC') do set pids=%%a
) else (
    for /f "tokens=*" %%a in ('echo %* ^| lzmw -t "\s*(\d+)\s*" -o " /pid $1" -PAC') do set pids=%%a
)

:: Only call taskkill if has PID - numbers
:: echo !pids! | lzmw -t "\d+" >nul || taskkill /f !pids!
echo !pids! | lzmw -t "\d+" >nul
if !ERRORLEVEL! GTR 0 (
   taskkill /f !pids!
) else (
   rem echo %date% %time%: %~nx0 Not found processes. Args = %* ,  PIDs = !pids! | lzmw -aPA -x "Not found" -e %~nx0 -t "Args = .*(?=PID)"
)
