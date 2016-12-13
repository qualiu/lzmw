::Just run windows-test.bat which calls this file, or run this file directly, you will get a vivid sense of lzmw.
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -x \ -o \\
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -t \\ -o \\
lzmw -c -z "c:\Program Files\LLVM\bin\clang.exe" -t "\\\\" -o \\
lzmw -c -p %~dp0 -f "^(example-commands|sample-file)\.(txt|bat)$" -l --wt --sz -H 3 --dsc
lzmw -c -p %~dp0 -f "^(example-commands|sample-file)\.(txt|bat)$" -l --sz --wt -T 3 
lzmw -c -p %~dp0 -f "^(example-commands|sample-file)\.(txt|bat)$" -l --wt --sz -H 3 --dsc --s1 1KB --s2 1MB --w1 "2015-07-20 13:20"
lzmw -c -p %~dp0\sample-file.txt -ib "^\s*enum" -q "\};" -S -t "([\r\n]+)\s+" -o "$1  "
lzmw -c -p %~dp0\sample-file.txt -ib "^\s*enum" -q "\};" -t "^\s+" -o "  " -a -P
lzmw -c -p %~dp0\sample-file.txt -i -t "(Deferred\w*)"
lzmw -c -p %~dp0\sample-file.txt -it "(Deferred\w*)\s+\1"
lzmw -c -p %~dp0\sample-file.txt -i -b "class DeferredRun" -Q "^};" -t "(Deferred\w*)" -o "$1Replaced"
lzmw -c -p %~dp0\example-commands.bat -it "class|run" -H 9
lzmw -c -p %~dp0\example-commands.bat -ie "class|run" -H 9
lzmw -c -p %~dp0\example-commands.bat -it "^lzmw\s+(-c\s+)?" -L 3 -N 9 -o "lzmw -c "
lzmw -c -p %~dp0\example-commands.bat -x t -o T -H 5
lzmw -c -p %~dp0\example-commands.bat -t t -o T -H 5
lzmw -c -p %~dp0\example-commands.bat -x T -o t -H 5
lzmw -c -p %~dp0\example-commands.bat -t T -o t -H 5
lzmw -c -p %~dp0\example-commands.bat -t t -L 3 -H 5
lzmw -c -p %~dp0\example-commands.bat -x t -L 3 -H 5 -T 5
lzmw -c -p %~dp0\example-commands.bat -t t -L 3 -e t -T 5
lzmw -c -p %~dp0\example-commands.bat -x t -L 3 -e t -T 5
lzmw -c -p %~dp0\example-commands.bat -t t -L 3 -e t -o T -H 5
lzmw -c -p %~dp0\example-commands.bat -x t -L 3 -e t -o T -H 5
lzmw -c -p %~dp0\example-commands.bat -t t -L 9 -N 12 -e txt
lzmw -c -p %~dp0\example-commands.bat -x t -L 9 -N 12 -e txt
lzmw -c -p %~dp0\example-commands.bat -t t -L 9 -N 12 -e me.txt
lzmw -c -p %~dp0\example-commands.bat -x t -L 9 -N 12 -e me.txt
lzmw -c -p %~dp0\example-commands.bat -x me -L 20 -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -L 20 -ie me -H 9
lzmw -c -p %~dp0\example-commands.bat -t me -L 20 -ie me -H 9
lzmw -c -p %~dp0\example-commands.bat -x me -o you -ie "you|txt|ping" -L 30 -N 40
lzmw -c -p %~dp0\example-commands.bat -t me -o you -ie "you|txt|ping" -L 30 -N 40
lzmw -c -p %~dp0\example-commands.bat -t me -ie "me|ping|\w+.txt" -L 30 -N 40
lzmw -c -p %~dp0\example-commands.bat -x me -ie "me|ping|\w+.txt" -L 30 -N 40
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -U 3 -D 3 -L 16 -N 30
lzmw -c -p %~dp0\example-commands.bat -t name -o NAME -ie "name|come" -U 3 -D 3 -L 16 -N 30
lzmw -c -p %~dp0\example-commands.bat -x name -o come -ie "name|come" -U 3 -D 3 -L 16 -N 30
lzmw -c -p %~dp0\example-commands.bat -x name -o come -ie "name|come" -U 3 -D 3 -T 8 -L 16 -N 30
lzmw -c -p %~dp0\example-commands.bat -t name -o come -ie "name|come" -U 3 -D 3 -T 9 -L 16 -N 30
::lzmw -c -p %~dp0\sample-file.txt -t "\b(NotMatchedLine|MatchedLine|UpLine|DownLine)" -o "LineType::$1" --nt "=\s*\d+" -R
lzmw -c -p %~dp0\example-commands.bat -t name -o NAME -ie Names -H 9
lzmw -c -p %~dp0\example-commands.bat -t name -o NAME -T 1 -C
lzmw -c -p %~dp0\example-commands.bat -it name -l
lzmw -c -p %~dp0\sample-file.txt -it name -l
lzmw -c -p %~dp0\example-commands.bat -t name -a -o NAME -ie Names -b "come|name\w*" -Q "mailTo|Tag" -T 9
lzmw -c -p %~dp0\example-commands.bat -it NOT -U 2 -e "SRC|DIR" -H 5
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -T 3
lzmw -c -p %~dp0\example-commands.bat -t name -o come -ie "name|come" -a -L 19 -N 26
lzmw -c -p %~dp0\example-commands.bat -t name -a -o NAM -ie "name|come" -L 19 -N 26
lzmw -c -p %~dp0\example-commands.bat -b "garbage" -Q publish-update -t ping -e "me|ping|you|(publish-update)"
lzmw -c -p %~dp0\example-commands.bat -b "garbage" -q publish-update -t ping -e "me|ping|you|(publish-update)"
lzmw -c -p %~dp0\example-commands.bat -x name -o NAME -ie "name|come" -t not -U 3 -D 3 
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(Node1|Node2)\b" -Q "<MailAddress>|</Tag>" -e "MailTo" -t body -o BODY -a
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(Node2)\b" -Q "<MailAddress>|</Tag>" -e MailTo -t body -o BODY -a
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag Name.*?\b(\w+)\b" -Q "<MailAddress>|</Tag>" -t Node1 -e "<.?Tag.*?>" -a
lzmw -c -p %~dp0\example-commands.bat -it name -o NAME -e Names -x update
lzmw -c -p %~dp0\example-commands.bat -it name -e Names -x nameX
lzmw -c -p %~dp0\example-commands.bat -ix update -t name -e Names
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag name" -q "Switch" -Q "</Tag" -t MailTo -e Switch 
lzmw -c -p %~dp0\sample-file.txt -ib "<Tag name" -q "Switch" -Q "</Tag" -t MailTo -e Switch -a
lzmw -c -p %~dp0\sample-file.txt -it "<name>(#.+?)</name>\s*<value>(.+?)</value>" -S -o "lzmw -x \"$1\" -o \"$2\"" -L 14 -N 30
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
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -H 0       Should NOT out any matched.
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -H 0 -T 2  Should out only 2 matched of bottom.
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -T 0       Should NOT out any matched.
lzmw -c -p %~dp0\example-commands.bat -it "\w+" -T 0 -H 2  Should out only 2 matched of top.
lzmw -c -p %~dp0\example-commands.bat -N 3 -it just -U 3 -D 3
::Stop calling for linux-test.sh as following are advanced test. On Linux , need to replace the double quotes "" to single quotes '' in -o xxxx if contains $1 or $2 etc.
lzmw -c -p %~dp0\sample-file.txt -b "<Tag Name.*?Node1.*?>" -Q "</Tag>" -PA -e "#\S+?#" This is raw xml text extracted.
lzmw -c -p %~dp0\sample-file.txt -b "<Tag Name.*?Node1.*?>" -Q "</Tag>" -PIC > Node1.tmp
(lzmw -c -p %~dp0\sample-file.txt -it "<name>(#.+?#)</name>\s*<value>(.+?)</value>" -S -o "lzmw -x \"$1\" -o \"$2\""  -PAC | lzmw -t "^\s*(lzmw -x .*)" -o "$1 -p Node1.tmp -R" -PAC) |lzmw -XI
lzmw -c -p Node1.tmp -PA -e ".All.|4000|8000" This is expanded xml that has replaced name value settings.
lzmw -z "if exist Node1.tmp del Node1.tmp" -XPI