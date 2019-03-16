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

if [ -n "$(uname -o | grep -ie Cygwin)" ]; then
    lzmw=$ThisDir/lzmw.cygwin
elif [ -n "$(uname -o | grep -ie Linux)" ]; then
    if [ -n "$(uname -m | grep 64)" ]; then
        lzmw=$ThisDir/lzmw.gcc48
    else
        lzmw=$ThisDir/lzmw-i386.gcc48
    fi
else
    echo "Unknown system type: $(uname -a)"
    exit -1
fi

if [ -f "$lzmw" ]; then
    chmod +x $lzmw
elif [ -n "$(whereis lzmw 2>/dev/null)" ]; then
    lzmw=$(whereis lzmw | sed -r 's/.*?:\s*(\S+).*/\1/')
elif [ -n "$(alias lzmw)" ]; then
    lzmw=$(alias lzmw | sed -r 's/.*?=\s*(\S+).*/\1/')
else
    lzmw=$ThisDir/$(basename $lzmw)
    if [ !-f "$lzmw" ]; then
        echo "Not exist lzmw nor $lzmw"
        exit /b -1
    fi
    chmod +x $lzmw
fi

nin=$(echo $lzmw | sed -r 's/lzmw([^/]*)$/nin\1/')
if [ -f "$nin" ]; then
    chmod +x $nin
else
    nin=$ThisDir/$(basename $nin)
    if [ !-f "$nin" ]; then
        echo "Not exist nin nor $nin"
        exit /b -1
    fi
fi

alias lzmw=$lzmw
alias nin=$nin

cd $ThisDir

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
