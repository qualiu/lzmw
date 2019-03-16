#!/bin/bash
# For example of lzmw.gcc48, just replace the windows test command and execute them by -X
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
cd "$(dirname $0)"
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
    nin=$(basename $nin)
    if [ !-f "$nin" ]; then
        echo "Not exist nin nor $nin"
        exit /b -1
    fi
fi

alias lzmw=$lzmw
alias nin=$nin

$lzmw -p ./example-commands.bat -i -q "stop" -t "lzmw -c -p %~dp0\\\\?" -o "$lzmw -c -p ./" --nt "-o\s+.*\s+-R" -PAC | $lzmw -t "\s+-P(\w*)" -o '$1' -aPAC | $lzmw -t "\s+-(\w*)A(\w*)" -o ' -$1$2' -aPAC | $lzmw -t "($lzmw -c)" -o '$1 -PA' -aXIM > tmp-linux-color-test.log

$lzmw -p color-group-test.cmd -t "^lzmw" -o $lzmw --nx dp0 -XIM >> tmp-linux-color-test.log

$lzmw -p tmp-linux-color-test.log -t "^.*?(Run-Command\S*).*? = (\S*lzmw.*)" -o '$1 = $2' -R -c

$lzmw -p tmp-linux-color-test.log -x $lzmw -o lzmw -R -c

if [ -n "$(echo $lzmw | grep cygwin)" ]; then
    where bcompare >/dev/null 2>/dev/null
    export noBCompare=$?
fi

$nin base-linux-color-test.log tmp-linux-color-test.log
diff=$?
if [ $? -ne 0 ] && [ "$noBCompare" = "0" ]; then
    bcompare base-linux-color-test.log tmp-linux-color-test.log /fv="Text Compare" &
fi

$nin base-linux-color-test.log tmp-linux-color-test.log -S
diff=$(($diff + $?))
if [ $diff -ne 0 ]; then
    if [ "$noBCompare" = "0" ]; then
        bcompare base-linux-color-test.log tmp-linux-color-test.log /fv="Text Compare" &
    else
        echo Tests failed in $0 | $lzmw -aPA -t "($0)|\w+"
    fi
elif [ $diff -eq 0 ]; then
    rm tmp-linux-color-test.log
    echo Passed all tests in $0 | $lzmw -aPA -e "($0)|\w+"
fi
