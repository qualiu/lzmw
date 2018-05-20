#!/bin/sh
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage:   $0  [Test-Number]"
    echo "Example: $0  "
    echo "Example: $0  3"
    echo "This file leverages test cases in replace-file-test.bat to test."
    exit -1
fi

# For example of lzmw.gcc48, just replace the windows test command and execute them by -X
Specified_Test_Number=$1

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

export TestNumber=0
SizeMustBe=$(du -sb sample-file.txt | awk '{printf $1}')
Restore_Pattern_Text=$(lzmw -p replace-file-test.bat -it "^SET\s+Restore_Pattern_Text=(.+)" -o '$1' -PAC)
Restore_Pattern_New_Line=$(lzmw -p replace-file-test.bat -it "^SET\s+Restore_Pattern_New_Line=(.+)" -o '$1' -PAC)

# echo Restore_Pattern_Text=$Restore_Pattern_Text
# echo Restore_Pattern_New_Line=$Restore_Pattern_New_Line

function Restore_To_Another_File() {
    cp -ap sample-test.txt sample-test-restore.txt   >/dev/null
    echo $lzmwThis -p sample-test-restore.txt $Restore_Pattern_Text -Rc | lzmw -XA  >/dev/null
    echo $lzmwThis -p sample-test-restore.txt $Restore_Pattern_New_Line -Rc | lzmw -XA  >/dev/null
}

function Repro_Error_Replacing() {
    cp -ap sample-file.txt sample-test.txt  >/dev/null
    echo $lzmwThis $@ | lzmw -XA  >/dev/null
    echo Error test: lzmw $@ | lzmw -aPA -e "((lzmw.+))" -t "((Error \S+))"
    # echo You can try: lzmw $@ | lzmw -aPA -x sample-test.txt -o sample-test-restore.txt | lzmw -aPA -e "(lzmw.+)" -t "((You.*?try:))"
    echo Full retry: cp -ap sample-file.txt sample-test.txt AND lzmw $@ AND nin sample-file.txt sample-test.txt | lzmw -aPA -x AND -o ";" -e "copy.*?\s+&|((lzmw.*?))\s+&|bcompare.*txt" -t "((Full retry:))"

    echo Test-$TestNumber failed: lzmw $@ | lzmw -aPA -it "(Test-.*failed)" -e "((lzmw.+))"
    cp -ap sample-file.txt sample-test-restore.txt  >/dev/null
    # Check and exit by file content , then by file size
    nin sample-file.txt sample-test-restore.txt
    unix2dos sample-test-restore.txt 2>/dev/null
    restoredFileSize=$(du -sb sample-test-restore.txt | awk '{printf $1}')
    if (( $restoredFileSize != $SizeMustBe )); then
        echo "sample-test-restore.txt size is $restoredFileSize not equal $SizeMustBe" | lzmw -t .+
    fi
    echo Test-$TestNumber failed: lzmw $@ | lzmw -aPA -it "(Test-.*failed)" -e "(lzmw.+)"
    exit -1
}

function Replace_And_Check() {
    TestNumber=$(($TestNumber + 1))
    if [ -n "$Specified_Test_Number" ] && [ "$Specified_Test_Number" != "$TestNumber" ]; then
        echo Skip Test-$TestNumber: lzmw $@ | lzmw -aPA -e "Skip \w+" -t "(?<=Test-)\d+"
        return
    fi
    echo Test-Replace-File-And-Verify-$TestNumber: lzmw $@ | lzmw -aPA -x Test-Replace-File- -e "Verify|((lzmw.+))" -t "And|(?<=-)\d+(?:)"
    # Copy -> replace -> restore -> compare
    cp -ap sample-file.txt sample-test.txt  >/dev/null
    #args=$(echo $@ | lzmw -x '"' -o '\"' -PAC)
    echo "$lzmwThis $@" | lzmw -XMI  >/dev/null
    Restore_To_Another_File #  >/dev/null
    # bcompare sample-test.txt sample-test-restore.txt
    nin sample-file.txt sample-test-restore.txt -O # || ( Repro_Error_Replacing $@ ; exit -1 )
    if [ "$?" -ne 0 ]; then
        Repro_Error_Replacing $@
        exit -1
    fi

    nin sample-file.txt sample-test-restore.txt -S -O # || ( Repro_Error_Replacing $@ ; exit -1 )
    if [ "$?" -ne 0 ]; then
        Repro_Error_Replacing $@
        exit -1
    fi

    unix2dos sample-test-restore.txt 2>/dev/null
    restoredFileSize=$(du -sb sample-test-restore.txt | awk '{printf $1}')
    if [ "$restoredFileSize" -ne $SizeMustBe ]; then
        echo Failed validation: sample-test-restore.txt size = $restoredFileSize not $SizeMustBe
        Repro_Error_Replacing $@
        exit -1
    fi
}

$lzmwThis -p replace-file-test.bat -t "^call :Replace_And_Check\s+(.+?)(\s*\|\|.+)?\s*$" -o '$1' -PAC |
    while IFS= read -r cmdLine ; do
        Replace_And_Check $cmdLine || exit $?
    done
