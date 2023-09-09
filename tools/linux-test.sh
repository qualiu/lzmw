#!/bin/bash

# For example of msr.gcc48, just replace the windows test command and execute them by -X
ThisDir="$( cd "$( dirname "$0" )" && pwd )"
cd $ThisDir
ParentDir="$(cd $ThisDir/../ && pwd)"

msr=$(bash $ThisDir/get-exe-path.sh msr 1)
nin=$(bash $ThisDir/get-exe-path.sh nin 1)

if [ -z "$msr" ] || [ -z "$nin" ]; then
    echo "Not found msr or nin as above." >&2
    exit 1
fi

# echo "msr = msr , nin = $nin" | GREP_COLOR='01;32' grep -E .+ --color=always
for envName in $(printenv | msr -t "^(MSR_[A-Z_]+[A-Z]+)=.*" -o "\1" -PAC); do
    # echo $envName=$(printenv $envName)
    unset $envName
done
printenv | msr -PA -t "^(MSR_[A-Z_]+[A-Z]+)=.*"
[ $? -gt 0 ] && echo "Please clear above environment variables that failed to be auto unset." | grep -E .+ --color && exit 1

testOutputFile=tmp-test-linux-output.txt
[ -f $testOutputFile ] && rm $testOutputFile
msr -p example-commands.bat -i -q "stop" -x "msr -c -p" -t "%~dp0\\\\?" -o './' -PAC --nt "-o\s+.*\s+-R" \
    | msr -t '-o\s+\"(\$\d)\"' -o " -o '\1'" -aPAC \
    | msr -t "msr -c" -o "msr -c -C" --nt " -[PIA]*C" -a -X -M -C \
    | msr -t "Used \d+\S+ s.*" -o "" -aPAC \
    | msr -t "(\d+-\d+\S+ \S+)" -o "Date Time" -aPAC \
    | msr -t "\s*\d+\.?\d*(\s*[KM]?B)(\s*\t\s*)\d+" -o "  Number-Unit  Bytes" -aPAC \
    > $testOutputFile
nin base-linux-test-output.txt $testOutputFile -H 3 -T 3
if [ $? -ne 0 ]; then
    [ -n "$(which bcompare)" ] && bcompare base-linux-test-output.txt $testOutputFile
    exit 1
fi
rm $testOutputFile

echo "-----------Begin new features test ---------"

sourceCmdFile=$ThisDir/test-path-with-new-features.cmd
tmpOutputFile=/tmp/test-output.txt
msr -p $sourceCmdFile -t "^(msr)" -o "msr -C" -X -M -C > $tmpOutputFile
echo >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) (.*)" -o "msr -C \2 --no-check" -X -M -C >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) (.*)" -o "msr -C \2 -W" -X -M -C >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) (.*)" -o "msr -C \2 -W --no-check" -X -M -C >> $tmpOutputFile
cd $ParentDir
git ls-files > tmp-paths-for-test.txt
msr -p $sourceCmdFile -t "^(msr) -rp \S+" -o "msr -C -w tmp-paths-for-test.txt" -X -M -C >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) -rp \S+ (.*)" -o "msr -C -w tmp-paths-for-test.txt \2 --no-check" -X -M -C >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) -rp \S+ (.*)" -o "msr -C -w tmp-paths-for-test.txt \2 -W" -X -M -C >> $tmpOutputFile
msr -p $sourceCmdFile -t "^(msr) -rp \S+ (.*)" -o "msr -C -w tmp-paths-for-test.txt \2 -W --no-check" -X -M -C >> $tmpOutputFile

cd $ThisDir
cat $tmpOutputFile \
    | msr -t "$ParentDir" -o "GitRoot" -aPAC \
    | msr -t "^.+(Run-Command|Return-Value)" -o "\1" -aPAC \
    | msr -t "msr -C" -o "msr" -aPAC \
    | msr -x '/' -o '\' --nt "msr -\S+" -aPAC \
    | msr -t "(Matched \d+ files( in \d+ files)?).*" -o "\1" -aPAC \
    | msr -t "Used \S+ s\W+command\S+ = " -o "" -aPAC \
    | msr -t "\s*\d+\.?\d*(\s*[KM]?B)(\s*\t\s*)\d+" -o "  Number-Unit  Bytes" -aPAC \
    | msr -t "(Matched \d+ files).*" -o "\1" -aPAC \
    > $testOutputFile
nin base-new-features-test.log $testOutputFile -H 3 -T 3
if [ $? -ne 0 ]; then
    [ -n "$(which bcompare)" ] && bcompare base-new-features-test.log $testOutputFile
    exit 1
fi
rm $testOutputFile $tmpOutputFile $ParentDir/tmp-paths-for-test.txt
echo All tests passed in $0 | msr -aPA -e .+
