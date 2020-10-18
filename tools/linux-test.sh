#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage:   $0  Sleep-Seconds"
    echo "Example: $0  0"
    echo "Example: $0  3"
    echo "This file leverages test cases in windows-test.bat to test."
    exit -1
fi

# For example of lzmw.gcc48, just replace the windows test command and execute them by -X
SleepSeconds=$1
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
cd $ThisDir

lzmw=$(bash $ThisDir/get-exe-path.sh lzmw 1)
nin=$(bash $ThisDir/get-exe-path.sh nin 1)
if [ ! -f "$lzmw" ] || [ ! -f "$nin" ]; then
    echo "Not found lzmw or nin as above." >&2
    exit -1
fi

if [ "$md5Existed" = "$md5This" ] && [[ -x $lzmwExisted ]] && [ -z "$SleepSeconds" ] ; then
    $lzmw -p example-commands.bat -i -q "stop" -x "lzmw -c -p" -t "%~dp0\\\\?" -o './' -PAC --nt "-o\s+.*\s+-R" | $lzmw -t '-o\s+\"(\$\d)\"' -o " -o '\1'" -aPAC -X
else
    $lzmw -p example-commands.bat -i -q "stop" -x "lzmw -c -p" -t "%~dp0\\\\?" -o './' -PAC --nt "-o\s+.*\s+-R" | $lzmw  -t '-o\s+\"(\$\d)\"' -o " -o '\1'" -aPAC | $lzmw -t "^lzmw" -o "$lzmw" -PAC |
    while IFS= read -r cmdLine ; do
        echo $cmdLine | $lzmw -aPA -e "(.+)"
        sh -c "$cmdLine"
        if(($SleepSeconds > 0)); then
            sleep $SleepSeconds
        fi
    done
fi
