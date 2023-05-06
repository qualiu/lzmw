#!/bin/bash
#==================================================================
# Check and fix file style.
# Latest version in: https://github.com/qualiu/msrTools
#==================================================================

ThisDir="$( cd "$( dirname "$0" )" && pwd )"
SYS_TYPE=$(uname -s | sed 's/_.*//g' | awk '{print tolower($0)}')

which lzmw 2>/dev/null 1>&2
if [ $? -ne 0 ]; then
sh $ThisDir/check-download-tools.sh
    if [ $? -ne 0 ]; then
        echo "Failed to call $ThisDir/check-download-tools.sh" >&2
        exit -1
    fi
fi

lzmw -z "LostArg$1" -t "^LostArg(|-h|--help|/\?)$" > /dev/null
if [ $? -ne 0 ]; then
    echo "Usage  : $0  Files-or-Directories  [options]"
    echo "Example: $0  my.cpp"
    echo "Example: $0  \"my.cpp,my.ps1,my.bat\""
    echo "Example: $0  directory-1"
    echo "Example: $0  \"directory-1,file2,directory-3\""
    echo "Example: $0  \"directory-1,file2,directory-3\" -r"
    echo "Example: $0  \$PWD -r"
    echo "Example: $0  . -r --nf \"\.(log|md|exe|cygwin|gcc\w*|txt)$\""
    echo "Example: $0  . -r -f \"\.(bat|cmd|ps1|sh)$\" --nd \"^(target|bin)$\""
    echo "Should not use --np and --pp as used by this; and -p also used." | lzmw -PA -t "\s+(-\S+)|\w+"
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

# if path has one directory, add file filter
if [ ! -f "$PathToDo" ]; then
    if [ "$hasFileFilter" != "1" ]; then
        FileFilter=("-f" "\.(c|cpp|cxx|h|hpp|cs|java|scala|py|bat|cmd|ps1|sh)$")
    else
        FileFilter=("--pp" "\.(c|cpp|cxx|h|hpp|cs|java|scala|py|bat|cmd|ps1|sh)$")
    fi
fi

echo "## Remove all white spaces if it is a white space line" | lzmw -PA -e .+
lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -t "^\s+$" -o "" -R -c Remove all white spaces if it is a white space line.


echo "## Remove white spaces at each line end" | lzmw -PA -e .+
lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -t "(\S+)\s+$" -o '$1' -R -c Remove white spaces at each line end.

# echo "## Add a tail new line to files" | lzmw -PA -e .+
# lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -S -t "(\S+)$" -o '$1\n' -R -c Add a tail new line to files.

echo "## Add/Delete to have only one tail new line in files" | lzmw -PA -e .+
lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -S -t "(\S+)\s*$" -o '$1\n' -R -c Add a tail new line to files.

echo "## Convert tab at head of each lines in a file, util all tabs are replaced." | lzmw -aPA -e .+
function ConvertTabTo4Spaces() {
    if [ -d $PathToDo ]; then
        lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -it "^(\s*)\t" -o '$1    ' -R -c Covert TAB to 4 spaces.
    else
        lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilter[@]} -it "^(\s*)\t" -o '$1    ' -R -c Covert TAB to 4 spaces.
    fi

    if (($? > 0)); then
        ConvertTabTo4Spaces
    fi
}

ConvertTabTo4Spaces


echo "## Convert line ending style from CR LF to LF for Linux files" | lzmw -PA -e .+
FileFilterForLinuxLineEnding=("-f" "^makefile$|\.sh$|\.mak\w*$")
if [ "$hasFileFilter" = "1" ]; then
    FileFilterForLinuxLineEnding=("--pp" "[\\\\/]*makefile$|\.sh$|\.mak\w*$")
fi
lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilterForLinuxLineEnding[@]} -l -PICc | lzmw -t ".+" -o 'dos2unix \"$0\"' -XA

echo "## Convert line ending style from LF to CR LF for Windows files" | lzmw -PA -e .+
FileFilterForWindowsLineEnding=("-f" "\.(bat|cmd|ps1)$")
if [ "$hasFileFilter" = "1" ]; then
    FileFilterForWindowsLineEnding=("--pp" "\.(bat|cmd|ps1)$")
fi
lzmw ${lzmwOptions[@]} -p $PathToDo ${FileFilterForWindowsLineEnding[@]} -l -PICc | lzmw -t ".+" -o 'unix2dos \"$0\"' -XA
