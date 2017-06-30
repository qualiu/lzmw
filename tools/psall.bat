@echo off
:: ############################################################################
:: This tool is to find all process by the searching options of the process :
::  commad line, name, process id, parent process id
:: Filter self of lzmw.exe please append with:
::    --nx lzmw.exe or --nt lzmw\.exe
:: ####### to "echo off" for debuging this script : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+off\b" -o "$1 on" -R && lzmw -p psall.bat -it "^\s*rem\s+(echo\s+.*)$" -o "$1" -R
:: ####### to restore "echo off" , run following : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+on\b" -o "$1 off" -R && lzmw -p psall.bat -it "^\s*(echo\s+.*)$" -o "rem $1" -L 30 -R
:: ############################################################################

SetLocal EnableExtensions EnableDelayedExpansion
:: set FilterSelf=where (name != "lzmw.exe")

if "%~1" == "-h"     set ToShowUsage=1
if "%~1" == "--help" set ToShowUsage=1
if "%~1" == "/?"     set ToShowUsage=1

set ThisDir=%~dp0
if %ThisDir:~-1%==\ set ThisDir=%ThisDir:~0,-1%

where lzmw.exe 2>nul >nul || if not exist %ThisDir%\lzmw.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %ThisDir%\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%ThisDir%;%PATH%"
for /f "tokens=*" %%a in ('where lzmw.exe 2^>nul') do set "lzmwPath=%%a"

if "%ToShowUsage%" == "1" (
    :: lzmw --help
    echo To see lzmw.exe matching options just run %lzmwPath% | lzmw -PA -ie "options|\S*lzmw\S*" -x lzmw
    echo Usage    : %~n0 -t/-x "process-match-options"  -e "to-enhance"  -H "header-lines", ... -P, etc. | lzmw -aPA -e "\s+-+\w+\s+|-[txP]" -x %~n0
    echo Example-1: %~n0 -H 9 -T 9 -P  | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example-2: %~n0 -it C:\\Windows --nx lzmw.exe | lzmw -PA -e "\s+-\w\s+" | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    echo Example-3: %~n0 -ix C:\Windows -t "java.*" -H 3 --nx C:\Windows\system32 --nt lzmw\.exe | lzmw -aPA -e "\s+-+\w+\s+" -x %~n0
    exit /b 0
)

:: Test args for lzmw.exe
lzmw -z test-string %* >nul 2>nul
if %ERRORLEVEL% LSS 0 (
    echo Error parameters for %~nx0: %* , test with: -z test-string: | lzmw -aPA -t "Error.*for \S+(.*(test with.*(-z (test-string))))"
    lzmw -z test-string %*
    exit /b -1
)

set enhanceOption=
set otherOption=
set textCmd=
set textOption=
set plainTextCmd=
set plainTextOption=
set ignoreCaseOption=

:CheckArgs
if "%~1" == ""  goto CheckArgsCompleted
if "%~1" == "-i" (
    set ignoreCaseOption=%1
    shift & goto CheckArgs
)
if "%~1" == "-t" (
    set textCmd=%1
    set textOption=%2
    shift & shift & goto CheckArgs
)
if "%~1" == "-it" (
    set ignoreCaseOption=-i
    set textCmd=-t
    set textOption=%2
    shift & shift & goto CheckArgs
)
if "%~1" == "-e" (
    set enhanceOption=%2
    shift & shift & goto CheckArgs
)

if "%~1" == "-ie" (
    set ignoreCaseOption=-i
    set enhanceOption=-e
    shift & shift & goto CheckArgs
)

if "%~1" == "-x" (
    set plainTextCmd=%1
    set plainTextOption=%2
    shift & shift & goto CheckArgs
)

if "%~1" == "-ix" (
    set ignoreCaseOption=-i
    set plainTextCmd=-x
    set plainTextOption=%2
    shift & shift & goto CheckArgs
)

set otherOption=%otherOption% %1
shift
goto CheckArgs
:CheckArgsCompleted
rem echo textOption = %textOption%
rem echo otherOption = %otherOption%
if not "%plainTextCmd%" == "" set "plainTextCmdEnhance=-x"

set finalEnhance=
if [%textOption%] == [] (
   if not [%enhanceOption%] == [] (
        set finalEnhance=-e %enhanceOption%
   )
) else (
    if not [%enhanceOption%] == [] (
        set finalEnhance=-e "%textOption:"=%|%enhanceOption:"=%"
    ) else (
        set finalEnhance=-e %textOption%
    )
)

rem echo enhanceOption = %enhanceOption%
rem echo finalEnhance = %finalEnhance%
rem echo plainTextOption = %plainTextOption%
set WMIC_ARGS=ParentProcessId,ProcessId,Name,CommandLine
::set EachMultiLineToOneLine=-t "\s+" -o " " --nt "^(wmic|lzmw)" -PAC
set EachMultiLineToOneLine=-t "\s+" -o " " --nt "^(wmic)" -PAC
set ColumnReplace=-t "^(.+?)\s+(\S+)\s+(\S+)\s+(\S+)\s*$" -o "$3 $4 $2 $1"
set LastArgs=%ignoreCaseOption% -t "^(?:\d+|ParentProcessId)\s+(\d+|ProcessId)\s+(\S+|Name)" %finalEnhance% %otherOption%

if [%textCmd%%plainTextCmd%] == [] (
    call wmic process get %WMIC_ARGS% | lzmw %EachMultiLineToOneLine% | lzmw %ColumnReplace% -PAC | lzmw %LastArgs%
) else (
    call wmic process get %WMIC_ARGS% | lzmw %EachMultiLineToOneLine% | lzmw -PAC %ignoreCaseOption% %textCmd% %textOption% %plainTextCmd% %plainTextOption% | lzmw %ColumnReplace% -PAC | lzmw %LastArgs% %plainTextCmdEnhance% %plainTextOption%
)
