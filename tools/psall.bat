@echo off
:: ############################################################################
:: This tool is to find all process by the searching options of the process : 
:: commad line, name, process id, parent process id
:: ####### to "echo on" for debuging this script : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+off\b" -o "$1 on" -R && lzmw -p psall.bat -it "^\s*rem\s+(echo\s+.*)$" -o "$1" -R
:: ####### to restore "echo off" , run following : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+on\b" -o "$1 off" -R && lzmw -p psall.bat -it "^\s*(echo\s+.*)$" -o "rem $1" -L 30 -R
:: ############################################################################

SetLocal EnableExtensions EnableDelayedExpansion
set lzmw=lzmw
set FilterSelf=where (name != "lzmw.exe")

if "%~1" == "-h"     set ToShowUsage=1
if "%~1" == "--help" set ToShowUsage=1
if "%~1" == "/?"       set ToShowUsage=1

if "%ToShowUsage%" == "1" (
    :: %lzmw%
    echo To see %lzmw% matching options just run %lzmw% | lzmw -PA -ie "options|lzmw" -x %lzmw%
    echo Usage    : %0 -t "process-info-text"  -e "to-enhance"  -H "header-lines", ... -P, etc. | lzmw -PA -e "\s+-+\w+\s+" -x %0
    echo Example-1: %0 -H 9 -T 9    | lzmw -PA -e "\s+-+\w+\s+" -x %0
    echo Example-2: %0 -it cmd.exe --nx lzmw.exe | lzmw -PA -e "\s+-\w\s+" | lzmw -PA -e "\s+-+\w+\s+" -x %0
    echo Example-3: %0 -t C:.Windows -H 3 --nx C:\Windows\system32 --nt lzmw.exe | lzmw -PA -e "\s+-+\w+\s+" -x %0
    exit /b 5
)

set textOption=
set enhanceOption=
set otherOption=
set textCmd=

:start
if "%~1" == ""  goto done

if "%1" == "-t" (
    set textOption=%2
    set textCmd=%1
    shift
    shift
    goto start
) 
if "%1" == "-it" (
    set textOption=%2
    set textCmd=%1
    shift
    shift
    goto start
) 
if "%1" == "-e" (
    set enhanceOption=%2
    shift
    shift
    goto start
) 
if "%1" == "-ie" (
    set enhanceOption=%2
    shift
    shift
    goto start
)

if "%1" == "-x"  call :NotSupportNormalGrep %1 %2 & exit /b 1
if "%1" == "-ix" call :NotSupportNormalGrep %1 %2 & exit /b 1

set otherOption=%otherOption% %1 

shift

goto start

:done
rem echo textOption = %textOption%
rem echo otherOption = %otherOption%

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

set WMIC_ARGS=ParentProcessId,ProcessId,Name,CommandLine
::set EachMultiLineToOneLine=-t "\s+" -o " " --nt "^(wmic|lzmw)" -PAC
set EachMultiLineToOneLine=-t "\s+" -o " " --nt "^(wmic)" -PAC
set ColumnReplace=-t "^(.+?)\s+(\S+)\s+(\S+)\s+(\S+)\s*$" -o "$3 $4 $2 $1"
set LastArgs=-it "^(?:\d+|ParentProcessId)\s+(\d+|ProcessId)\s+(\S+|Name)" %finalEnhance% %otherOption%

if [%textOption%] == [] (
    wmic process get %WMIC_ARGS% | %lzmw% %EachMultiLineToOneLine% | %lzmw% %ColumnReplace% -PAC | %lzmw% %LastArgs%
) else (
    rem echo ParentProcessId ProcessId Name CommandLine | %lzmw% -it "^\w+\s+(\w+)\s+(\w+)\s+(\w+)" -PA
    wmic process get %WMIC_ARGS% | %lzmw% %EachMultiLineToOneLine% | %lzmw% -PAC %textCmd% %textOption% | %lzmw% %ColumnReplace% -PAC | %lzmw% %LastArgs%
)

goto :End

:NotSupportNormalGrep
echo Not support or currently cannot use %~1 %~2 , you can append a pipe with : %lzmw% %~1 %~2 | %lzmw% -e "(?<=cannot use).*(?=you can)" -PA

:End

