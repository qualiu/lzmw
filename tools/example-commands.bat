::Just run windows-test.bat which calls this file, or run this file directly, you will get a vivid sense of lzmw.
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -x \ -o \\
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -t \\ -o \\
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -t "\\\\" -o \\
lzmw -c -z www.lz.text/temp.normal/samples/my.normal/my-stream.xml -x normal/ -t "(www.*)/([^/]+\.xml)\s*"
lzmw -c -p %~dp0\sample-file.txt -S -t "^(.+\S+)\s*$" -H 0         # Check return value, output nothing
lzmw -c -p %~dp0\sample-file.txt -S -t "^(.+\S+)$" -H 0            # Check return value, output nothing
lzmw -c -p %~dp0\sample-file.txt -S -t "^(.+\S+)\n$" -H 0          # Check return value, output nothing
lzmw -c -p %~dp0\sample-file.txt -S -t "^(.+\S+)\s*$" -o "$1" -R   # Remove tail new line
lzmw -c -p %~dp0\sample-file.txt -S -t "^(.+\S+)\s*$" -o "$1\n" -R # Add a new line to tail
lzmw -c -p %~dp0 -f bat -l -PAC -H 0
lzmw -c -p %~dp0 -f bat -l -PIC -H 0
lzmw -c -p %~dp0 -l -f bat -H -2 # Should skip top 2 items.
lzmw -c -p %~dp0 -l -f bat -T -2 # Should skip bottom 2 items.
lzmw -c -p %~dp0 -l -f bat -H -2 --sz # Should skip top 2 items.
lzmw -c -p %~dp0 -l -f bat -T -2 --wt # Should skip bottom 2 items.
lzmw -c -p %~dp0 -l -f bat -H 2 --wt # Should show top 2 items.
lzmw -c -p %~dp0 -l -f bat -T 2 # Should show bottom 2 items.
lzmw -c -p %~dp0\sample-file.txt -L 7 -N 9 -t Not -U 2 -D 2
lzmw -c -p %~dp0\sample-file.txt -it node --nt "node\d+"
lzmw -c -p %~dp0\sample-file.txt -it node --nt "node\d+" -o "NODE"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t "Node[13]" -a -L 20 -N 50 ## Must no blocks
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t "Node[13]" -a -L 20 -N 80 ## Must have only 1 block
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t "Node[13]" -a  ## Must have and only 2 blocks: Node1 and Node3
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t "Node[1-3]" -x Node2 -a ## Must have only Node2 block
lzmw -c -p %~dp0\sample-file.txt -ib "^\s*<tag" -Q "^\s*</tag" --nt "Node[1-3]" -e "Node\d+"  ## Must no block to output
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -iQ "^\s*</tag" --nt "Node[1-3]"  ## Must no block to output
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -Q "^\s*</tag" -i --nt "Node[1-3]" -a  ## Must no block to output
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -Q "^\s*</tag" -i --nt "Node[13]" -t "Node\d+"  ## Must have only Node2 but not whole block
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -Q "^\s*</tag" -i --nt "Node[13]" -e "Node\d+"  ## Must have only Node2 and whole block
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -Q "^\s*</tag" -i --nt "Node[13]" -a -e "Node\d+" ## Must have only Node2 and whole block
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<tag" -Q "^\s*</tag" -i --nt "Node[13]" -a -t "Node2"  ## Must have only Node2 and whole block
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t "Node[13]" --nx node3 -ai -x Node -o myNode  ## Must have only block Node1 and replaced
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</TagNotExist>" -a ## Should no blocks and output.
lzmw -c -r -p %~dp0 -f "^(example-commands|sample-file)\.(txt|bat)$" -l --sz --wt -T 3
lzmw -c -r -p %~dp0 -f "^(example-commands|sample-file)\.(txt|bat)$" -l --wt --sz -H 3 --dsc --s1 1KB --s2 1MB --w1 "2015-07-20 13:20"
lzmw -c -p %~dp0\sample-file.txt -ib "^\s*enum" -q "\};" -S -t "([\r\n]+)\s+" -o "$1  "  ## Single line regex matching
lzmw -c -p %~dp0\sample-file.txt -ib "^\s*enum" -q "\};" -t "^\s+" -o "  " -a -P
lzmw -c -p %~dp0\sample-file.txt -i -t "(Deferred\w*)"
lzmw -c -p %~dp0\sample-file.txt -it "(Deferred\w*)\s+\1"
lzmw -c -p %~dp0\sample-file.txt -i -b "class DeferredRun" -Q "^};" -t "(Deferred\w*)" -o "$1Replaced"
lzmw -c -p %~dp0\example-commands.bat -it "class|run" -H 9
lzmw -c -p %~dp0\example-commands.bat -ie "class|run" -H 9
lzmw -c -p %~dp0\example-commands.bat -it "^lzmw\s+(-c\s+)?" -L 3 -o "lzmw -c " -H 9
lzmw -c -p %~dp0\example-commands.bat -x bat -o BAT -L 3 -H 5 -T 5      ## Plain text replacing to BAT , begin-row-3, and show top 5 and bottom 5 lines
lzmw -c -p %~dp0\example-commands.bat -t bat -o BAT -L 3 -H 5           ## Plain text replacing to BAT , begin-row-3, show top 5 lines
lzmw -c -p %~dp0\example-commands.bat -t com -x bat -o BAT T -H 5       ## Use both Regex and plain text , replacing from
lzmw -c -p %~dp0\example-commands.bat -t t -L 9 -e txt -H 9             ## single char matching and coloring test
lzmw -c -p %~dp0\example-commands.bat -x t -L 9 -e txt -H 9
lzmw -c -p %~dp0\example-commands.bat -t t -L 9 -e me.txt -H 9       ## Coloring Regex-matched/Plain-found/Regex-enhance text meanwhile
lzmw -c -p %~dp0\example-commands.bat -x t -L 9 -e me.txt -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -L 20 -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -L 20 -ie me -H 9
lzmw -c -p %~dp0\example-commands.bat -t me -L 20 -ie me -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -o you -ie "you|txt|ping" -L 30 -H 9
lzmw -c -p %~dp0\example-commands.bat -t me -o you -ie "you|txt|ping" -L 30 -H 9
lzmw -c -p %~dp0\example-commands.bat -t me -ie "me|ping|\w+.txt" -L 30 -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -ie "me|ping|\w+.txt" -L 30 -H 9
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -U 3 -D 3 -L 16 -H 9
lzmw -c -p %~dp0\example-commands.bat -t name -o NAME -ie Names -H 9
lzmw -c -p %~dp0\example-commands.bat -t name -o NAME -T 1 -C
lzmw -c -p %~dp0\example-commands.bat -it name -l
lzmw -c -p %~dp0\sample-file.txt -it name -l
lzmw -c -p %~dp0\example-commands.bat -t name -a -o NAME -ie Names -b "come|name\w*" -Q "mailTo|Tag" -T 9
lzmw -c -p %~dp0\example-commands.bat -it NOT -U 2 -e "SRC|DIR" -H 5
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -T 3
lzmw -c -p %~dp0\example-commands.bat -t name -o come -ie "name|come" -a -L 19 -H 9
lzmw -c -p %~dp0\example-commands.bat -t name -a -o NAM -ie "name|come" -L 19 -H 9
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -t not -U 3 -D 3
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(Node1|Node2)\b" -Q "<MailAddress>|</Tag>" -e "MailTo" -t body -o BODY -a
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(Node2)\b" -Q "<MailAddress>|</Tag>" -e MailTo -t body -o BODY -a
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(\w+)\b" -Q "<MailAddress>|</Tag>" -t Node1 -e "<.?Tag.*?>" -a
lzmw -c -p %~dp0\example-commands.bat -it name -o NAME -e Names -x update
lzmw -c -p %~dp0\example-commands.bat -it name -e Names -x nameX
lzmw -c -p %~dp0\example-commands.bat -ix update -t name -e Names
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag name" -q "Switch" -Q "</Tag" -t MailTo -e Switch
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag name" -q "Switch" -Q "</Tag" -t MailTo -e Switch -a
lzmw -c -p %~dp0\sample-file.txt -it "<name>(#.+?)</name>\s*<value>(.+?)</value>" -S -o "lzmw -x \"$1\" -o \"$2\"" -L 14 -e "-x (\S+)|-o (\S+)|lzmw " -q "block"
lzmw -c -p %~dp0\sample-file.txt -it Tag -x ref -U 5 -D 5
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -B "2012-12-27 00:03"
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -E "2012-12-27 00:03"
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -q "2012-12-27 00:03"
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -q "2012-12-27|03"
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -B "2012-12-27 00:00" -E "2012-12-27 00:03"
lzmw -c -p %~dp0\sample-file.txt -F "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -B "2012-12-27 00:00" -E "2012-12-27 00:03" -it first
lzmw -c -p %~dp0\example-commands.bat -x " -B" -t ".*?(\d+\S+ \d+[\d:]+).*"
lzmw -c -p %~dp0\sample-file.txt -s "^(\d+-\d+-\d+ [\d:]+(\.\d+)?)" -it 2012
lzmw -c -p %~dp0\sample-file.txt -t "^((((((\d+\D\d+\D\d+[\D\s]*\d+:\d+:\d+))))))(\S*)" -s "^\d+\D\d+\D\d+[\D\s]*\d+:\d+:\d+" -e "\d+|(\w+)\s+line"
lzmw -c -p %~dp0\sample-file.txt -t "^((((((\d+\D\d+\D\d+[\D\s]*\d+:\d+:\d+))))))(\S*)" -s "^\d+\D\d+\D\d+[\D\s]*\d+:\d+:\d+" -e "\d+|(\w+)\s+line" --dsc
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -H 0       ## Must NOT out any matched.
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -T 0       ## Must NOT out any matched.
lzmw -c -p %~dp0\example-commands.bat -it just -U 3 -D 3
lzmw -c -p %~dp0\sample-file.txt -it "\W(function)\W" -e "name=(\S+)"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 92
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 93
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 96
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 97
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 100 -L 90
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 100 -L 91
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 99 -it key2 -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 100 -it key2 -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 100 -it key2 -a -o KEY
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 100
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 101
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -N 102
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 103 -N 110
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 103 -N 111
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 109
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 109 -N 111
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 109 -N 112
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 109 -N 113
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 111 -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 111
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[" -L 111
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[" -t key
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[" -t key -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[" -t key -a -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[" -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -a -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -a -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" --nt Node3 -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3 -a
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3 -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3 -y -a
lzmw -c -p %~dp0\sample-file.txt -S -L 90 -N 100 -it "\s*\[section1.*?value2\s*" -o ""
lzmw -c -p %~dp0\sample-file.txt -S -it "\s*\[section1.*?value2" -o ""
lzmw -c -p %~dp0\sample-file.txt -S -it "\s*\[section1.*?(value2)" -o "$1" -L 88 -N 101
lzmw -c -p %~dp0\sample-file.txt -S -it "\[section1.*?(value2)" -o "$1" -L 88 -N 101
lzmw -c -p %~dp0\sample-file.txt -S -it "\[section1.*?(value2)" -o "$1"  -b "arbitrary block" -N 101
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*" -o ""
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*?value2" -o "value2"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "\s*\[section1.*?value2" -o "value2"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o ""
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -x section1 -S -it "^\s*\[section.*" -o ""
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 93 -S -it "\[section1.*?(value2)" -o "$1"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 93 -S -it "\[section1.*?(value2)\s*" -o "$1"
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -L 90 -N 100 -S -it "\[section1.*?(value2)" -o "$1"
lzmw -c -p %~dp0\sample-file.txt -L 90 -N 93 -S -it "\[section1.*?(value2)" -o "$1"
lzmw -c -p %~dp0\sample-file.txt -L 90 -N 100 -S -it "\[section1.*?(value2)" -o "$1"

:: Block matching: stop pipe test

copy /y %~dp0\sample-file.txt %~dp0\original-sample.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\[" -Q "no-such-end" -t section -o SECTION -R
lzmw -c -p %~dp0\sample-file.txt -b "^\[" -Q "no-such-end" -t SECTION
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "--section1" -Q "^---|^\s*$" -q "--section3" -t section -o SEC -ya -R
lzmw -c -p %~dp0\sample-file.txt -b "--section1" -Q "^---|^\s*$" -q "--section3" -t SEC -ya
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3 -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*<Tag" -Q "^\s*</Tag" -t title -o TITLE --nt Node3
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*"
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -S -L 90 -N 100 -it "\s*\[section1.*?value2\s*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -S -L 90 -N 100 -it "\s*\[section1.*?value2\s*" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section1.*" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -S -it "\s*\[section1.*?value2" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -S -it "\s*\[section1.*?value2" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o ""
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o "" -y
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o "" -y -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -S -it "^\s*\[section.*" -o "" -y
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -x section1 -S -it "^\s*\[section.*" -o "" -R
lzmw -c -p %~dp0\sample-file.txt -b "^\s*\[" -Q "^\s*\[|^\s*$" -x section1 -S -it "^\s*\[section.*" -o ""
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -t "\b(NotMatchedLine|MatchedLine|UpLine|DownLine)" -o "LineType::$1" --nt "=\s*\d+" -R
lzmw -c -p %~dp0\sample-file.txt -t "\b(NotMatchedLine|MatchedLine|UpLine|DownLine)" -o "LineType::$1" --nt "=\s*\d+"
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

lzmw -c -p %~dp0\sample-file.txt -t "\b(NotMatchedLine|MatchedLine|UpLine|DownLine)" -o "LineType::$1" -R
lzmw -c -p %~dp0\sample-file.txt -t "\b(NotMatchedLine|MatchedLine|UpLine|DownLine)" -o "LineType::$1"
copy /y %~dp0\original-sample.txt %~dp0\sample-file.txt

del %~dp0\original-sample.txt

::Stop calling for linux-test.sh as following are advanced test. On Linux , need to replace the double quotes "" to single quotes '' in -o xxxx if contains $1 or $2 etc.
pushd
::Example below extract to a file then generate replacing commands and execute them.
lzmw -c -p %~dp0\sample-file.txt -b "<Tag Name.*?Node1.*?>" -Q "</Tag>" -PA -e "#\S+?#"
lzmw -c -p %~dp0\sample-file.txt -b "<Tag Name.*?Node1.*?>" -Q "</Tag>" -PIC > Node1.tmp
(lzmw -c -p %~dp0\sample-file.txt -it "<name>(#.+?#)</name>\s*<value>(.+?)</value>" -S -o "lzmw -x \"$1\" -o \"$2\""  -PAC | lzmw -t "^\s*(lzmw -x .*)" -o "$1 -p Node1.tmp -R" -PAC) |lzmw -XI -c Automatic extract macro and replace to real values.
lzmw -c -p Node1.tmp -PA -e ".All.|4000|8000"  ## This is an expanded xml that has replaced name value settings.
lzmw -z "if exist Node1.tmp del Node1.tmp" -XPI
popd
