:: #############################################
:: Running this script will show you a vivid colorful demo of lzmw.
:: This script calls the commands/lines in example-commands.bat which can be directly executed.
:: The difference to example-commands.bat is that this script can also :
::  1) Test reading/replacing in files and pipe by following 'Reading from file test' and 'Reading from pipe test'.
::  2) Test -X which executes output lines as commands.
::  3) Compare the 2 above test results with base-windows-file-test.log and base-windows-pipe-test.log.
:: #############################################

@echo off
SetLocal EnableExtensions EnableDelayedExpansion
set IsSavingToFile=%1
set lzmwExeName=%2
set SleepSeconds=%3
set ReplaceTo=%4

set ThisDir=%~dp0
if %ThisDir:~-1% == \ set ThisDir=%ThisDir:~0,-1%
set ThisDir2Slash=%ThisDir:\=\\%

for %%a in ("%ThisDir%") do set ParentDir=%%~dpa
if %ParentDir:~-1% == \ set ParentDir=%ParentDir:~0,-1%
set ParentDir2Slash=%ParentDir:\=\\%

where lzmw.exe 2>nul >nul || if not exist %ThisDir%\lzmw.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %ThisDir%\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%ThisDir%;%PATH%"

where nin.exe 2>nul >nul || if not exist %ThisDir%\nin.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/nin.exe?raw=true -OutFile %ThisDir%\nin.exe"
where nin.exe 2>nul >nul || set "PATH=%ThisDir%;%PATH%"

set SourceFile=%ThisDir%\example-commands.bat
if "%1" == "-h" set IsShowUsage=1
if "%1" == "--help" set IsShowUsage=1
if "%1" == "/?" set IsShowUsage=1

if "%IsShowUsage%" == "1" (
    echo Usage   : %0  IsSavingToFile  lzmwExeName   SleepSeconds  ReplaceTo
    echo Example : %0       -- directly test and output on this command window, using lzmw.
    echo Example : %0   1   -- output to files and compare with base-windows-**.log, using lzmw.
    echo Example : %0   0              lzmw           3    -- output to window, sleep 3 seconds for each execution.
    echo Example : %0   0              lzmwdbg        3             -cA
    exit /b 0
)

if "%lzmwExeName%" == "" set lzmwExeName=lzmw
if "%SleepSeconds%" == "" set SleepSeconds=3

if "%~4" == "" (
    set "ReplaceTo=-c"
)

set lzmwThis=lzmw
:: Check and add tool directory to %PATH% in case of no %lzmwExeName%.exe
%lzmwThis% -z "%PATH%" -ix "%ThisDir%;" -PAC >nul -- Can also use -H 0 to hide result and -M to hide summary.
if %ERRORLEVEL% LSS 1 SET "PATH=%PATH%;%ThisDir%;"

set StopCalling="::Stop calling"
set FirstReplaceForFile=%lzmwExeName% -it "%lzmwThis% -c" -o "%lzmwExeName% %ReplaceTo%" -p %SourceFile% --nt "\s+-R\b" -PAC
set FirstReplaceForPipe=%lzmwExeName% -it "%lzmwThis% -c" -o "%lzmwExeName% %ReplaceTo% -A" -p %SourceFile% --nt "\s+(-R|-PAC|-PIC)\b" -PAC
set ReplaceExeName=%lzmwExeName% -it "\b%lzmwExeName%\s+" -o "%lzmwExeName% " -PAC
::set ReplaceToThisDirMainCmd=%lzmwExeName% -ix "%%~dp0" -o "%ThisDir2Slash%"
set ReplaceToThisDirMainCmd=%lzmwExeName% -ix "%%~dp0" -o %ThisDir% -a

:: Need append file like : -p %pipeResult%  or -p %fileResult%
set UnifyPipeTestExeName=%lzmwExeName% -it "(\|\s*)%lzmwExeName%\b" -o "${1}%lzmwThis%" -ROc UnifyPipeTestExeName
set UnifyFileTestExeName=%lzmwExeName% -it "(^|\|\s+|^\s*echo\s+)%lzmwExeName%\b" -o "$1%lzmwThis%" -ROc UnifyFileTestExeName
set UnifyExtraExeName=%lzmwExeName% -it "%lzmwExeName% (-cA?|-x)" -o "%lzmwThis% $1" -ROc UnifyExtraExeName
set RemoveDateTimeDir=%lzmwExeName% -it "Used\s*\d+.*from\s*\d+.*|[,;]*\s*(Directory|command)\s*=.*|[,;]*\s*read\s+\d+\s+line.*" -o "" -ROc RemoveDateTimeDir
set UnifyDirectory=%lzmwExeName% -it "(^|\s+)[\\\\/\w\.:-]+(example-commands.bat|sample-file.txt)" -o "$1$2" -ROc UnifyDirectory
set UnifyCurrentToDot=%lzmwExeName% -ix "%ThisDir%" -o "." -ROc UnifyCurrentToDot

:: Directly test and output result on current command window
if not "%IsSavingToFile%" == "1" (
    if %SleepSeconds% GTR 0 (
        :: %FirstReplaceForFile% -q %StopCalling%| %ReplaceExeName% | %ReplaceToThisDirMainCmd% -PAC | %lzmwExeName% -t "^.+$" -o "$0 && sleep %SleepSeconds%" -XI
        echo %FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd%
        for /F "tokens=*" %%a in ('%FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd% -PAC ') do (
            echo %%a | %lzmwThis% -XI 2>nul
            :: a trick to sleep
            ping 127.0.0.1 -n %SleepSeconds% -w 1000 > nul 2>nul
            echo.
        )
    )  else (
        echo %FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd%
        %FirstReplaceForFile% -q %StopCalling% | %ReplaceExeName% | %ReplaceToThisDirMainCmd% -I -X
    )

    echo %SourceFile% | %lzmwExeName% -t .+  -o "findstr xml $0" -XI
    %lzmwExeName% -p %SourceFile% -b %StopCalling% -ix "%%~dp0" -o %ThisDir% -a -XI
    exit /b 0
)

echo ######### Reading from file test begin ######################## | %lzmwThis% -PA -e .+
set fileResult=%ThisDir%\file-test-result-on-windows.log
if exist %fileResult% del %fileResult%
echo %FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd%
for /F "tokens=*" %%a in ('%FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd% -PIC ') do (
    echo %%a >> %fileResult%
    %%a >> %fileResult%
    echo Return = !ERRORLEVEL! : %%a >> %fileResult%
    ::%%a --verbose 2>&1 | %lzmwExeName% -it "^(Return\s*=\s*\d+).*" -o "$1" -T 1 -PAC >> %fileResult%
    echo.>> %fileResult%
)

echo.>>%fileResult%
echo echo %SourceFile% ^| %lzmwExeName% -t .+  -o "findstr xml $0" -XA >> %fileResult%
echo %SourceFile% | %lzmwExeName% -t .+  -o "findstr xml $0" -XA >>  %fileResult%

echo.>>%fileResult% & echo.>>%fileResult%
echo %lzmwExeName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %%~dp0 -a -PAC ^| %lzmwExeName% -it "\b%lzmwThis%\b" -o "%lzmwExeName%" -a -XPAC
echo %lzmwExeName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %%~dp0 -a -PAC ^| %lzmwExeName% -it "\b%lzmwThis%\b" -o "%lzmwExeName%" -a -XPAC >> %fileResult%
%lzmwExeName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %ThisDir% -a -PAC | %lzmwExeName% -it "\b%lzmwThis%\b" -o "%lzmwExeName%" -a -XPAC >> %fileResult%

%UnifyFileTestExeName% -p %fileResult%
%RemoveDateTimeDir% -p %fileResult%
%UnifyExtraExeName% -p %fileResult%
%UnifyDirectory% -p %fileResult%
%UnifyCurrentToDot% -p %fileResult%

call :Compare_Title_Files "File test comparison" %ThisDir%\base-windows-file-test.log  %fileResult%

echo. & echo.

set /a allDifferences=0
echo ######### Reading from pipe test begin ######################## | %lzmwThis% -PA -e .+
set pipeResult=%ThisDir%\pipe-test-result-on-windows.log
echo %FirstReplaceForPipe% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd% -PAC ^| %lzmwExeName% --nt "--wt|--sz" -it "^(%lzmwExeName%.*?)\s+-p\s+(\S+)(\s*.*)" -o "type $2 | $1 $3" -XI
%FirstReplaceForPipe% -q %StopCalling% | %ReplaceExeName% | %ReplaceToThisDirMainCmd% -PAC | %lzmwExeName% --nt "--wt|--sz" -it "^(%lzmwExeName%.*?)\s+-p\s+(\S+)(\s*.*)" -o "type $2 | $1 $3" -XI > %pipeResult%
%UnifyPipeTestExeName% -p %pipeResult%
%RemoveDateTimeDir% -p %pipeResult%
%UnifyExtraExeName% -p %pipeResult%
%UnifyDirectory% -p %pipeResult%
%UnifyCurrentToDot% -p %pipeResult%

call :Compare_Title_Files "Pipe test comparison" %ThisDir%\base-windows-pipe-test.log %pipeResult%
set /a allDifferences+=%ERRORLEVEL%
exit /b %allDifferences%

:: Always return 0 so NOT use : diff %fileResult% %ThisDir%\base-windows-file-test.log
:: Call nin.exe to get the differences count which ERRORLEVEL as following. By the way, this is an example of nin.exe .
:Compare_Title_Files
    :: nin %2 %3 >nul
    nin %2 %3 -H 0
    set /a diff1=%ERRORLEVEL%
    :: nin %3 %2 >nul
    nin %2 %3 -H 0 -S
    set /a diff2=%ERRORLEVEL%

    if %diff1% EQU %diff2% (
        set /a differences=%diff1%
    ) else (
        set /a differences=%diff1%+%diff2%
    )

    if %differences% GTR 0 (
        echo ######### %1 has %differences% differences ############# | %lzmwThis% -PA -it "(\d+)|\w+" -e "#+"
        where bcompare >nul 2>nul && start bcompare %2 %3
    ) else (
        echo ######### %1 passed and no differences ############# | %lzmwThis% -PA -ie "( no )|\w+|#+"
    )
    exit /b %differences%
