:: ############################################################################
:: This tool is to find all process by the searching options of the process:
::  ParentProcessId ProcessId Name CommandLine
:: Filter self of lzmw.exe please append with:
::    --nx lzmw.exe or --nt lzmw\.exe
::
:: Output line format, separated by TAB: ParentProcessId ProcessId Name CommandLine
:: [1]: Default: :RowNumber: ParentProcessId ProcessId Name CommandLine
:: [2]: With -P: ParentProcessId ProcessId Name CommandLine
:: ############################################################################

@echo off
SetLocal EnableExtensions EnableDelayedExpansion

if "%~1" == "-h"     set ToShowUsage=1
if "%~1" == "--help" set ToShowUsage=1
if "%~1" == "/?"     set ToShowUsage=1

where lzmw.exe 2>nul >nul || if not exist %~dp0\lzmw.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %~dp0\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%~dp0;%PATH%"
for /f "tokens=*" %%a in ('where lzmw.exe 2^>nul') do set "lzmwPath=%%a"

if "%ToShowUsage%" == "1" (
    echo To see lzmw.exe matching options just run %lzmwPath% | lzmw -PA -ie "options|\S*lzmw\S*" -x lzmw
    echo Usage  : %~n0 -t/-x "process-match-options"  -e "to-enhance"  -H "header-lines", ... -P, etc. | lzmw -aPA -e "\s+-+\w+\s+|-[txP]" -x %~n0
    echo Example: %~n0 -H 9 -T 9 -P  | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0 -it C:\\Windows --nx lzmw.exe | lzmw -PA -e "\s+-\w\s+" | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0 -ix C:\Windows -t "java.*" -H 3 --nx C:\Windows\system32 --nt lzmw\.exe | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0  2030 3021 19980        ---- find processes by id | lzmw -PA -e "\s+(\d+|\bid\b)" -x %~n0
    exit /b 0
)

:: Test args for lzmw.exe
lzmw -z justTestArgs %* >nul 2>nul
if %ERRORLEVEL% LSS 0 (
    echo Error parameters for %~nx0: %* , test with: -z justTestArgs: | lzmw -aPA -t "Error.*for \S+(.*(test with.*(-z (justTestArgs))))"
    lzmw -z justTestArgs %*
    exit /b -1
)

::lzmw -z justTestArgs %* -P >nul 2>nul
::if !ERRORLEVEL! NEQ -1 set NoPathToCall=-P

set ColumnTitles=ParentProcessId,ProcessId,Name,CommandLine
set WMIC_ARGS=%ColumnTitles% /value
:: echo %* | lzmw -t "\s+-[PAC]+" >nul || echo %ColumnTitles%

set ColumnReplace=-S -t "\s*CommandLine=([^^\r\n]*)\s+Name=([^^\r\n]*)\s*ParentProcessId=(\d+)\s*ProcessId=(\d+)\s*" -o "$3\t$4\t$2\t$1\n"
set RemoveEmptyTail=-S -t "\s*$" -o "" -PAC

:: Check if just all PID numbers, then set ColumnReplace with PIDPattern
if not [%~1] == [] for /f "tokens=*" %%a in ('echo %* ^| lzmw -t "(^|\s+)(-[PACIMO]+|-[UDHT]\s*\d+|-c\s*.*)" -o "" -aPAC') do set TestPureNumbers=%%a
echo !TestPureNumbers! | lzmw -t "[^\d ]" >nul
:: if all are numbers and whitespaces.
if !ERRORLEVEL! EQU 0 (
    for /f "tokens=*" %%a in ('echo !TestPureNumbers! ^| lzmw -t "\s*(\d+)\s*" -o "$1|" -PAC ^| lzmw -t "\s*\|\s*$" -o "" -aPAC') do set "PIDPattern=%%a"
    for /f "tokens=*" %%a in ('echo %* ^| lzmw -t "(!PIDPattern!)\s*" -o " " -PAC') do set AllArgs=%%a
    
    set PidFilter=-b "^^CommandLine=" -Q "^^ProcessId=" -t "^^ProcessId=(!PIDPattern!)\s*" -aPAC
    call wmic process get %WMIC_ARGS% | lzmw !PidFilter! | lzmw !ColumnReplace! -PACc | lzmw %RemoveEmptyTail% | lzmw !AllArgs! %NoPathToCall%
) else (
    :: Avoid list all process and called from pskill, but has words:
    if not [%~1] == [] (
        :: Not use hasNonMatch to avoid get all processes and to be killed.
        lzmw --verbose -z justTestArgs %* 2>&1 | lzmw -q "End extra verbose" -it "hasMatch|hasEnhance" >nul
        if !ERRORLEVEL! EQU 0 (
            :: if no match or not-match and no enhance, but has words, add -x to prevent list all:
            echo %* | lzmw -t "(^|\s+)(-[PACIMO]+|-[UDHT]\s*\d+|-c\s*.*)" -o "" -aPAC | lzmw -t "\w+" -c Check if has words >nul
            if !ERRORLEVEL! GTR 0 set DefaultGrep=-x
        )
    )
    call wmic process get %WMIC_ARGS% | lzmw !ColumnReplace! -PACc | lzmw %RemoveEmptyTail%  | lzmw !DefaultGrep! %* %NoPathToCall%
)
