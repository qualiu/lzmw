Liberate & Digitize daily works by 2 exe: File Processing, Data Mining, Map-Reduce.
https://github.com/qualiu/lzmw/

Match/Search/Replace: lzmw.exe / lzmw.cygwin / lzmw.gcc** / lzmw*.darwin
    Match/Search/Replace Lines/Blocks in Files/Pipe
    Filter/Load/Extract/Transform/Stats/*** Lines/Blocks in Files/Pipe.
    Execute** transformed/replaced result lines as command lines.
    
Not-In-latter: nin.exe / nin.cygwin / nin.gcc** / nin*.darwin
    Get `Unique` or `Raw` Exclusive/Mutual Line-Set or Key-Set.
    Stats + Get Distribution in Files/Pipe.
    Remove(Skip) Line-Set or Key-Set matched in latter file/pipe.
    
For example, running lzmw and nin on Windows:

# nin.exe -------------------------------------------------
Get difference-set(not-in-latter) for first file/pipe; Or intersection-set with latter file/pipe. by LQM:
  -u [ --unique ]              Get unique results, discard self/mutual duplicate lines/keys (key = captured groups[1] if set 1~2 Regex patterns).
  -m [ --intersection ]        Get mutual lines/keys intersection in 2 files or file-with-pipe (default is exclusive: 'not-in-latter').
  -i [ --ignore-case ]         Ignore case for plain text matching and Regex matching.
  -n [ --out-not-captured ]    Also output not-captured keys/lines of Regex pattern in first file/pipe.
  -p [ --percentage ]          Output percentages of keys/lines at each line head, and sort by percentages.
  -w [ --out-whole-line ]      Output matched lines other than keys (key = captured groups[1] of Regex pattern).
  -a [ --ascending ]           Ascending sort output by lines or captured-keys or percentages.
  -d [ --descending ]          Descending sort output by lines or captured-keys or percentages.
  -k [ --stop-at-count ] arg   Stop if the matched count of a key/line > [N] when ascending output, or if count < [N] when descending output.
  -K [ --stop-percentage ] arg Stop if the percentage of a key/line > [P%] when ascending output, or if percentage < [P%] when descending output.
  -A [ --no-any-info ]         Not output any info, no warnings no summary (if no errors), only pure result (Please always use -PAC or -PC).
  -I [ --info-normal-out ]     Output summary info to stdout (default is to stderr).
  -M [ --no-summary ]          Not output summary info.
  -O [ --out-not-0-sum ]       Output summary only if the results count is not 0.
  -C [ --no-color ]            No color for output (it's better to not add color if have subsequent matching or processing).
  --colors arg                 Set fore_back colors for -t/-e/-x;d/f/p;m/u like: 'Red' or 't=Red,x=Yellow,e=Green' or 't = red + Yellow_Blue, x = Cyan'.
  --keep-color                 Keep color of output result for Windows/MinGW - to be uniform color style with Cygwin/Linux/MacOS.
  --unix-slash arg             Set 1 to output uniform forward slash '/' on Windows + MinGW + Cygwin, like 'c:/' instead of '/c/' or '/cygdrive/c/'.
  --to-stderr                  Output result to stderr. Default: result -> stdout, error/warn/info/verbose -> stderr.
  -P [ --no-percent ]          Not output percentages (Overwrite --percentage).
  --sum                        Sum accumulative counts and percentages(if used -p) for each key/line.
  --not-warn-bom               Not output BOM warnings when reading BOM files which BOM header bytes != 0xEFBBBF.
  -H [ --head ] arg            Output top [N] rows of whole output if N > 0; Skip top [N] lines if N < 0; [N] = 0 means not output.
  -T [ --tail ] arg            Output bottom [N] rows of whole output if N > 0; Skip bottom [N] lines if N < 0; [N] = 0 means not output.
  -J [ --jump-out ]            Jump out (stop and exit) if has set -H [N] and already has output [N] lines.
  --timeout arg                Maximum waiting seconds to stop and exit. No limit if value <= 0. Default = 0.000 s.
  -S [ --switch-first ]        Switch positions (first/latter roles) of 2 files or file/pipe (also will switch their Regex patterns).
  -Z [ --skip-last-empty ]     Skip last empty line in first/latter file.
  -x [ --has-text ] arg        Line must contain this normal/plain text (Can use meanwhile: -t, -x, --nt, --nx).
  --nx arg                     Line must not contain normal/plain text: Exclude/Skip rows.
  -t [ --text-match ] arg      Regex pattern for line text must match (Can use meanwhile: -t, -x, --nt, --nx). Use -t value to filter even if used -e.
  --nt arg                     Regex pattern for lines must not match: Exclude/Skip rows.
  -e [ --enhance ] arg         Regex pattern to color output, inferior to: -t -x. Use merged Regex value of "(-t)|-e" to enhance if used both -t and -e.
  -Y [ --not-from-pipe ]       Force reading from files other than pipe (to avoid reading pipe if running in another command).
  -c [ --show-command ]        Show command line, you can append text for debug, or extraction after -c (if append text, -c and text must be last).
  --exit arg                   Change return value, format: [Number] or [Regex-or-Math]-to-[Exit-Code], like: '1' or '-?\d+-to-1' or 'lt0-to-1,255-to-1'.
  --verbose                    Show parsed arguments, return value, time zone, BOM rows and EXE path, etc.
  -h [ --help ]                See usage and examples below. More detail: https://github.com/qualiu/msr

Usage: nin  File1-or-pipe  File2-or-nul  [Regex-capture1-pattern-1]  [Regex-capture1-pattern-2]  [Options like: -i -u -m -w -H 2 -t xxx --nt xxx]
All [Quoted Args Options] above are Optional, can be omitted.
If has set [Regex-capture1-pattern-N], Must have Regex capture group[1]: Simple examples like: "^(.+)$" or "(.+)" or "^(\S+)" or "^([^\t]+)" or "^(\w+)" etc. 
If only set [Regex-capture1-pattern-1] then [Regex-capture1-pattern-2] will use the same.
If both of them not set, will use normal whole line text comparison: check lines in file1/pipe which not-in/in file2.
Example-1: D:\lztool\nin.exe daily-sample.txt  selected-queries.txt   "^([^\t]+)"  "query = (.+)$"   -u -i
Example-2: nin daily-sample.txt nul -p -i
Example-3: type daily-sample.txt | nin nul -pi
Example-1 uses regex capture1 to get new queries: only in daily-sample.txt but not in the latter file (if use -m will get intersection set of the 2 files).
Example-2/3 are same: get unique(-u) lines in file and show each percentage(-p) with order.

Return value/Exit code(%ERRORLEVEL%) = matched line/key count in {first file/pipe} or {mutual intersection}.
But if return value = 0 and caught errors, will exit with return value = -1 (probably 255 on Linux/MacOS or 127 on MinGW which changed by shells like bash).
All error messages will be output to stderr. You can redirect them to stdout by appending 2>&1 to your command line.

Useful options: -H 20 -J, -H 0, -T 3, -k 30, -K 33.33, -T -1, -M, -S, -PAC, -i -u, -iuw, -iuwa, -ip, -ipa, -ipdw, -ium, iumw, -iwn, -im, -imw, -ipdPAC
-m -u : Get unique mutual intersection.
-p -d : Get top distributions/percentages and sort by count/percentages with descending order.
-w -n : Skip lines/keys both matched in latter + first files/pipe, output other keys' lines + non-matched lines (like description/comments) in first.

nin treats Windows nul as same as /dev/null on MinGW / Cygwin / Linux / MacOS.
One important feature: nin does not change the original line order even if used unique(-u) if no sorting of -p/-d/-a/etc.

Frequent use cases as Quick-Start: Use -PAC or -PC to get pure output result.
nin my.txt nul -u -i :     output unique lines in my.txt ignore case.
type my.txt | nin nul -ui : output unique lines in my.txt ignore case.
nin my.txt nul "^(\w+)" -u -i :  output unique keys (captured words at each line begin) in my.txt ignore case.
nin my.txt nul "^(\w+)" -u -wi : output unique lines (lines of the captured keys) in my.txt ignore case.
nin my.txt other.txt "(my-capture1)" "(other-capture1)" -u :    output captured keys in my.txt not in other.txt.
nin my.txt other.txt "(my-capture1)" "(other-capture1)" -u -S : output captured keys in other.txt not in my.txt.
nin my.txt other.txt "(my-capture1)" "(other-capture1)" -u -m : output mutual keys in other.txt and my.txt.
nin error.log nul "(\w*Exception)" -pd -H 30 : Get error categories, distribution and percentage, output top 30 errors.
nin error.log nul "(\w*Exception)" -pd -H 30 -I > report.txt : Save top 30 errors + summary info to report.txt.
nin error.log nul "(\w*Exception)" -pd -H 30 -PAC : Get top 30 errors of raw text without percentages and summary info.
nin my-config.ini exclude.csv "name = (\w+Exception)" "(\w+Exception)" -iwn > new-config.ini : Output whole lines in my-config.ini except lines also captured in exclude.csv.
nin -h -C | nin nul "^\s{2}(-+\S+)\s+" -w --nt help : Get all command options of nin and output with original order.
nin -h -C | nin nul "^\s{2}-(\w)\s+" -wa --nt help : Get all single letter command options of nin and output with ascending order.
nin -h -C | nin nul "^\s{2}-(\w)\s+" -wpdi : Get percentages of nin single letter command options.
nin -h -C | nin nul "^\s{2}-(\w)\s+" -wpdi -k 2 : Get percentages of nin single letter command options which matched count >= 2.
nin -h -C | nin nul "^\s{2}-(\w)\s+" -wpdi -K 5.0 : Get percentages of nin single letter command options which percentage >= 5%.
nin -h -C | nin nul "^\s{2}-(\w)\s+" -wpdi -k 2 -K 5.0 -P : Get percentages of nin single letter command options: count >= 2 and percentage >= 5% without percentage info.

One limitation: Cannot process Unicode files or pipe for now; Fine with UTF-8/ANSI/etc.
Search usage like: nin -h | msr -i -t return.+value  or  nin -hC | msr -it "Summary|Jump|Sort" -x out -U 2 -D2  or  nin | msr -ix switch -t Regex -e "latter|first" 
You can preset env: MSR_EXIT, MSR_OUT_INDEX, MSR_NO_COLOR, MSR_COLORS, MSR_OUT_FULL_PATH, MSR_NOT_WARN_BOM, MSR_SKIP_LAST_EMPTY, MSR_KEEP_COLOR, MSR_UNIX_SLASH for --unix-slash / --keep-color / etc.

With msr.exe more powerful to load files/read pipe, extract/transform, pre/post-processing: https://github.com/qualiu/msr
Example: Get insensitive unique paths + descending sort-by-percentage to show top 2 duplicate paths + Merge trimmed one line paths to new %PATH%:
    msr -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u 
    msr -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u -d -p -k 2
    msr -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u -PAC | msr -S -t "[\r\n]+(\S+)" -o ";\1" -aPAC 

As a portable cross platform tool, nin has been running on: Windows / MinGW / Cygwin / Ubuntu / CentOS / Fedora / Darwin / FreeBSD
Aperiodic updates: https://github.com/qualiu/msr , more tools: https://github.com/qualiu/msrTools + https://github.com/qualiu/msrUI + https://github.com/qualiu/vscode-msr
Call@Everywhere: Add nin.exe to system environment variable PATH with nin.exe directory like: D:\lztool
	 or temporarily: SET "PATH=%PATH%;D:\lztool"
	 or rudely but simple and permanent: copy D:\lztool\nin.exe C:\WINDOWS\



# lzmw.exe -------------------------------------------------
Match/Search/Replace String/Lines/Blocks in Command/Files/Pipe. (IGNORE case of file and directory name) by LQM:
  -r [ --recursive ]          Recursively search files in descendant directories.
  -k [ --max-depth ] arg      Maximum depth to search directories (begin depth = 1 from/for each input path). Default maximum depth = 33.
  --timeout arg               Maximum waiting seconds to stop and exit. No limit if value <= 0. Default = 0.000 s.
  -p [ --path ] arg           Source paths (directories or files) to find/read: Use ',' or ';' to separate paths; Extra separator ':' for Linux.
  -w [ --read-paths ] arg     Input files list to read 1+ lines of source paths(like -p): Use ',' or ';' to separate; Extra separator ':' for Linux.
  --no-check                  Not check/fix source paths. Case like reading(-w) source paths list file from 'git ls-files'.
  -Z [ --skip-last-empty ]    Skip last empty line in each file.
  -f [ --file-match ] arg     Regex pattern: File name with extension must match this.
  -t [ --text-match ] arg     Regex pattern: Line text must match (Can use meanwhile: -t, -x, --nt, --nx, -e).
  -x [ --has-text ] arg       Plain text: Lines must contain this text (Can use meanwhile: -t, -x, --nt, --nx, -e).
  --nx arg                    Exclude/Skip rows by plain text: Line text must not include this text.
  --nt arg                    Regex pattern: Exclude/Skip rows if line matches this regex.
  --nf arg                    Regex pattern: Exclude/Skip files by file name (including extension).
  --pp arg                    Regex pattern: Must match this regex for full path of files. Support '/' on Windows.
  --np arg                    Regex pattern: Exclude/Skip files if full path matches this. Support '/' on Windows.
  --nd arg                    Regex pattern: Exclude/Skip directories if find 1 sub-folder-name matches (skip inner files too).
  -d [ --dir-has ] arg        Regex pattern: Must has 1+ sub-folder-name of a directory matches this (skip inner files if not).
  --xp arg                    Plain text list: Exclude/Skip files if has 1+ text in file path. Use ',' or ';' to separate. Support '/' on Windows.
  --sp arg                    Plain text list: Must find all texts in file path. Use ',' or ';' to separate. Support '/' on Windows.
  --xd                        Exclude/Skip link directories/folders (skip inner files too).
  --xf                        Exclude/Skip link files.
  -G [ --read-once ]          Read once for link files (link folders must be or under input paths) which multiple paths link to one real path.
  -i [ --ignore-case ]        Ignore case of matching/replacing for -t/-x/-e . You can add to one of them like: -it/-ix/-ie .
  -e [ --enhance ] arg        Regex pattern to color output, inferior to: -t -x -o (skip -e if matched by them for a text).
  -o [ --replace-to ] arg     Replace text from -x/-t XXX to -o XXX. If used both -x and -t: Use the closer one to '-o'; Or the left one if same.
  -j [ --out-replaced ]       Just output replaced lines by -o xxx (just show changed files + lines which is helpful to preview changes).
  -a [ --out-all ]            Output all lines including not matched; Or each whole block range if used -b and -Q.
  -W [ --out-full-path ]      Output full paths if input relative paths by -p or -w. This can avoid duplicates and trim extra slashes and dots.
  -A [ --no-any-info ]        Not output any info, no warnings no summary (if no errors), only pure result (Please always use -PAC or -PIC).
  -I [ --no-extra ]           Not output extra info + warnings(like BOM); Hide each return info for -X; Output summary to stderr(for debug: -aPICc, -PICc).
  -P [ --no-path-line ]       Not output path and line number at the head of each line. If used -X: Not show each command line before executing.
  -M [ --no-summary ]         Not output summary info (at end). Use -A to hide when got errors. Use --not-warn-bom to hide summary for BOM.
  -O [ --out-if-did ]         Output summary only if matched/replaced/found file/text; or execution(-X) return value = non-zero or unexpected(-V).
  -C [ --no-color ]           No color for output (it's better to not add color if have subsequent matching or processing).
  --colors arg                Set fore_back colors for -t/-e/-x;d/f/p;m/u like: 'Red' or 't=Red,x=Yellow,e=Green' or 't = red + Yellow_Blue, x = Cyan'.
  --keep-color                Keep color of output result for Windows/MinGW - to be uniform color style with Cygwin/Linux/MacOS.
  --unix-slash arg            Set 1 to output uniform forward slash '/' on Windows + MinGW + Cygwin, like 'c:/' instead of '/c/' or '/cygdrive/c/'.
  --to-stderr                 Output result to stderr. Default: result -> stdout, error/warn/info/verbose -> stderr.
  -F [ --time-format ] arg    Regex pattern to grep time/key for -B and -E : Use captured group[0] or [1] like: "(\d{4}-\d+-\d+\D\d+:\d+:\d+([\.,]\d+)?)"
  -B [ --time-begin ] arg     Begin time/key as value of -F, like "2023-09-19 11:00:00". Just text comparison NOT by time value.
  -E [ --time-end ] arg       End time/key as value of -F, like 2023-09-19T15:30. Just text comparison NOT by time value.
  -s [ --sort-by ] arg        Regex pattern to sort result lines by captured group[1] if has, else by group[0]. If set to "" will try groups from -t .
  -n [ --sort-as-number ]     If has used -s : Convert the captured group[1] (if has, else group[0]) of -s to number or decimal at first then sort by -s .
  --dsc                       Descending order for sorting of matching (-t/-x), list(-l with --wt --sz), sorting-key (-s), time (-F with -B -E), etc.
  -l [ --list-count ]         Only output matched file path list or matched count.
  --wt                        Sort file list by last write time (with -l). If used both --wt and --sz, order by prior then by latter.
  --w1 arg                    File time begin, file or time or ago(d/h/m/s): 'add_1s_if_no_w2.md' or '2023-09-19T18:30' or '3h'='-3h' = 'now - 3hours'.
  --w2 arg                    File time end, file or time or ago(d/h/m/s): 'range2.exe' or '18:30:01' or '1d'='+1d' = 'begin + 1day', 'now-1d' = 'now - 1day'.
  --sz                        Sort file list by file size (with -l) and display with a unit like: B,KB,MB,GB,TB,PB,EB etc.
  --s1 arg                    Lower bound of file size, format like 100kb (No space between number and unit, use B if no unit).
  --s2 arg                    Upper bound of file size, format like 2.5M (No space between number and unit, use B if no unit).
  -R [ --replace-file ]       Replace files, search text by -x/-t XXX , replace to -o XXX. Without this, just preview replacing.
  -K [ --backup ]             Backup files if replaced files content (Rename them by appending last write times like: --bak-2023-09-19__00_41_22).
  --force                     Force replacing BOM files. Default: only replace files of ANSI + UTF-8 no BOM + BOM header bytes = 0xEFBBBF.
  --not-warn-bom              Not output BOM warnings when reading BOM files which BOM header bytes != 0xEFBBBF.
  -S [ --single-line ]        Single line Regex mode to match/replace (Treat as one line for each file/pipe/block).
  -g [ --replace-times ] arg  Maximum times to replace a line text with --replace-to. Use a big number or -1 to replace radically. Default = 1.
  -U [ --up ] arg             Output [N] rows above the matched line by -t or/and found by -x.
  -D [ --down ] arg           Output [N] rows below the matched line by -t or/and found by -x.
  -H [ --head ] arg           Output top [N] rows of whole output if [N] > 0; Skip top [N] lines if [N] < 0; [N] = 0 will not output result rows.
  -T [ --tail ] arg           Output bottom [N] rows of whole output if [N] > 0; Skip bottom [N] lines if [N] < 0; [N] = 0 will not output result rows.
  -J [ --jump-out ]           Jump out (stop and exit) if has set -H [N] and already output [N] lines.
  -L [ --row-begin ] arg      Begin row number of reading/matching/replacing each file or pipe.
  -N [ --row-end ] arg        End row number. If input 0, end-row = 'begin-row'; If input '+[N]', end-row = 'begin-row + [N]'.
  -b [ --start-block ] arg    Regex pattern of begin matching (skip lines above in files/pipe); If has -Q this will be the begin pattern for each block.
  -q [ --stop-at-once ] arg   Regex pattern to stop reading/matching/replacing each file or pipe.
  -Q [ --stop-block ] arg     Regex pattern of a block end (must have set -b); Can set to "" if same with -b. Add -y if reuse it as next block begin.
  -y [ --reuse-block-end ]    Reuse -Q (a matched block end) as -b (next block begin): For cases of blocks can only be separated from beginning(-b).
  --block arg                 Output specific matched blocks by block numbers(start from 1 of output), like: 1 or 1,2,3 or 1~3.
  --sep-block arg             Output [N] empty lines between blocks as a separator. [N] = empty line count.
  -X [ --execute-out-lines ]  Execute each final output line as a command. Will show command -> run -> show return value, if no: -P -I -A.
  -V [ --stop-execute ] arg   Quit if an executed command return value matches Regex(like: "-\d+") or Math(like: ">=0", ge0, "!=0", ne0, eq-1, lt0, gt0).
  -Y [ --not-from-pipe ]      Force reading from files other than pipe (to avoid reading pipe if running in another command and no reading paths set).
  -z [ --string ] arg         Input a string and read from it (without reading files or pipe). You can also use it to learn/test Regex, or test input args.
  --out-index                 Output index(column) of first match for each row text. If no -P, output will be: File-Path:{row}:{column}: {line-text}
  -m [ --show-count ]         Show matched count at the head of each output line.
  -u [ --show-elapse ]        Show used time (in seconds) at the head of each output line.
  -v [ --show-time ] arg      Show time at each output line head: dt,dtm,dto (s = second, m = millisecond, o = microsecond; d = date, z = zone, t = offset).
  -c [ --show-command ]       Show command line and info. You can append text after -c for debug(like: -I -c xxx) for further extraction.
  --exit arg                  Change return value, format: [Number] or [Regex-or-Math]-to-[Exit-Code], like: '1' or '-?\d+-to-1' or 'lt0-to-1,255-to-1'.
  --verbose                   Show parsed arguments, return value, time zone and EXE path, content error rows, BOM info, link files' real paths, etc.
  -h [ --help ]               See usage and examples below. More detail: https://github.com/qualiu/lzmw

Return value/Exit code(%ERRORLEVEL%) = matched/replaced count of lines/blocks/files in files or pipe.
But if return value = 0 and caught errors, will exit with return value = -1 (probably 255 on Linux/MacOS or 127 on MinGW which changed by shells like bash).
If used -X(--execute-out-lines): Return value = matched-stop-count if has -V else non-zero-return-count or the only one command line return value.
All error messages will be output to stderr. You can redirect them to stdout by appending 2>&1 to your command line.

Detail instruction and examples(Quick-Start at the bottom is briefer):

(1) Skip/Stop reading + Arbitrary block matching: Helpful to read/extract pipe or large files or extract/replace XML/Json/INI files etc.
    -L/-N: set row ranges by line number of begin/end for each file or reading a pipe;
    -b/-q: set row ranges by Regex pattern of begin/end for each file or reading a pipe; 
    -b/-Q: set begin/end Regex patterns to match multiple arbitrary blocks. Use -a to output all rows of each block including its rows not matched by -t or -x.
    -L/-b and -N/-Q/-q can all be used at same time, contains the boundary which are begin and end lines.
    -q/-N stops immediately for each file or reading a pipe. 
    Special meaning of --nt/--nx for block matching(-b + -Q): --nt and --nx exclude a block if one of its lines matches one of the Regex.
    Special meaning of -S for block matching: -S only has 'single line mode' meaning for each block, other than whole text in each file or pipe.
    -B and -E only textually/literally compare with time text matched by -F XXX , not parse the text of -B and -E to time then compare.
    If replacing files, -R (--replace-file) will replace matched text + just copy the lines out of -L/-b and -N/-Q/-q.
    -R will not change files if no lines replaced; Preview replacing result without -R; Recommend using -j to just preview changes before using -R.
    -K(--backup) to backup files if changed, append modify-time (--yyyy-MM-dd__HH_mm_ss) to backup file name. If exists, will append '-N' and N start from 1.

(2) Replace text, transform output, color scripts:
    If used both -t (--text-match) and -x (--has-text), will use the closer one to -o (--replace-to) as search target, the other as search condition; 
    But if -t and -x distances to -o are same, replace by the prior/left one. Example: -t XXX -o XXX -x XXX : will use -t as same distance.
    Use -e to extra color output like:
    lzmw -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | lzmw -aPA -i -t "\w*bin" -x \ -e "[a-z]+|(\d+)"

(3) Replace files with -R (-t / -x / -o usage see above):
    -T 0 to hide final replaced file info list: count + path. Often use -R -M -T 0 to show brief info when replacing files.
    -H 0 to hide each immediate replaced file info: time + count + path.
    lzmw will not add or remove an empty line to tail when replacing files.
    lzmw will not change/touch/write files for content or file time if found nothing replaced.
    lzmw will read/count/show the tail empty line exactly as the fact.

(4) Sort output or file list by time or size: (sort result by time/key see usage and bottom examples)
    Both --sz and --wt only work with -l (--list-count) to display and sort by file size and last-write-time;
    sort by the prior/left one (in command line position) if used both of them.
    -s(--sort-by) will sort output by captured regex group[1], if no group[1] will try group[0] of -F(--time-format) at first, then try -t(--text-match) (if found).
    If input empty regex pattern "" for -s, then -s will sort by the pattern of -F(--time-format) if found; else check and use the pattern of -t(--text-match) to sort.

(5) Execute each output line as a command: If has -X (--execute-out-lines): 
    echo Complex symbols command contains 2 types of quotes + slashes, hard to quote. | lzmw -X -M || exit /b -1
    lzmw -XM -z "Simple command, or you want to keep quotes and other chars." || exit /b -1
    -P(--no-path-line) will not output lines(commands) before executing;
    -I(--no-extra) will not output each execution summary;  -O(--out-if-did) will not output execution summary if return value = 0.
    -A(--no-any-info) will not output any info or summary, and new lines (which separates executions).
    -V(--stop-execute) set Regex or Math to stop execution (-X) if a command return value matches it (exit code will be that). Like: -V "-?[1-9]" or -V ne0 or -V lt0 or -V "<0"
    The value of -V(--stop-execute) will be treated as Regex if not match Math by test: lzmw -t "^\s*(gt|>|lt|<|eq|=|ge|>=|le|<=|ne|!=)\s*(-?\d+)\s*$" -z "input value"
    -Y(--not-from-pipe) to force reading from files other than pipe. -Y is rarely used, only for cases which lzmw cannot know where to read from: files or pipe. 
    For example, you can remove the -p . and -Y below, then run it, you will see that using -Y can avoid reading pipe:
    echo for /F "tokens=*" %a in ('lzmw -l -p . -H 3 -PICc -Y') do lzmw -Y -l -c --wt --sz -p %a | lzmw -X

(6) Further extraction by summary:
    Use -c (--show-command), you can append any text to the command line.
    Use -O to output summary only if matched/replaced/found file/text; or one execution(-X) return non-zero or unexpected(-V).
    Use -H 0 or -T 0 if you just want summary info, without other outputs.
    Use -J to jump out: Quit(exit) if has set -H [N] and output line count exceeds [N].

(7) Map <--> Reduce: -o transforms one line to multi-lines; -S changes -t to single-line Regex mode.
    lzmw -p my.log -t "host-list=([\d\.]+),(\d\.]+),([^,]+)" -o "${1}\n$2\n$3" -P -A -C | lzmw -S -t "(\d+\.[\d\.]{4,})[\r\n]*" -o "$1," -PAC | lzmw ... | lzmw ...
    ipconfig | lzmw -t "^.*?(\d+\.[\d\.]{4,}).*$" -o "$1" -PAC | lzmw -S -t "\s+(\S+)" -o "|$1" -PAC

(8) Quick lookup usage by self: Also helpful to look up system/other tool usages with brief context (Up/Down lines)
    lzmw | lzmw -i -t sort -U 3 -D 3 -e time
    robocopy /? | lzmw -it mirror -U 3 -D 3 -e purge

Additional feature: Directly read and match text by -z (--string instead of using echo command on Windows which must escape | to ^| in for-loop)
    Example: Finding non-exist paths in %PATH% and only check 3 head(top) + 3 tail(bottom) paths:
    lzmw -z "%PATH%;" -t "\s*;\s*" -o "\n" -PAC | lzmw -t .+ -o "if not exist \"$0\" echo NOT EXIST $0"  -PI -H 3 -T 3 -X

Example-1: Recursively find text by Regex in files, ignore case, dive in 9 layers at max, only list files + count:
    D:\lztool\lzmw.exe --recursive --path "%APPDATA%, %TMP%" --file-match "\.(bat|cmd)$" --text-match "^\s*set\s+(\w+)=(.+)" --ignore-case --max-depth 9 --list-count

Example-2: Find error in log files: row text (contain time) start matching(-t xxx) from -B xxx with given format(-F xxx); last-write-time between [--w1,--w2]
    lzmw -rp /var/log/,/tmp/log/ -f "\.log$" -F "^(\d{4}-\d+-\d+\D\d+:\d+:\d+([\.,]\d+)?)" -B "2013-03-12 14" -i -t "\b(error|fail|fatal|exception)"  --w1 2013-03-12 --w2 "2013-03-13 09"

Example-3: Recursively(-r) replace-file(-R) : IP tail in <SQL> or <Connection>; Only in xxx-test directory skip Prod-xxx; Skip rows>=200 for each file; Backup(-K) if changed.
    lzmw -rp  .  -f "\.xml$" -d "\w+-test$" --nd "Prod-\w+" -b "^\s*<SQL|Connection>" -Q "^\s*</(SQL|Connection)>" -N 200 -it "(\d{1,3})\.(\d{1,3})\.\d{1,3}\.\d{1,3}" -o "${1}.$2.192.203" -RK 

Example-4: Read Pipe like: type query.txt | lzmw -t words -PAC 2>nul | lzmw -PIC -xxx ...
    ipconfig | lzmw -t "^.*?(\d+\.[\d\.]{4,}).*$"  -o "${1}" -PAC

Example-5: Single-line regex mode replacing whole text in each file and backup (preview without -R)
    lzmw -rp "%CD%" -f "config\w*\.(xml|ini)$" -S -t "(<Command>).*?(</Command>)" -o "$1 new-content ${2}" -RK 

Example-6: Multi-line regex mode (normal mode) replacing lines in each file and backup (preview without -R)
    lzmw -rp myApp\bin,myApp\scripts,D:\myApp\tools -f "\.(bat|cmd)$"  -it "^(\s*@?\s*echo)\s+off\b" -o "$1 on" -R -K 

Example-7: Display current modified code files:
    for /f %a in ('lzmw -l -f "\.(cs|java|cpp|cx*|hp*|py|scala)$" -rp "%CD%" --nd "^(debug|release)$"  --w1 "2021-11-21 09:51:03" -PAC 2^>nul ') do @echo code file: %a

Example-8: Get 2 oldest and newest mp3 (4 files) which 3.0MB<=size<=9.9MB and show size unit, in current directory (Can omit -p . or -p %CD%)
    lzmw -l --wt -H 2 -T 2 -f "\.mp3$" --sz --s1 3.0MB --s2 9.9m

Example-9: Get precise time of now and set to %TimeNow-XXX% variable for latter commands: Now time = 2021-11-21 09:51:03.314459 +0800 CST = China Standard Time
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2" -PAC') do SET "TimeNowInSecond=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3" -PAC') do SET "TimeNowMillisecond=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3\4" -PAC') do SET "TimeNowMicrosecond=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2 \5" -PAC') do SET "TimeNowOffset=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3 \5" -PAC') do SET "TimeNowMilliOffset=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3\4 \5" -PAC') do SET "TimeNowMicroOffset=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2 \6" -PAC') do SET "TimeNowZone=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3 \6" -PAC') do SET "TimeNowMilliZone=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1 \2.\3\4 \6" -PAC') do SET "TimeNowMicroZone=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowForFileName=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2.\3" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowMilliForFileName=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2.\3\4" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowMicroForFileName=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2_\6" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowZoneForFileName=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2.\3_\6" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowZoneMilliForFileName=%a"
    for /f "tokens=*" %a in ('lzmw -hC ^| lzmw -t ".*Now time = (\d+\S+) (\d+[:\d]+)\.(\d{3})(\d*)\s+([-\+]\d+)?\s*(\w+)?.*" -o "\1__\2.\3\4_\6" -PAC ^| lzmw -t ":" -o _ -aPAC') do SET "TimeNowZoneMicroForFileName=%a"

Example-10: Find files in %PATH% environment variable: such as ATL*.dll, 2 methods:
    for /f "tokens=*" %d in ('lzmw -z "%PATH%;" -t "([^;]+);*" -o "$1\n" -PAC ^| lzmw -t "\\\s*$" -o "" -aPAC') do @lzmw -l --wt --sz -p "%d" -f "^ATL.*\.dll$" -O 2>nul
    lzmw -l --wt --sz -p "%PATH%;" -f "^ATL.*\.dll$" -M 2>nul

All options/switches are optional + no order + effective meanwhile, but case sensitive.
Can merge single char switches/options+values like: -rp -it -ix -PIC -PAC -POC -PIOCcl -PICc -PICcl , -mu -v zod, -muvzod, -uvz
Useful options: -a, -H 3, -H 3 -J, -H 0, -T 3, -T -1, -M, -O, -PAC, -PIC, -POC, -POlCc, -XI, -XIP, -XA, -XO, -XOPI, -muvz, 2>&1, 2>nul (2^>nul in pipe)
Like watching time/elapsed/matched (-muvzd): lzmw | lzmw -it show -v zdo -u -m

Helpful commands - Just 1 command line: Preview replacing just remove -R
(1) Remove whitespace at each line tail in each file in directories:
    lzmw -r -p dir-1,dir2,file1,file2 -f "\.(cpp|cxx|hp*|cs|java|scala|py)$" -t "\s+$" -o ""  -R
(2) Replace each tab(\t) to 4 spaces at each line begin in files: (Recursive/Radically change all head tabs in a line by -g -1)
    lzmw -rp path1,path2 -f "\.(cp*|cxx|hp*|cs|java|scala|py)$" -t "^(\s*)\t" -o "$1    " -g -1 -R
(3) Find top 100 largest old garbage log files which size >= 30MB:
    lzmw -rp path1,path2 -f "\.(log)$" -l --sz --s1 30MB --w2 "2015-07-27 12:30:00" -H 100 --dsc -PIC
(4) Get command lines to delete top 100 largest old garbage log files which size >= 30MB:
    lzmw -rp path1,path2 -f "\.(log)$" -l --sz --s1 30MB --w2  2015-07-27T12:30 -H 100 --dsc -PAC | lzmw -t .+ -o "del /f /q /s \"$0\"" -PIC
(5) Delete top 100 largest old garbage log files which size >= 30MB and stop deletion (stop executing command lines) if a command return value < 0:
    lzmw -rp path1,path2 -f "\.(log)$" -l --sz --s1 30M --w2 "2015-07-27 12:30" -T 100 -PAC | lzmw -t "(.+)" -o "del /f /q /s \"\1\"" -X -V "<0"
(6) Delete top 100 largest old garbage log files which size >= 30MB and stop deletion (stop executing command lines) if a command return value < 0:
    lzmw -rp path1,path2 -f "\.(log)$" -l --sz --s1 30m --w2 "2015-07-27T12:30" -PAC | lzmw -T 100 -t "(.+)" -o "del /f /q /s \"\1\"" -X -V lt0
(7) Check tail new lines: Return/Exit code %ERRORLEVEL% > 0 if has a new line:
    lzmw -p my-file -S -t "[\r\n]+$" -H 0 -PIC
(8) Replace files: Set only one new line at tail (Add an empty new line or remove redundant empty lines. Trim tail whitespace):
    lzmw -rp path1,path2 -f "\.(cpp|cxx|hp*|cs|java|scala|py)$" -S -t "(\S+)\s*$" -o "$1\n" -R
(A) Remove tail new lines and whitespace in pipe result:
    lzmw --help -C | lzmw -S -t "\s*$" -o "" -aPIC
(B) Replace batch files on Windows: Turn on all ECHO/echo to debug scripts and skip junk folders when searching files:
    lzmw -rp path1,path2 -f "\.(bat|cmd)$" -it "^(\s*@?\s*echo)\s+off\b" -o "\1 on" -R --nd "^([\.\$]|(Release|Debug|objd?|bin|node_modules|static|dist|target|(Js)?Packages|\w+-packages?)$|__pycache__)"
(C) Show commands -> Execute -> Show return info no summary: echo No results+errors if return = 0; If return != 0: echo Found N results or Caught errors for -1.
    echo lzmw -p "%PATH%;" -f "\.(bat|cmd|sh)$" -t "^\s*(SET|export)\s+(\w+)=(.+)" -ix HOME -H 5 | lzmw -X -M && echo No results found + No errors.
    echo lzmw -p "%PATH%;" -f "\.(bat|cmd|sh)$" -t "^\s*(SET|export)\s+(\w+)=(.+)" -ix HOME -H 5 | lzmw -X -M || echo Found %ERRORLEVEL% results or Got errors + No result if return -1.

Frequent use cases as Quick-Start: Use -PAC or -PIC to get pure output result like other tools: findstr/grep/egrep/etc.
(1) Search files by normal text finding: lzmw -rp folder1,fileN -x "my plain text" -P -I -C -i -c ignore case and show this command line.
(2) Search files by general Regex match: lzmw -rp folder1,fileN -t ".*(capture-1).+Regex" -aPAC out all including not matched, not show this command line.
(3) Search files + Replace output lines: lzmw -rp folder1,fileN -t ".*(capture-1).+Regex" -o "group \1 is same with $1 except Linux double quotes" -j just preview changes.
(4) Replace files and Backup if changed: lzmw -rp folder1,fileN -t ".*(capture-1).+Regex" -o "group \1 is safer than $1" -R -K replace files after preview.
(5) Extract or replace arbitrary blocks: lzmw -rp folder1,fileN -t ".*(capture-1).+Regex" -o "transform \1" -b "block-begin-regex" -Q "block-end" -f "\.(xml|ini|conf)$"
(6) Get matched file list + distribution: lzmw -rp folder1,fileN -t ".*(capture-1).+Regex" -l
(7) Execute top 9 output lines(commands): lzmw -l -f "\.(pdb|obj)$" -rp . -PAC | lzmw -t "(.+)" -o "del \"\1\"" -H 9 -X -V ne0  Stop if a command return value != 0.
(8) Radically replace + only out changed: lzmw -z "Same with replacing files or pipe" -t "^(\w+)\s+" -o "$1_" -g -1 -j
(9) Extract key + Sort as number + Stats: lzmw -rp folder1,fileN -it "Key\s*=\s*(-?\d+\S*)"  -n -s ""  -c Set pattern for -s if different to -t or as you want.
(A) Match an input string or Learn Regex: lzmw -z "LostArg%~1" -t "^LostArg(|-h|--help|/\?)$" > nul || echo goto show usage as no input args or input 'help' to script.
(B) Search in pipe, Skip Head 3 + Tail 2: type my.txt | lzmw -it Regex-pattern -x and-plain-text -H -3 -T -2 -PIC
(C) Replace with Many filters + Jump out: lzmw -r -p folder1,fileN -w path-lines-1.txt,list-3.txt -k 33 -f "\.(cs|cp*|hp*|cx*)$" --nf "test|unit" -d "^(code|src)$" --nd "^(\.git|Debug)$" --pp "code.*src" --np "bin\S*Release" --xp "bin/Release,obj/,test" -G --xd --xf --w1 2023-09 --w2 2023-09-19T23:30:01 --s1 1B --s2 1.5MB -i -x public -t "\bclass\b" -o Class -e color-extra-regex -U 3 -D 3 -b begin-line-or-block -Q block-end-regex -q stop-regex -L 10 -N +20 -H 100 -J --timeout 9.5 --keep-color --unix-slash 1 --exit gt0-to-0,le0-to-1 --colors t=Red+Red_Yellow,x=Yellow,e=Green+Cyan -m -u -v dtm -O -c Show command Out summary only if found.

One limitation: Cannot process Unicode files or pipe for now; Fine with UTF-8/ANSI/etc.
Search usage like: lzmw -h -C | lzmw -i -t block.+match  or  lzmw | lzmw -it "max.*?depth|Jump out" -U 2 -D2  or  lzmw | lzmw -ix File -t "Preview|Replace|Execute" -e "Change|Backup"
You can preset env: MSR_EXIT, MSR_OUT_INDEX, MSR_NO_COLOR, MSR_COLORS, MSR_OUT_FULL_PATH, MSR_NOT_WARN_BOM, MSR_SKIP_LAST_EMPTY, MSR_KEEP_COLOR, MSR_UNIX_SLASH for --unix-slash / --keep-color / etc.

With nin.exe more powerful to remove duplication, get exclusive/mutual key/line set, top distribution: https://github.com/qualiu/lzmw
Example: Get insensitive unique paths + descending sort-by-percentage to show top 2 duplicate paths + Merge trimmed one line paths to new %PATH%:
    lzmw -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u 
    lzmw -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u -d -p -k 2
    lzmw -z "%PATH%;" -t "\\*?\s*;\s*" -o "\n" -aPAC | nin nul "(\S+.+)" -i -u -PAC | lzmw -S -t "[\r\n]+(\S+)" -o ";\1" -aPAC 

As a portable cross platform tool, lzmw has been running on: Windows / MinGW / Cygwin / Ubuntu / CentOS / Fedora / Darwin / FreeBSD
Aperiodic updates: https://github.com/qualiu/lzmw , more tools: https://github.com/qualiu/msrTools + https://github.com/qualiu/msrUI + https://github.com/qualiu/vscode-msr
Call@Everywhere: Add lzmw.exe to system environment variable PATH with lzmw.exe directory like: D:\lztool
	 or temporarily: SET "PATH=%PATH%;D:\lztool"
	 or rudely but simple and permanent: copy D:\lztool\lzmw.exe C:\WINDOWS\
