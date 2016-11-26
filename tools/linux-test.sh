# For example of lzmw.gcc48, just replace the windows test command and execute them by -X

./lzmw.gcc48 -p example-commands.bat -x %~dp0\\ -o "" -q "^::\s*Stop" --nt "^::" -X
