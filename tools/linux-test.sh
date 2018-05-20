#!/bin/sh
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
    lzmwThis=$ThisDir/lzmw.cygwin
elif [ -n "$(uname -o | grep -ie Linux)" ]; then
    if [ -n "$(uname -m | grep 64)" ]; then
        lzmwThis=$ThisDir/lzmw.gcc48
    else
        lzmwThis=$ThisDir/lzmw-i386.gcc48
    fi
else
    echo "Unknow system type: $(uname -a)"
    exit -1
fi

if [ -f $lzmwThis ]; then
    chmod +x $lzmwThis
else
    lzmwThis=$(basename $lzmwThis)
fi


ninThis=$($lzmwThis -z "$lzmwThis" -t 'lzmw([^/]*?\.\w+)$' -o 'nin$1' -PAC)
if [ -f $ninThis ]; then
    chmod +x $ninThis
else
    ninThis=$(basename $ninThis)
fi

alias lzmw=$lzmwThis
alias nin=$ninThis

cd $ThisDir

alias lzmw=$lzmwThis
if [ "$md5Existed" = "$md5This" ] && [[ -x $lzmwExisted ]] && [ -z "$SleepSeconds" ] ; then
    # lzmw -p example-commands.bat -x %~dp0\\ -o "" -iq "^::.*Stop" --nt "^::" | lzmw -t "-o\s+.*-R" -x '"' -o "'" -a -X
    lzmw -p example-commands.bat -i -q "stop" -x "lzmw -c -p" -t "%~dp0\\\\?" -o './' -PAC --nt "-o\s+.*\s+-R" | lzmw -t '-o\s+\"(\$\d)\"' -o " -o '\1'" -aPAC -X
else
    lzmw -p example-commands.bat -i -q "stop" -x "lzmw -c -p" -t "%~dp0\\\\?" -o './' -PAC --nt "-o\s+.*\s+-R" | lzmw  -t '-o\s+\"(\$\d)\"' -o " -o '\1'" -aPAC | lzmw -t "^lzmw" -o "$lzmwThis" -PAC |
    while IFS= read -r cmdLine ; do
        echo $cmdLine | lzmw -aPA -e "(.+)"
        sh -c "$cmdLine"
        if(($SleepSeconds > 0)); then
            sleep $SleepSeconds
        fi
    done
fi
