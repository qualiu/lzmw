Vivid Colorful Demo/examples: Run windows-test.bat without parameters.
Download all by command : git clone https://github.com/qualiu/lzmw/

Just run the exe, you'll get the usage and examples. Besides, some script/batch/shell are also examples.
For example, running lzmw.exe and nin.exe on windows:

# nin.exe -------------------------------------------------
Get difference-set(not-in-later) for first file/pipe; Or intersection-set with later file. (by lz):
  -u [ --unique ]           unique result : discard self/mutual duplicated
  -m [ --intersection ]     Get intersection : reverse default 'not-in-later'
  -i [ --ignore-case ]      Ignore case for capture-regex pattern
  -p [ --percentage ]       Out percentage and sort if NOT set [capture]
  -s [ --sort-text ]        Sort by text if NOT set -p and NOT set [capture]
  -a [ --ascending ]        Ascending order for sorting if NOT set [capture]
  -d [ --descending ]       Descending order for sorting if NOT set [capture]
  -A [ --no-any-info ]      No any info nor summary.
  -I [ --info-normal-out ]  Output info normally : not output to stderr.
  -O [ --only-summary ]     Only output summary.
  -C [ --no-color ]         No color for output.
  -P [ --no-percent ]       Not show percentage number (if has --percentage).
  -h [ --help ]             See above and bellow.

Usage  : d:\lztool\nin.exe  file1-or-pipe file2-or-nul  [file1/pipe-capture1-regex]  [file2-capture1-regex]  [switches like: -i -u -m]
All [xxx-xxx] in above usage are Optional , can be omitted;
If set [xxx-capture1-regex], Must have regex capture group[1] : Simple example like "^(.+)$" or Example-1
If only set [file1/pipe1-capture1-regex] then  [file2-capture1-regex] will use the same.
If both of them not set, will use normal whole line text comparison: check lines in file1/pipe1 which not-in/in file2.
Example-1: nin daily-sample.txt  selected-queries.txt   "^([^\t]+)"  "query = (.+)$"   -u -i
Example-2: nin daily-sample.txt nul -u -p
Example-3: type daily-sample.txt | nin nul -up
Example-1 uses regex capture1 to get new queries: only in daily-sample.txt but not in later file. (if use -m will get intersection set of the 2 files)
Example-2/3 are same : get unique(-u) lines in file and show each percentage(-p) with order.
Return value is line count in {only first file/pipe} or {common intersection}.

Any good ideas please to : QQ : 94394344 , aperiodic updates and docs on https://github.com/qualiu/lzmw
Call@Anywhere: add to PATH with parent directory: d:\lztool or temporarily : SET PATH=%PATH%;d:\lztool



# lzmw.exe ------------------------------------------------
Line matching/replacing(IGNORE case of file and directory name) by LQM since 2012.12:
  -r [ --recursive ]          Recursively search sub-directories.
  -p [ --path ] arg           Directories or files, use ',' or ';' to separate.
  -f [ --file-match ] arg     Regex pattern for file name to search.
  -t [ --text-match ] arg     Regex pattern for line text must match.
  -x [ --has-text ] arg       Line must contain this normal text (not regex)
  --nx arg                    Line must NOT contain this normal/plain text.
  --nt arg                    Pattern for lines must NOT match.
  --nf arg                    Pattern for file name must NOT match.
  --pp arg                    Pattern for full file path must match.
  --np arg                    Pattern for full file path must NOT match.
  --nd arg                    File's parent directory names must NOT match.
  -d [ --dir-has ] arg        File's parent directory names must has one match.
  -i [ --ignore-case ]        Ignore case of matching/replacing text.
  -e [ --enhance ] arg        Pattern to enhance text, inferior to : -t -x -o
  -o [ --replace-to ] arg     Replace -x/-t XXX to -o XXX
  -a [ --all-out ]            Output all lines including not matched.
  -A [ --no-any-info ]        No any extra info nor summary, only pure result.
  -I [ --no-extra ]           Pure result except summary info out to stderr.
  -P [ --no-path-line ]       Not out path and line number at head.
  -C [ --no-color ]           Output without color effect.
  -F [ --time-format ] arg    Time pattern: use captured group[1] if has else 0
  -B [ --time-begin ] arg     like "2013-01-10 11:00:00", just text NOT time.
  -E [ --time-end ] arg       like "2013-01-10 15:30", text NOT time comparing.
  -s [ --sort-by ] arg        Sort by pattern: captured group[1] else group[0]
  --dsc                       Descending order to sort and output result.
  -l [ --list-count ]         Only display file path list or matched count.
  --wt                        Display/sort by file last write time(with -l)
  --w1 arg                    File modify time >= like "2013-01-10 01:00:00".
  --w2 arg                    File modify time <= like "2013-01-10 12:30".
  --sz                        Display/sort by file size(with -l): B,KB,MB,GB,*
  --s1 arg                    File size >= like 100kb (No Space, B if no unit)
  --s2 arg                    File size <= like 2.5M (No Space, B if no unit)
  -R [ --replace-file ]       Replace file text : -x/-t XXX to -o XXX
  -K [ --backup ]             Backup files if replaced content.
  -S [ --single-line ]        Single line mode for Regex to match/replace.
  -c [ --show-command ]       Show command line(and can append any text)
  -U [ --up ] arg             Out above lines of matched by -t or found by -x
  -D [ --down ] arg           Out bellow lines of matched by -t or found by -x
  -H [ --head ] arg           Out only top [N] lines of whole output,except -T
  -T [ --tail ] arg           Out only bottom [N] lines of whole, except -H
  -L [ --row-begin ] arg      Begin row of reading pipe or files.
  -N [ --row-end ] arg        End row of reading pipe or files.
  -b [ --start-pattern ] arg  Regex pattern to begin each reading/replacing.
  -q [ --stop-pattern ] arg   Regex pattern to stop reading/replacing at once.
  -Q [ --stop-matched ] arg   Regex pattern to stop after matching start.
  -O [ --out-if-did ]         Out summary info only if matched/replaced/found.
  -X [ --execute-out-lines ]  Execute final out lines as commands.
  -z [ --string ] arg         Input a string instead of reading files or pipe.
  --verbose                   Show parsed parameters and return code, etc.
  -h [ --help ]               See usage and https://github.com/qualiu/lzmw

Note: Return value is the matched/replaced count in files or pipe.
(1) Skip/Stop reading:
    -L/-b skip rows above/not-matched-begin; -b and -Q to match/replace multiple blocks in each-file/pipe; with -a to output each entire block.
    -N/-Q/-q stop reading rows bellow/matched-quit-pattern; -q stops reading/replacing each-file or pipe immediately. -N/-Q/-q contains the stopping line.
    -B and -E only textually/literally compare with time text matched by -F XXX , not parsed to time then compare.
    Except -R (--replace-file), which means it'll not skip/replace but just copy the rows which should skip/stop.
    -R does NOT change files if no lines replaced;
    -K (--backup) to backup files, append modify-time to name (--YYYY-MM-dd__HH_mm_ss-{N} : N start from 1). Backup only if file changed.
    Preview replacing result without -R .
(2) Replace By Regex or normal: If use both -t (--text-match) and -x (--has-text), will use the closer one to -o (--replace-to);
    But if their distances to -o are same, replace by the prior one ( in command line position ).
(3) Sort file list by time or size: (sort result by time/key see usage and bottom examples)
    Both --sz and --wt only work with -l (--list-count) to display and sort by file's last-write-time and size;
    sort by the prior one (in command line position) if use both of them.
(4) Execute output line as command : If has -X (--execute-out-lines):
    -P will not output lines(commands) before executing;
    -I will not output each execution summary;  -O will not output execution summary if return value = 0.
    -A will omit both of them and new lines (which separates executions).
(5) Further extraction by summary:
    Use -c (--show-command), you can append any text to the command line.
    Use -O to out summary only if matched/replaced/found or execution-result != 0.
    Use -H 0 or -T 0 if you just want summary info.
(6) Map <--> Reduce : -o transforms one line to multi-lines; -S changes -t to single-line Regex mode.
    lzmw -p my.log -t "host-list=([\d\.]+),(\d\.]+),([^,]+)" -o "${1}\n$2\n$3" -P -A -C | lzmw -S -t "([\d\.]+)[\r\n]*" -o "$1," -PAC | lzmw ... | lzmw ...
(7) Quick look up usage by self : Also helpful to look up system/other tool usages with brief context (Up/Down lines)
    lzmw | lzmw -i -t sort -U 3 -D 3 -e time
    robocopy /? | lzmw -it mirror -U 3 -D 3 -e purge

Additional feature: Directly reading text by -z (--string instead of echo) Example: Finding non-exist path in %PATH% and olny check 3 header + 3 tailer paths:
    lzmw -z "%PATH%" -t "\s*;\s*" -o "\n" -PAC | lzmw -t .+ -o "if not exist \"$0\" echo NOT EXIST $0"  -PI -H 3 -T 3 -X

Example-1 : Find env in profiles:
    D:\lztool\lzmw.exe --recursive --path "/home/qualiu , /etc , /d/cygwin/profile"  --file-match "\.(env|xml|\w*rc)$"  --text-match "^\s*export \w+=\S+" --ignore-case

Example-2 : Find error in log files : row text (contain time) start matching(-t xxx) from -B xxx with given format(-F xxx); last-write-time between [--w1,--w2]
    lzmw -rp /var/log/nova/,/var/log/swift -f "\.log$"  -F "^(\d{2,4}-\d+-\d+ [\d+:]+(\D\d+)?)" -B "2013-03-12 14:35" -i -t "\b(error|fail|fatal|exception)"  --w1 2013-03-12 --w2 "2013-03-13 09"

Example-3 :  Recursively(-r) replace-file(-R) : IP tail in <SQL> or <Connection>; Only in xxx-test directory skip Prod-xxx; Skip rows>=200 for each file; Backup(-K) if changed.
    lzmw -rp  .  -f "\.xml$" -d "\w+-test$" --nd "Prod-\w+" -b "^\s*<SQL|Connection>" -Q "^\s*</(SQL|Connection)>" -N 200 -it "(\d{1,3})\.(\d{1,3})\.\d{1,3}\.\d{1,3}" -o "${1}.$2.192.203" -RK

Example-4 : Read Pipe : such as : type query.txt | lzmw -t words -PAC 2>nul | lzmw -PIC -xxx ...
    ipconfig | lzmw -t "^.*?(\d+\.[\d\.]{4,}).*$"  -o "${1}" -PAC

Example-5 : Single-line regex mode replacing whole text in each file and backup (preview without -R)
    lzmw -rp "%CD%" -f "config\w*\.(xml|ini)$" -S -t "(<Command>).*?(</Command>)" -o "$1 new-content ${2}" -RK

Example-6 : Multi-line regex mode (normal mode) replacing lines in each file and backup (preview without -R)
    lzmw -rp spark\bin,spark\test -f "\.(bat|cmd)$"  -it "^(\s*@\s*echo)\s+off\b" -o "$1 on" -R -K

Example-7 : Display current modified code files :
    for /F %s in ('lzmw -l -f "\.(cs|java|cpp|cx*|hp*|py|scala)$" -rp "%CD%" --nd "^(debug|release)$"  --w1 "2016-12-23 22:30:55" -PAC 2^>nul ') do @echo code file : %s

Example-8 : Get 2 oldest and newest mp3 (4 files) which 3.0MB<=size<=9.9MB and show size unit, in current directory (Can omit -p . or -p %CD%)
    lzmw -l --wt -H 2 -T 2 -f "\.mp3$" --sz --s1 3.0MB --s2 9.9m

Example-9 : Find file in PATH environment variable : such as ATL*.dll :
    for /f "tokens=*" %d in ('set path ^| lzmw -it "^PATH=(.+)" -o "$1" -PAC ^| lzmw -t "([^;]+);*" -o "$1\n" -PAC ^| lzmw -it "\\\s*$" -o "" -a -PAC') do @lzmw -l -p "%d" -f "^ATL.*\.dll$" -PA 2>nul

All commands are optional and no order. Can merge single char commands like:  -rp -it -ix -PIC -PAC -POC -PIOCcl -PICc -PICcl
Useful: -PAC , -PIC , -POC, -POC -l, -POlc , -XI, -XIP, -XA, -XO, -XPOI, or 2>nul (2^>nul in BAT or pipe)
Any good ideas please to : QQ : 94394344 , aperiodic updates and docs on https://github.com/qualiu/lzmw
Call@Anywhere: add to PATH with parent directory: D:\lztool or temporarily : SET PATH=%PATH%;D:\lztool