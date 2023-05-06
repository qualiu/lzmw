#!/bin/bash

if [ -z "$3" ] && [ -z "$2" ]; then
    echo "Usage   : $0  Test-file                        Plain-Finding-String   Regex-Pattern             [Optional : Test-times]"
    echo "Example : $0  /cygdrive/d/tmp/large-test.log   Exception              \"[0-9]*Exception[0-9]*\"   3"
    exit -1
fi

if [ ! -e  $1 ];  then
    echo NOT EXIST test file : $1 | lzmw -PA -t .*
    exit -1
fi

TestFilePath=$1
TestFileDir=$(dirname $1)
TestFileName=$(basename $1)
PlainFinding=$2
RegexFinding=$3

FindStrPath="$(which findstr 2>/dev/null | grep -i -E '/findstr')"

TestTimes=$4
if [ -z "$TestTimes" ]; then
    TestTimes=1
fi

## alias lzmw=lzmw.cygwin/lzmw.gcc* or make link to it : ln -s lzmw.gcc*/lzmw.cygwin /usr/bin/lzmw
lzmw=$(which lzmw)
if [ -z "$lzmw" ]; then
    ThisDir="$( cd "$( dirname "$0" )" && pwd )"
    lzmw=$(bash $ThisDir/../tools/get-exe-path.sh lzmw 1)
fi

function GetCPUCoresInfo() {
    if [ -n "$(uname -s | grep -i '^Darwin')" ]; then
        chipInfo=$(system_profiler SPHardwareDataType | $lzmw -it "^\s*Chip\s*:\s*(.+)" -o '\1' -PAC)
        export CPUCoresInfo="$chipInfo $(sysctl -n hw.ncpu) Cores"
        return
    fi

    if [ -z "$FindStrPath" ]; then
        export CPUCoresInfo="$(nproc) Cores"
        return
    fi

    NumberOfCores=$(wmic CPU GET NumberOfCores /VALUE | tr -d '\r' | awk '{if (match($0, /NumberOfCores=([0-9]+)/, arr)) print arr[1]; }')
    #$lzmw -z "$NumberOfCores" -c
    cpu="$(wmic CPU GET Name /VALUE /VALUE | tr -d '\r' | awk '{if (match($0, /Name\s*=\s*(.+)/, arr)) printf("%s", arr[1]); }')"
    #$lzmw -z "$cpu" -t ".+" -c
    export CPUCoresInfo="$NumberOfCores Cores $cpu"
    #echo "CPUCoresInfo = $CPUCoresInfo"
}

function GetOSVersionBit() {
    OSName=""
    if [ -f /etc/os-release ]; then
        OSName="$(cat /etc/os-release | $lzmw -it 'PRETTY_NAME=\"?([^\"]+).*' -o "\1" -PAC) "
    fi

    export OSVersionBit="$OSName$(uname -smr)"
: '
    OSArchitecture=""
    SystemCaption=""
    for line in $(wmic OS GET Caption,OSArchitecture /Value | tr -d '\r' ); do
        pos=$(expr index "$line" "=")
        if(($pos < 1)); then
            continue
        fi
        name=${line:0:$(($pos-1))}
        value=${line:$pos}
        if [ "$name" = "Caption" ]; then
            SystemCaption=$value;
        elif [ "$name" = "OSArchitecture" ] ; then
            OSArchitecture=$value
        fi
    done
    export OSVersionBit="$SystemCaption $OSArchitecture"
    echo "OSVersionBit=$SystemCaption $OSArchitecture"
 '
}

function GetMemoryInfo() {
    if [ -n "$(uname -s | grep -i '^Darwin')" ]; then
        export MemoryInfo="$(($(sysctl -n hw.memsize) / 1024/1024/1024)) GM RAM"
        return
    fi

    if [ -z "$FindStrPath" ]; then
        memoryBytes=$(vmstat -s -S B | $lzmw -t "^\s*(\d+).*total memory" -o "\1" -PAC)
        export MemoryInfo="$(($memoryBytes / 1024/1024/1024)) GM RAM"
        return
    fi

    TotalMemory=0
    MemoryChannels=0
    ##for line in $(wmic MEMORYCHIP where \(Caption like "Physical Memory" \) GET Capacity,Speed,DeviceLocator /Value | findstr /I /R "[0-9a-z]" ); do
    for line in $(wmic MEMORYCHIP GET Capacity,Speed,DeviceLocator /Value | tr -d '\r' | grep -ie "[0-9a-z]" ); do
        pos=$(expr index "$line" "=")
        name=${line:0:$(($pos-1))}
        value=${line:$pos}
        if [ "$name" = "Capacity" ]; then
            numberMB=$(($value/1024/1024))
            let TotalMemory+=$numberMB
        elif [ "$name" = "Speed" ]; then
            MemorySpeed=$value
        elif [ "$name" = "DeviceLocator" ]; then
            let MemoryChannels+=1
        fi
    done
    declare -a Units=(MB GB TB)
    unitIndex=0
    MemoryNumber=$TotalMemory
    for k in {0..2}; do
        if [ $MemoryNumber -ge 1024 ]; then
            let unitIndex=$k+1
            let MemoryNumber/=1024
            MemoryInfo="$MemoryNumber ${Units[$unitIndex]}"
        fi
    done
    #echo "unitIndex=$unitIndex, FullMemoryInfo=$MemoryInfo/$MemoryChannels Channels/$MemorySpeed Speed"
    export MemoryInfo="$MemoryNumber ${Units[$unitIndex]} RAM"
}

## Paramters : Title, File, pattern , findstr-options, grep-options, lzmw-options
function Compare_By_File_Pattern_3_Options() {
    #echo "args[$#] = $*"
    echo "$(date +'%F %T') : $1: $3 : $SystemInformation" | $lzmw -PA -e "(.+)" -it "(Plain|Regex|(?<=by : )\S+)|Test|small|(ignore\s*case)|(Windows|Cygwin\w*|Linux|Centos|Fedora|UBuntu)\w*\s*(\d+\w*)?"
    echo "Test file info : $TestFileInfo : $1 by findstr / grep / lzmw ; To find = $3" | $lzmw -t "(\d+\.\d+)" -e "(\d+)|\w+" -PA
    for ((k=1; k <= $TestTimes; k++)); do
        #echo "Test[$k]-$TestTimes : $1 : $3 "
        if [ -n "$FindStrPath" ]; then
            findstr $4 "$3"    $2      | $lzmw -l -c Read  findstr : $3
        fi
        grep    $5 "$3"    $2      | $lzmw -l -c Read  grep : $3
        $lzmw    $6 "$3" -p $2 -PAC | $lzmw -l -c Read  lzmw  : $3
    done
    echo
}

GetOSVersionBit
GetMemoryInfo
GetCPUCoresInfo

export SystemInformation="$OSVersionBit + $MemoryInfo + $CPUCoresInfo"
export TestFileInfo=$($lzmw -l -t . -p $TestFilePath -H 0 -c Get size and rows -PC | $lzmw -it "^.*read (\d+ lines \d+\S+ \w+).*from (\d+\S+.+?)Checked.*" -o '$1' -PAC)

cd $TestFileDir
if [ -n "$PlainFinding" ]; then Compare_By_File_Pattern_3_Options "Plain text finding"   $TestFileName   "$PlainFinding"    ""       ""   -x  ; fi
if [ -n "$PlainFinding" ]; then Compare_By_File_Pattern_3_Options "Plain ignore case"    $TestFileName   "$PlainFinding"    /I       -i   -ix ; fi
if [ -n "$RegexFinding" ]; then Compare_By_File_Pattern_3_Options "Regex text finding"   $TestFileName   "$RegexFinding"   /R        -e   -t  ; fi
if [ -n "$RegexFinding" ]; then Compare_By_File_Pattern_3_Options "Regex ignore case"    $TestFileName   "$RegexFinding"   "/I /R"   -ie  -it ; fi
