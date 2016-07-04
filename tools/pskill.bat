:: kill process by id
@SETLOCAL
::@echo %* | findstr "[A-Za-z]">nul && call :KillByRegex %* || call :KillByPID %*
@SET "NotNumber=" & for /f "delims=0123456789 " %%a in ("%*") do @set NotNumber=%%a
@if defined NotNumber (
    @echo Kill process by regex : %*
    for /F "tokens=2" %%p in ('@psall -it %* -PAC') do @call set "xpids=/pid %%p %%xpids%%"
    if not "%xpids%" == "" taskkill /f %xpids%
) else (
    @echo Kill process by pid list: %*
    for %%a in (%*) do @call set "xpids=/pid %%a %%xpids%%"
    if not "%xpids%" == "" taskkill /f %xpids%
)

@EndLocal
