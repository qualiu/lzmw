:: ############################################################################
:: This tool is to find all process by the searching options of the process : 
:: commad line, name, process id, parent process id
:: ####### to "echo on" for debuging this script : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+off\b" -o "$1 on" -R && lzmw -p psall.bat -it "^\s*::\s*(echo\s+.*)$" -o "$1" -R
:: ####### to restore "echo off" , run following : ###################
:: lzmw -p psall.bat -it "^\s*(@?echo)\s+on\b" -o "$1 off" -R && lzmw -p psall.bat -it "^\s*(echo\s+.*)$" -o "::$1" -L 30 -R
:: ############################################################################

@echo off
setlocal enabledelayedexpansion
set lzmw=lzmw

if "%1" == "-h"     set ToShowUsage=1
if "%1" == "--help" set ToShowUsage=1

if "%ToShowUsage%" == "1" (
    %lzmw%
    echo %lzmw% matching options as above.
    echo try to use : -t "process-info-text" , -e "to-enhance" , -H "header-lines", ..., -P, etc.
    echo Example-1: %0 -H 9 -T 9
    echo Example-2: %0 -it cmd.exe
    echo Example-3: %0 -i -x C:\Windows -H 3
    exit /b 0
)

set textOption=
set enhanceOption=
set otherOption=
set textCmd=

:start
if "%1" == ""  goto done

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
set finalEnhance=
if x%textOption% == x"" (
   if not x%enhanceOption% == x"" (
        set finalEnhance=-e %enhanceOption%
   )
) else (
    if not x%enhanceOption% == x"" (
        set finalEnhance=-e "%textOption:"=%|%enhanceOption:"=%"
    ) else (
        set finalEnhance=-e %textOption%
    )
)

::echo all options = %*
::echo textOption = %textOption%
::echo enhanceOption = %enhanceOption%
::echo otherOption = %otherOption%
::echo finalEnhance = %finalEnhance%

set WMIC_ARGS=ParentProcessId,ProcessId,Name,CommandLine
set EachMultiLineToOneLine=-t "\s+" -o " " --nt "^(wmic|lzmw)" -PAC
set ColumnReplace=-t "^(.+?)\s+(\S+)\s+(\S+)\s+(\S+)\s*$" -o "$3 $4 $2 $1"
set LastArgs=-it "^(?:\d+|ParentProcessId)\s+(\d+|ProcessId)\s+(\S+|Name)" %finalEnhance% %otherOption%

if x%textOption% == x"" (
    wmic process get %WMIC_ARGS% | %lzmw% %EachMultiLineToOneLine% | %lzmw% %ColumnReplace% -PAC | %lzmw% %LastArgs%
) else (
    ::echo ParentProcessId ProcessId Name CommandLine | %lzmw% -it "^\w+\s+(\w+)\s+(\w+)\s+(\w+)" -PA
    wmic process get %WMIC_ARGS% | %lzmw% %EachMultiLineToOneLine% | %lzmw% -PAC %textCmd% %textOption% | %lzmw% %ColumnReplace% -PAC | %lzmw% %LastArgs%
)

goto :End

:NotSupportNormalGrep
echo Not support or currently cannot use %~1 %~2 , you can append a pipe with : %lzmw% %~1 %~2 | %lzmw% -ie "(?<=cannot use).*(?=you can)" -PA

:End
