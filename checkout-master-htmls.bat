git checkout master & git checkout gh-pages checkout-master-htmls.bat
@where lzmw.exe 2>nul >nul || set "PATH=%~dp0\tools;%PATH%"
lzmw -rp . --nd "\.git" -f "\.html$" -l -PAC > master-htmls
git checkout gh-pages
for /f "tokens=*" %%a in (master-htmls) do git checkout master %%a && git add %%a
del master-htmls
lzmw -rp . --nd "\.git" -f "\.html$" -l -PAC | lzmw -x \ -o / -aPAC | lzmw -t .+ -o https://qualiu.github.io/lzmw/$0 -aPIC
