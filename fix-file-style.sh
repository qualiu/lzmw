#!/bin/sh
#=======================================================
# Check and fix file style
#=======================================================

ThisDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SYS_TYPE=$(uname | sed 's/_.*//g' | awk '{print tolower($0)}')

if [ "$SYS_TYPE"x = "linux"x ]; then
    lzmwThis=$ThisDir/lzmw.gcc48
elif [ "$SYS_TYPE"x = "cygwin"x ]; then
    lzmwThis=$ThisDir/lzmw.cygwin
else
    echo "Unknow system type: $SYS_TYPE"
    exit -1
fi

lzmwExisted=$(whereis lzmw 2>/dev/null | lzmw -t "^.*?:\s*(\S+?lzmw\S*).*" -o '$1' -PAC 2>/dev/null | tr -d '\r')

if [[ ! -x $lzmwExisted ]] && [ ! -f $lzmwThis ]; then
    wget "https://github.com/qualiu/lzmw/blob/master/tools/$(basename $lzmwThis)?raw=true" -O $lzmwThis
    lzmwCall=$lzmwThis
    chmod +x $lzmwCall
else
    lzmwCall=lzmw
fi

if [ -z "$1" ]; then
    echo "Usage  : $0  Files-or-Directories  [options]"
    echo "Example: $0  my.cpp"
    echo "Example: $0  \"my.cpp,my.ps1,my.bat\""
    echo "Example: $0  directory-1"
    echo "Example: $0  \"directory-1,file2,directory-3\""
    echo "Example: $0  \"directory-1,file2,directory-3\" -r"
    echo "Example: $0  \$PWD -r"
    echo "Example: $0  . -r --nf \"\.(log|md|exe|cygwin|gcc\w*|txt)$\""
    echo "Example: $0  . -r -f \"\.(bat|cmd|ps1|sh)$\" --nd \"^(target|bin)$\""
    echo "Should not use --np and --pp as used by this; and -p also used." | $lzmwCall -PA -t "\s+(-\S+)|\w+"
    exit -1
fi

PathToDo=$1
lzmwOptions=${@:2}

for ((k = 2; k <= $#; k++)) ; do
    if [ "${!k}" = "-f" ]; then
        hasFileFilter=1
    fi
done

if [ -z "${lzmwOptions[@]}" ]; then
    lzmwOptions=("--nd" "^\.git$")
else
    lzmwOptions=(${lzmwOptions[@]} "--np" "[\\\\/]*(\.git)[\\\\/]")
fi

echo "## Remove white spaces at each line end" | $lzmwCall -PA -e .+
$lzmwCall ${lzmwOptions[@]} -p $PathToDo -it "(\S+)\s+$" -o '$1' -R -c Remove white spaces at each line end.

# echo "## Add a tail new line to files" | $lzmwCall -PA -e .+
# $lzmwCall ${lzmwOptions[@]} -p $PathToDo -S -t "(\S+)$" -o '$1\n' -R -c Add a tail new line to files.

echo "## Add/Delete to have only one tail new line in files" | $lzmwCall -PA -e .+
$lzmwCall ${lzmwOptions[@]} -p $PathToDo -S -t "(\S+)\s*$" -o '$1\n' -R -c Add a tail new line to files.

echo "## Convert tab at head of each lines in a file, util all tabs are replaced." | lzmw -aPA -e .+
function ConvertTabTo4Spaces() {
    if [ -d $PathToDo ]; then
        if [ "$hasFileFilter" != "1" ]; then
            FileFilterConvertTab=("-f" "\.(cpp|cxx|hp*|cs|java|scala|py|bat|cmd|ps1|sh)$")
        fi
        $lzmwCall ${lzmwOptions[@]} -p $PathToDo ${FileFilterConvertTab[@]} -it "^(\s*)\t" -o '$1    ' -R -c Covert TAB to 4 spaces.
    else
        $lzmwCall ${lzmwOptions[@]} -p $PathToDo -it "^(\s*)\t" -o '$1    ' -R -c Covert TAB to 4 spaces.
    fi
    
    if (($? > 0)); then
        ConvertTabTo4Spaces
    fi
}

ConvertTabTo4Spaces


echo "## Convert line ending style from CR LF to LF for Linux files" | $lzmwCall -PA -e .+
FileFilterForLinuxLineEnding=("-f" "^makefile$|\.sh$|\.mak\w*$")
if [ "$hasFileFilter" = "1" ]; then
    FileFilterForLinuxLineEnding=("--pp" "[\\\\/]*makefile$|\.sh$|\.mak\w*$")
fi
$lzmwCall ${lzmwOptions[@]} -p $PathToDo ${FileFilterForLinuxLineEnding[@]} -l -PICc | $lzmwCall -t ".+" -o 'dos2unix \"$0\"' -XA

echo "## Convert line ending style from LF to CR LF for Windows files" | $lzmwCall -PA -e .+
FileFilterForWindowsLineEnding=("-f" "\.(bat|cmd|ps1)$")
if [ "$hasFileFilter" = "1" ]; then
    FileFilterForWindowsLineEnding=("--pp" "\.(bat|cmd|ps1)$")
fi
$lzmwCall ${lzmwOptions[@]} -p $PathToDo ${FileFilterForWindowsLineEnding[@]} -l -PICc | $lzmwCall -t ".+" -o 'unix2dos \"$0\"' -XA
