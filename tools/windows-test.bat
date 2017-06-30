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
set lzmwName=%2
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
if "%1" == "-h" (
    echo Usage   : %0  IsSavingToFile  lzmwName   SleepSeconds  ReplaceTo
    echo Example : %0       -- directly test and output on this command window, using lzmw.
    echo Example : %0   1   -- output to files and compare with base-windows-**.log, using lzmw.
    echo Example : %0   0              lzmw           3    -- output to window, sleep 3 seconds for each execution.
    echo Example : %0   0              lzmwdbg        3             -cA
    exit /b 0
)

if "%lzmwName%" == "" set lzmwName=lzmw
if "%SleepSeconds%" == "" set SleepSeconds=3

if "%~4" == "" (
    set "ReplaceTo=-c"
)

set lzmwThis=%lzmwName%

:: Check and add tool directory to %PATH% in case of no lzmw.exe
%lzmwThis% -z "%PATH%" -ix "%ThisDir%;" -PAC >nul -- Can also use -H 0 to hide result and -M to hide summary.
if %ERRORLEVEL% LSS 1 SET "PATH=%PATH%;%ThisDir%;"

set StopCalling="::Stop calling"
set FirstReplaceForFile=%lzmwName% -it "lzmw -c" -o "lzmw %ReplaceTo%" -p %SourceFile% --nt "\s+-R\b" -PAC
set FirstReplaceForPipe=%lzmwName% -it "lzmw -c" -o "lzmw %ReplaceTo% -A" -p %SourceFile% --nt "\s+(-R|-PAC|-PIC)\b" -PAC
set ReplaceExeName=%lzmwName% -it "\blzmw\s+" -o "%lzmwName% " -PAC
::set ReplaceToThisDirMainCmd=%lzmwName% -ix "%%~dp0" -o "%ThisDir2Slash%"
set ReplaceToThisDirMainCmd=%lzmwName% -ix "%%~dp0" -o %ThisDir% -a

:: Need append file like : -p %pipeResult%  or -p %fileResult%
set UnifyPipeTestExeName=%lzmwName% -it "(\|\s*)%lzmwName%\b" -o "${1}lzmw" -ROc
set UnifyFileTestExeName=%lzmwName% -it "(^|\|\s+|^\s*echo\s+)%lzmwName%\b" -o "$1lzmw" -ROc
set UnifyExtraExeName=%lzmwName% -it "%lzmwName% (-cA|-x)" -o "lzmw $1" -ROc
set RemoveDateTimeDir=%lzmwName% -it "Used\s*\d+.*from\s*\d+.*|[,;]*\s*(Directory|command)\s*=.*|[,;]*\s*read\s+\d+\s+line.*" -o "" -ROc
set UnifyDirectory=%lzmwName% -it "(^|\s+)[\\\\/\w\.:-]+(example-commands.bat|sample-file.txt)" -o "$1$2" -ROc
set UnifyCurrentToDot=%lzmwName% -ix "%ThisDir%" -o "." -ROc

:: Directly test and output result on current command window
if not "%IsSavingToFile%" == "1" (
    if %SleepSeconds% GTR 0 (
        :: %FirstReplaceForFile% -q %StopCalling%| %ReplaceExeName% | %ReplaceToThisDirMainCmd% -PAC | %lzmwName% -t "^.+$" -o "$0 && sleep %SleepSeconds%" -XI
        for /F "tokens=*" %%a in ('%FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd% -PAC ') do (
            echo %%a | %lzmwThis% -XI 2>nul
            :: a trick to sleep
            ping 127.0.0.1 -n %SleepSeconds% -w 1000 > nul 2>nul
            echo.
        )
    )  else (
        %FirstReplaceForFile% -q %StopCalling% | %ReplaceExeName% | %ReplaceToThisDirMainCmd% -I -X
    )

    echo %SourceFile% | %lzmwName% -t .+  -o "findstr xml $0" -XI
    %lzmwName% -p %SourceFile% -b %StopCalling% -ix "%%~dp0" -o %ThisDir% -a -XI
    exit /b 0
)

echo ######### Reading from file test begin ######################## | %lzmwThis% -PA -e .+
set fileResult=%ThisDir%\file-test-result-on-windows.log
if exist %fileResult% del %fileResult%
for /F "tokens=*" %%a in ('%FirstReplaceForFile% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToThisDirMainCmd% -PIC ') do (
    echo %%a >> %fileResult%
    %%a >> %fileResult%
    echo Return = !ERRORLEVEL! : %%a >> %fileResult%
    ::%%a --verbose 2>&1 | lzmw -it "^(Return\s*=\s*\d+).*" -o "$1" -T 1 -PAC >> %fileResult%
    echo.>> %fileResult%
)

echo.>>%fileResult%
echo echo %SourceFile% ^| %lzmwName% -t .+  -o "findstr xml $0" -XA >> %fileResult%
echo %SourceFile% | %lzmwName% -t .+  -o "findstr xml $0" -XA >>  %fileResult%

echo.>>%fileResult% & echo.>>%fileResult%
echo %lzmwName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %%~dp0 -a -PAC ^| %lzmwName% -it "\blzmw\b" -o "%lzmwName%" -a -XPAC >> %fileResult%
%lzmwName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %ThisDir% -a -PAC | %lzmwName% -it "\blzmw\b" -o "%lzmwName%" -a -XPAC >> %fileResult%

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
%FirstReplaceForPipe% -q %StopCalling% | %ReplaceExeName% | %ReplaceToThisDirMainCmd% -PAC | %lzmwName% --nt "--wt|--sz"  -it "^(lz.*)\s+-p\s+(\S+)(\s*.*)" -o "type $2 | $1 $3" -XI > %pipeResult%
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
