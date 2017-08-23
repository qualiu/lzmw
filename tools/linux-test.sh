#!/bin/sh
if [ -z "$1" ]; then
    echo "Usage:   $0  Sleep-Seconds"
    echo "Example: $0  0"
    echo "Example: $0  3"
    exit -1
fi

# For example of lzmw.gcc48, just replace the windows test command and execute them by -X
SleepSeconds=$1
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
SYS_TYPE=$(uname | sed 's/_.*//g' | awk '{print tolower($0)}')

lzmwExisted=$(whereis lzmw 2>/dev/null | lzmw -t "^.*?:\s*(\S+?lzmw\S*).*" -o '$1' -PAC 2>/dev/null | tr -d '\r')
if [ -f "$lzmwExisted" ]; then
    md5Existed=$(md5sum $lzmwExisted | lzmw -t "^(\w+\S+).*" -o '$1' -PAC | tr -d '\r')
    if [ ! -x $lzmwExisted ]; then
        chmod +x $lzmwExisted
    fi
fi

if [ "$SYS_TYPE"x = "linux"x ]; then
    lzmwThis=$ThisDir/lzmw.gcc48
elif [ "$SYS_TYPE"x = "cygwin"x ]; then
    lzmwThis=$ThisDir/lzmw.cygwin
else
    echo "Unknow system type: $SYS_TYPE"
    exit -1
fi

chmod +x $lzmwThis

md5This=$(md5sum $lzmwThis | lzmw -t "^(\w+\S+).*" -o '$1' -PAC 2>/dev/null | tr -d '\r')

cd $ThisDir

alias lzmw=$lzmwThis
if [ "$md5Existed" = "$md5This" ] && [[ -x $lzmwExisted ]] && [ -z "$SleepSeconds" ] ; then
    lzmw -p example-commands.bat -x %~dp0\\ -o "" -iq "^::.*Stop" --nt "^::" | lzmw -t "-o\s+.*-R" -x '"' -o "'" -a -X
else
    # echo "$lzmwThis -p example-commands.bat -x %~dp0\\ -o "" -iq "^::\s*Stop" --nt "^::" -PAC | $lzmwThis -t "^\s*lzmw" -o \"$lzmwThis\" -aPAC"
    $lzmwThis -p example-commands.bat -x %~dp0\\ -o "" -iq "^::.*Stop" --nt "^::" -PAC | $lzmwThis -t "^\s*lzmw" -o "$lzmwThis" -aPAC | $lzmwThis -t '\s+-o\s+\"(\$.*?)\"' -o " -o '\$1'" -aPAC | $lzmwThis -t '\s+-o\s+\"(lzmw.*)\"' -o " -o '\$1'" -aPAC |
    while IFS= read -r cmdLine ; do
        sh -c "$cmdLine"
        if(($SleepSeconds > 0)); then
            sleep $SleepSeconds
        fi
    done
fi

sh $ThisDir/../fix-file-style.sh sample-file.txt
unix2dos sample-file.txt
