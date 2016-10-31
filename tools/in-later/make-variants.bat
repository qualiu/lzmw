@pushd %~dp0
@SetLocal EnableDelayedExpansion
@SET "PATH=%PATH%;%CD%\.."
@set NotInLaterCaptureExe=not-in-later-capture1.exe
@set NotInLaterExe=not-in-later.exe
@for /F "tokens=*" %%a in ('%NotInLaterCaptureExe% ^| lzmw -it "^copy\s+.*?\.exe\s+(\S+.*\.exe)$" -o "$1" -PAC ') do @( if not exist %%a icacls %NotInLaterCaptureExe% /grant Everyone:RX & copy /y %NotInLaterCaptureExe% %%a )
@for /F "tokens=*" %%a in ('%NotInLaterExe% ^| lzmw -it "^copy\s+.*?\.exe\s+(\S+.*\.exe)$" -o "$1" -PAC ') do @( if not exist %%a icacls %NotInLaterExe% /grant Everyone:RX & copy /y %NotInLaterExe% %%a)
@popd