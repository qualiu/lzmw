#!/bin/bash
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
cd "$(dirname $0)"

lzmw=$(bash $ThisDir/get-exe-path.sh lzmw 1)
if [ ! -f "$lzmw" ]; then
    echo "Not found lzmw as above." >&2 ;
    exit -1
fi

cd $(dirname $0)
$lzmw -c -l --wt --sz -H 5 -T 5 -p /home/../usr/bin/ -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p /home/../usr/bin/ -f "bash|grep" -W
$lzmw -c -l --wt --sz -H 5 -T 5 -p . -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p . -W -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p ./ -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p ./ -W -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p ~/ -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p ~/ -W -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p /usr/bin/ -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p /usr/bin/ -f "bash|grep" -W
$lzmw -c -l --wt --sz -H 5 -T 5 -p /home/../usr/bin/ -f "bash|grep"
$lzmw -c -l --wt --sz -H 5 -T 5 -p /home/../usr/bin/ -f "bash|grep" -W
$lzmw -c -l --wt --sz -H 3 -p /bin -f "bash|grep"
$lzmw -c -l --wt --sz -H 3 -p /bin -W -f "bash|grep"
$lzmw -c -l --wt --sz -H 3 -p /usr/bin -f "bash|grep"
$lzmw -c -l --wt --sz -H 3 -p /usr/bin -W -f "bash|grep"

if [ -d /cygdrive/c/ ]; then
    $lzmw -c -l --wt --sz -H 3 -p /cygdrive/c/
    $lzmw -c -l --wt --sz -H 3 -p /cygdrive/c/ -W
fi

exit 0
