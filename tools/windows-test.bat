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

set CurDir=%~dp0
if %CurDir:~-1% == \ set CurDir=%CurDir:~0,-1%
set CurDir2Slash=%CurDir:\=\\%

for %%a in ("%CurDir%") do set ParentDir=%%~dpa
if %ParentDir:~-1% == \ set ParentDir=%ParentDir:~0,-1%
set ParentDir2Slash=%ParentDir:\=\\%

set SourceFile=%CurDir%\example-commands.bat
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
	if "%IsSavingToFile%" == "1" (set ReplaceTo=-cA) else (set ReplaceTo=-c)
)

set lzmwThis=%lzmwName%

set StopCalling="::Stop calling"
set FirstReplace=%lzmwName% -it "lzmw -c" -o "lzmw %ReplaceTo%" -p %SourceFile% --nt "\s+-R\b" -PAC
set ReplaceExeName=%lzmwName% -it "\blzmw\s+" -o "%lzmwName% " -PAC
::set ReplaceToCurDirMainCmd=%lzmwName% -ix "%%~dp0" -o "%CurDir2Slash%"
set ReplaceToCurDirMainCmd=%lzmwName% -ix "%%~dp0" -o %CurDir% -a

:: Need append file like : -p %pipeResult%  or -p %fileResult% 
set UnifyPipeTestExeName=%lzmwName% -it "(\|\s*)%lzmwName%\b" -o "${1}lzmw" -ROc
set UnifyFileTestExeName=%lzmwName% -it "(^|\|\s+|^\s*echo\s+)%lzmwName%\b" -o "$1lzmw" -ROc
set UnifyExtraExeName=%lzmwName% -it "%lzmwName% (-cA|-x)" -o "lzmw $1" -ROc
set RemoveDateTime=%lzmwName% -it "Used\s*\d+.*from\s*\d+.*$" -o "" -ROc
set UnifyDirectory=%lzmwName% -it "(^|\s+)[\\\\/\w\.:-]+(example-commands.bat|sample-file.txt)" -o "$1$2" -ROc 
set UnifyCurrentToDot=%lzmwName% -ix "%CurDir%" -o "." -ROc 

:: Directly test and output result on current command window
if not "%IsSavingToFile%" == "1" (
    if %SleepSeconds% GTR 0 (
        :: %FirstReplace% -q %StopCalling%| %ReplaceExeName% | %ReplaceToCurDirMainCmd% -PAC | %lzmwName% -t "^.+$" -o "$0 && sleep %SleepSeconds%" -XI
        for /F "tokens=*" %%a in ('%FirstReplace% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToCurDirMainCmd% -PAC ') do (
            echo %%a | %lzmwThis% -XI 2>nul
            :: a trick to sleep 
            ping 127.0.0.1 -n %SleepSeconds% -w 1000 > nul 2>nul
            echo.
        )
    )  else (
        echo %FirstReplace% -q %StopCalling% ^| %ReplaceToCurDirMainCmd% -IX
        %FirstReplace% -q %StopCalling% | %ReplaceExeName% | %ReplaceToCurDirMainCmd% -I -X
    )

    echo %SourceFile% | %lzmwName% -t .+  -o "findstr xml $0" -XI
    %lzmwName% -p %SourceFile% -b %StopCalling% -ix "%%~dp0" -o %CurDir% -a -XI
    exit /b 0
)


echo ######### Reading from file test begin ######################## | %lzmwThis% -PA -e .+
set fileResult=%CurDir%\file-test-result-on-windows.log
if exist %fileResult% del %fileResult%
for /F "tokens=*" %%a in ('%FirstReplace% -q %StopCalling% ^| %ReplaceExeName% ^| %ReplaceToCurDirMainCmd% -PIC ') do (
	echo %%a >> %fileResult%
	%%a >> %fileResult%
	echo.>> %fileResult%
)

echo.>>%fileResult%
echo echo %SourceFile% ^| %lzmwName% -t .+  -o "findstr xml $0" -XA >> %fileResult%
echo %SourceFile% | %lzmwName% -t .+  -o "findstr xml $0" -XA >>  %fileResult%

echo.>>%fileResult% & echo.>>%fileResult%
echo %lzmwName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %%~dp0 -a -PAC ^| %lzmwName% -it "\blzmw\b" -o "%lzmwName%" -a -XPAC >> %fileResult%
%lzmwName% -p %SourceFile% -b %StopCalling% --nt %StopCalling% -ix "%%~dp0" -o %CurDir% -a -PAC | %lzmwName% -it "\blzmw\b" -o "%lzmwName%" -a -XPAC >> %fileResult%

%UnifyFileTestExeName% -p %fileResult%
%RemoveDateTime% -p %fileResult%
%UnifyExtraExeName% -p %fileResult%
%UnifyDirectory% -p %fileResult%
%UnifyCurrentToDot% -p %fileResult%

call :Compare_Title_Files "File test comparison" %CurDir%\base-windows-file-test.log  %fileResult%

echo. & echo.

set /a allDifferences=0

echo ######### Reading from pipe test begin ######################## | %lzmwThis% -PA -e .+
set pipeResult=%CurDir%\pipe-test-result-on-windows.log
%FirstReplace% -q %StopCalling% | %ReplaceExeName% | %ReplaceToCurDirMainCmd% -PAC | %lzmwName% --nt "--wt|--sz"  -it "^(lz.*)\s+-p\s+(\S+)(\s*.*)" -o "type $2 | $1 $3" -XI > %pipeResult%
%UnifyPipeTestExeName% -p %pipeResult%
%RemoveDateTime% -p %pipeResult%
%UnifyExtraExeName% -p %pipeResult%
%UnifyDirectory% -p %pipeResult%
%UnifyCurrentToDot% -p %pipeResult%

call :Compare_Title_Files "Pipe test comparison" %CurDir%\base-windows-pipe-test.log %pipeResult%
set /a allDifferences+=%ERRORLEVEL%
exit /b %allDifferences%

:: Always return 0 so NOT use : diff %fileResult% %CurDir%\base-windows-file-test.log
:: Call nin.exe to get the differences count which ERRORLEVEL as following. By the way, this is an example of nin.exe .
:Compare_Title_Files
    :: nin %2 %3 >nul
    nin %2 %3 -O -I
    set /a diff1=%ERRORLEVEL%
    :: nin %3 %2 >nul
    nin %3 %2 -O -I
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
