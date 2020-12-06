#!/bin/bash
# For example of lzmw.gcc48, just replace the windows test command and execute them by -X
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
cd "$(dirname $0)"

lzmw=$(bash $ThisDir/get-exe-path.sh lzmw 1)
nin=$(bash $ThisDir/get-exe-path.sh nin 1)
if [ ! -f "$lzmw" ] || [ ! -f "$nin" ]; then
    echo "Not found lzmw or nin as above." >&2
    exit -1
fi

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
        echo Tests failed in $0 as above. | $lzmw -aPA -t "($0)|\w+"
	exit -1
    fi
elif [ $diff -eq 0 ]; then
    rm tmp-linux-color-test.log
    echo Passed all tests in $0 | $lzmw -aPA -e "($0)|\w+"
    exit 0
fi
