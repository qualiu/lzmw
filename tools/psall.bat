:: ############################################################################
:: This tool is to find all process by the searching options of the process:
::  ParentProcessId ProcessId Name CommandLine
:: Filter self of lzmw.exe please append with:
::    --nx lzmw.exe or --nt lzmw\.exe
::
:: Output line format, separated by TAB: ParentProcessId ProcessId Name CommandLine
:: [1]: Default: :RowNumber: ParentProcessId ProcessId Name CommandLine
:: [2]: With -P: ParentProcessId ProcessId Name CommandLine
::
:: Latest version in: https://github.com/qualiu/lzmwTools/
:: ############################################################################

@echo off
SetLocal EnableExtensions EnableDelayedExpansion

where lzmw.exe 2>nul >nul || if not exist %~dp0\lzmw.exe powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %~dp0\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%~dp0;%PATH%;"

lzmw -z "LostArg%~1" -t "^LostArg(|-h|--help|/\?)$" > nul || (
    echo To see lzmw.exe matching options just run: lzmw --help | lzmw -PA -ie "options|\S*lzmw\S*" -x lzmw
    echo Usage  : %~n0 -t/-x "process-match-options"  -e "to-enhance"  -H "header-lines", ... -P, etc. | lzmw -aPA -e "\s+-+\w+\s+|-[txP]" -x %~n0
    echo Example: %~n0 -H 9 -T 9 -P  | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0 -it C:\\Windows --nx lzmw.exe | lzmw -PA -e "\s+-\w\s+" | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0 -ix C:\Windows -t "java.*" -H 3 --nx C:\Windows\system32 --nt lzmw\.exe | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example: %~n0  2030 3021 19980        ---- find processes by id | lzmw -PA -e "\s+(\d+|\bid\b)" -x %~n0
    exit /b 0
)

:: wmic process get ParentProcessId,ProcessId,Name,CommandLine /FORMAT:csv | lzmw -it "^(Node|%COMPUTERNAME%)," -o "" -aPAC | lzmw -t "(.+)?,(.*?),(\d+),(\d+)$" -o "\3 \4 \2 \1" -aPAC
set Command1=wmic process get ParentProcessId,ProcessId,Name,CommandLine /FORMAT:csv
set Command2=lzmw -it "^(Node|%COMPUTERNAME%)," -o "" -aPAC
set Command3=lzmw -t "(CommandLine|.*)?,(Name|.*?),(ParentProcessId|\d+),(ProcessId|\d+)$" -o "\3\t\4\t\2\t\1" -aPAC

:: Test args for lzmw.exe
lzmw -z justTestArgs %* >nul 2>nul
if %ERRORLEVEL% LSS 0 (
    echo Error parameters for %~nx0: %* , test with: -z justTestArgs: | lzmw -aPA -t "Error.*for \S+(.*(test with.*(-z (justTestArgs))))"
    lzmw -z justTestArgs %*
    exit /b -1
)

for /f "tokens=*" %%a in ('echo %* ^| lzmw -t "^(\d+[\s\d]*)\s*(.*)" -o "\1" -PAC ^| lzmw -t "\s+(\d+)" -o "|\1" -aPAC ^| lzmw -t "\s*$" -o "" -aPAC') do (
    set "PidPattern=%%a"
)

if "!PidPattern!" == "" (
    %Command1% | %Command2% | %Command3% | lzmw %*
    exit /b !ERRORLEVEL!
)

for /f "tokens=*" %%a in ('echo %* ^| lzmw -t "^(\d+[\s\d]*)\s*(.*)" -o "\2" -PAC') do set OtherArgs=%%a
lzmw -z %* -t . >nul 2>nul
if !ERRORLEVEL! NEQ -1 (
    set ColorPid=-t "^(!PidPattern!)|(?=\d+\t)(!PidPattern!)"
) else (
    lzmw -z %* -e .  >nul 2>nul
    if !ERRORLEVEL! NEQ -1 set ColorPid=-e "^(!PidPattern!)|^\d+\t(!PidPattern!)"
)

%Command1% | %Command2% | lzmw -t ",(!PidPattern!)(,|\s*$)" -PICc | %Command3% | lzmw !OtherArgs! !ColorPid!
