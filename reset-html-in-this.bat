@echo off
SetLocal EnableExtensions EnableDelayedExpansion

where lzmw.exe 2>nul >nul || if not exist %~dp0\lzmw.exe powershell -Command "Invoke-WebRequest -Uri https://github.com/qualiu/lzmw/blob/master/tools/lzmw.exe?raw=true -OutFile %~dp0\lzmw.exe"
where lzmw.exe 2>nul >nul || set "PATH=%PATH%;%~dp0"

@where lzmw.exe 2>nul >nul || set "PATH=%~dp0\tools;%PATH%"
lzmw -rp %~dp0 --nd "\.git" -f "\.html$" -it "^<(BODY)>" -o "<$1 style=\"color: #C0C0C0; background-color: #000000; white-space: nowrap; \">" -R -c Set BODY Black background-color
lzmw -rp %~dp0 --nd "\.git" -it "div.* style=." -o "$0background-color: black; " -f "\.html$" --nx background-color -R -c Set Black background-color
lzmw -rp %~dp0 --nd "\.git" -it "font-size: \d+px" -o "font-size: 14px" -f "\.html$" -R -c Smaller font-size
lzmw -rp %~dp0 --nd "\.git" -t "(&nbsp;){30,}" -o "" -R -c Replace unnecessary nbsp since changed background-color to black.
::lzmw -rp %~dp0 --nd "\.git" -S -t "(>\s*)(&nbsp;)+(\s*<)" -o "$1$2" -R -c Replace unnecessary nbsp since changed background-color to black.
::lzmw -rp %~dp0 --nd "\.git" -f "\.html$" -l -PAC | lzmw -X -c Open all html files in default browser.
