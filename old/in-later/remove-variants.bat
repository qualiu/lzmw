@pushd %~dp0
@SetLocal EnableDelayedExpansion
@SET "PATH=%PATH%;%CD%\.."
@for /F "tokens=*" %%a in ('not-in-later-capture1.exe ^| lzmw -it "^copy\s+.*?\.exe\s+(\S+.*\.exe)$" -o "$1" -PAC ') do @if exist "%%a" del "%%a"
@for /F "tokens=*" %%a in ('not-in-later.exe ^| lzmw -it "^copy\s+.*?\.exe\s+(\S+.*\.exe)$" -o "$1" -PAC ') do @if exist "%%a" del "%%a"
@popd