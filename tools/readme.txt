Just run the exe, you'll get the usage and examples.
Besides, some script/batch/shell are also examples.

For example, running lzmw.exe and nin.exe on windows:

# lzmw.exe ------------------------------------------------
line matching(IGNORE case of file or directory name) by LQM (QQ: 94394344):
  -r [ --recursive ]          recursively search sub-directories.
  -p [ --path ] arg           directories or files, use ',' or ';' to separate.
  -f [ --file-match ] arg     regex pattern of file name to search.
  -t [ --text-match ] arg     regex pattern of lines must match.
  -x [ --has-text ] arg       line text to find, not regex of --text-match
  --nx arg                    line not has normal text, not regex pattern
  --nt arg                    pattern of lines must not match.
  --nf arg                    pattern of file name must not match.
  --pp arg                    pattern of full file path must match
  --np arg                    pattern of full file path must not match
  --nd arg                    any sub directory name must not match.
  -d [ --dir-has ] arg        file's parent directory must has one match
  -i [ --ignore-case ]        ignore case of line to match or enhance.
  -e [ --enhance ] arg        pattern to enhance text, inferior to : -t -x -o
  -o [ --replace-to ] arg     pattern to replace --text-match or --has-text
  -a [ --all-out ]            output all lines, including not matched.
  -A [ --no-any-info ]        only result lines no extra info (nor to stderr).
  -I [ --no-extra ]           only result lines no extra info (may to stderr).
  -P [ --no-path-line ]       not out path and line number at head.
  -C [ --no-color ]           output without color effect.
  -F [ --time-format ] arg    time pattern: use captured group 1 if has else 0
  -B [ --time-begin ] arg     like "2013-01-10 01:00:00", by and compare -F XXX
  -E [ --time-end ] arg       like "2013-01-10 15:30", by and compare -F XXX
  -s [ --sort-by ] arg        sort by pattern: captured group(1) else group(0)
  --dsc                       descending output of sorted by --sort-by
  -l [ --list-count ]         only diplay file path list or matched count.
  --wt                        display file last write (modified) time.
  --w1 arg                    file modify time >= like "2013-01-10 01:00:00".
  --w2 arg                    file modify time <= like "2013-01-10 12:30".
  -R [ --replace-in-file ]    replace in file: --text-match to --replace-to
  -K [ --backup ]             backup file before replacing. default not.
  -S [ --single-line-match ]  single line rule for match/replace (often file)
  -c [ --show-command ]       show command line. default not.
  -U [ --up ] arg             out above lines of matched by -t or found by -x
  -D [ --down ] arg           out bellow lines of matched by -t or found by -x
  -H [ --head ] arg           out only top count lines of whole output.
  -T [ --tail ] arg           out only bottom count lines of whole ouput.
  -L [ --row-begin ] arg      begin row of reading pipe or files
  -N [ --row-end ] arg        end row of reading pipe or files
  -z [ --start-pattern ] arg  regex pattern to start reading or replacing
  -Z [ --stop-pattern ] arg   regex pattern to stop reading or replacing
  --verbose                   show parsed parameters from input command line
  -h [ --help ]               Note: Only with -R(--replace-in-file), -z/-Z will
                              copy the above/bellow rows in files/pipe; If
                              without it, not cope/out the above/bellow.

Example-1 : find text(env) in profiles
        D:\lztool\lzmw.exe --recursive --path "/home/qualiu , /etc , /d/cygdisk"  --file-match "\.(env|xml|\w*rc)$"  --text-match "^\s*export \w+=\S+"  --ignore-case
Example-2 : find error in log :
        lzmw -rp /var/log/nova/,/var/log/swift  -f "\.log$" -F "^(20\d{2}-\d{2}-\d+ \d+:\d+:\d+(\.\d+)?)" -B "2013-03-12 14:3[5-8]"  -i -t "\b(error|fail|fatal|exception)"
Example-3 : replace captured text
        lzmw -rp . --nt  "^\s*(//|#)" --nd  "bak|^(\.svn|debug)$" -it  "^\s*(class|def)\s+(\w*live\w*migrat\w+)" -o "$1 $2" -o "${1} $2" -PI
Example-4 : Read Pipe : such as : type query.txt | lzmw -t words -PAC 2>nul | lzmw -PIC -xxx ...
        ipconfig | lzmw -t "^.*?([\d\.]{8,}).*$"  -o "${1}" -PIC 2>nul
Example-5 : Single-replace lines in many files and keep backup (try preview without -R)
        lzmw -rp "%CD%" -f "config\w*\.(xml|ini)$" -t "(<Command>).*?(</Command>)" -o "$1 new-command-or-file ${2}" -S -R -K
Example-6 : Multiline-replace lines in many files and keep backup (try preview without -R)
        lzmw -p myscript.bat -it "(copy)\s+" -o "$1 /y " -R -K
Example-7 : get current modified code file :
        for /F %s in ('lzmw -l -f "\.(cs|java|cpp|cx*|hp*|py|scala)$" -rp "%CD%" --nd "^(debug|release)$"  --w1 "2016-11-08 14:10:04" -PAC 2^>nul ') do @echo code file : %s
Example-8 : Get 2 oldest and newest mp3 files (can omit -p . or -p %CD% if in current directory. clean by -P, -PI or -PAC )
        lzmw -l --wt -H 2 -T 2 -f "\.mp3$" -c    ( -f mp3 also works but not precise )
Example-9 : find file in PATH : such as ATL*.dll :
        for /f "tokens=*" %d in (' set path ^| lzmw -it "^PATH=(.+)" -o "$1" -PAC ^| lzmw -t "([^;]+);*" -o "$1\n" -PAC ^| lzmw -it "\\\s*$" -o "" -a -PAC ') do @lzmw -l -p "%d" -f "^ATL.*\.dll$" -PA 2>nul
All commands are optional and no order. Can merge single char commands like: -rp -it -PIC -PAC ; Useful: -PAC or -PIC or 2>nul (2^>nul in BAT or pipe)
Any good ideas please to : QQ : 94394344 , aperiodic updates and docs on https://github.com/qualiu/lzmw
Call@Anywhere: add to PATH with parent directory: D:\lztool or temporally : SET PATH=%PATH%;D:\lztool


# nin.exe -------------------------------------------------
Get difference-set(not-in-later) for first file/pipe; Or intersection-set with later file. (by lz):
  -u [ --unique ]        unique result : discard self/mutual duplicated
  -m [ --intersection ]  get intersection-set : reverse default 'not-in-later'
  -i [ --ignore-case ]   ignore case for capture-regex pattern
  -p [ --percentage ]    out percentage and sort if NOT set [capture]
  -s [ --sort-text ]     sort by text if NOT set -p and NOT set [capture]
  -d [ --descending ]    descending order for sorting if NOT set [capture]
  -h [ --help ]          See above optional switches and usage/examples bellow

Usage  : D:\lztool\nin.exe  file1-or-pipe file2-or-nul  [file1/pipe-capture1-regex]  [file2-capture1-regex]  [switches like: -i -u -m]
All [xxx-xxx] in above usage are Optional , can be omitted;
If set [xxx-capture1-regex], Must have regex capture group[1] : Simple example like "^(.+)$" or Example-1
If only set [file1/pipe1-capture1-regex] then  [file2-capture1-regex] will use the same.
If both of them not set, will use normal whole line text comparison: check lines in file1/pipe1 which not-in/in file2.
Example-1: nin daily-sample.txt  selected-queries.txt   "^([^\t]+)"  "query = (.+)$"   -u -i
Example-2: nin daily-sample.txt nul -u -p
Example-3: type daily-sample.txt | nin nul -up
Example-1 uses regex capture1 to get new queries: only in daily-sample.txt but not in later file. (if use -m will get intersection set of the 2 files)
Example-2/3 are same : get unique(-u) lines in file and show each percentage(-p) with order.
Any good ideas please to : QQ : 94394344 , aperiodic updates and docs on https://github.com/qualiu/lzmw
Call@Anywhere: add to PATH with parent directory: D:\lztool or temporally : SET PATH=%PATH%;D:\lztool
