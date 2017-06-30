### Liberate & Digitize daily works by 2 exe : Data Mining; Map-Reduce; Pipe Endless.
#### lzmw.exe/lzmw.cygwin/lzmw.gcc**
- **Search/Replace/Execute/*** Files/Pipe Lines/Blocks.
- **Filter/Load/Extract/Transform/Stats/*** Files/Pipe Lines/Blocks.
#### nin.exe/nin.cygwin/nin.gcc**
- Get **Exclusive/Mutual** Line-Set or Key-Set;
- **Remove** Line-Set or Key-Set matched in latter file/pipe;
- Get **Unique/Mutual/Distribution/Stats/*** Files/Pipe Line-Set or Key-Set.

# 1. lzmw.exe/gcc* overview: (usage/examples: [readme.txt](https://github.com/qualiu/lzmw/tree/master/tools/readme.txt) )
### Performance comparison [lzmw > findstr, lzmw ~ grep](https://github.com/qualiu/lzmw/tree/master/perf) :
| Windows | Cygwin |
|-----|-----|
| [**on-Windows-comparison.PNG**](https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Windows-comparison.PNG) | [**on-Cygwin-comparison.PNG**](https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Cygwin-comparison.PNG) |
| [**summary-full-Windows-comparison.md**](https://github.com/qualiu/lzmw/blob/master/perf/summary-full-Windows-comparison.md) | [**summary-full-Cygwin-comparison.md**](https://github.com/qualiu/lzmw/blob/master/perf/summary-full-Cygwin-comparison.md) |

### **Vivid Colorful Demo/examples**: Run [windows-test.bat](https://github.com/qualiu/lzmw/blob/master/tools/windows-test.bat) without parameters.
* Download all by command (Install [git](https://git-scm.com/downloads)) : **git clone** https://github.com/qualiu/lzmw/
* If you've downloaded, run an updating command in the directory: **git pull** or **git fetch && git reset --hard origin/master** (if get conflictions)
* Helpful scripts use **lzmw.exe** and **nin.exe** : https://github.com/qualiu/lzmwTools , and also *.bat files in [tools](https://github.com/qualiu/lzmw/tree/master/tools)

### Almost no learning cost:
* Using general Regex in **C++, C#, Java, Scala**, needless to learn strange Regex syntax like FINDSTR, Awk and Sed, etc.
* **Most** of the time **only** use searching(Regex: **-t**/**-i -t**, Plain text: **-x**/**-i -x**);
* **Some** of the time use searching with replacing-to(**-o**);
* Just use **-PAC** to get pure result as same as other tools (no **P**ath-number: **-P**, no **A**ny-info : **-A**, no **C**olor: **-C**)
* All options are **optional** and **no order** and **effective mean while**; Free with abbreviations/full-names.

### Powerful
* Single exe for multiple platforms: **Windows/Linux/Cygwin/Ubuntu/CentOS/Fedora** .
* Smart Loading files with 8 composable kinds of filters:
    * 5 pairs of file attribute filters <br>
      * File name patterns (**-f**/**--nf**)
      * Directory patterns(**-d**/**--nd**)
      * Full path patterns(**--pp**/**--np**)
      * Size range(**--s1**,**--s2**)
      * Write-time range(**--w1**,**--w2**)
    * 3 kinds of file row / block filters to start/stop/skip reading/replacing each files/pipe: <br>
      * Row/line number begin/end (**-L**, **-N**);
      * Block begin/end patterns (**-b**, **-Q**);
      * Normal begin/end patterns (**b**, **-q**).
* Process pipe (output of self/other commands) **endless** as you want.
* Two composable single exe: [lzmw.exe/cygwin/gcc*](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) especially powerful with [nin.exe/cygwin/gcc*](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt).
* **54**/**21** composable options for [lzmw](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) / [nin](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) (just run them without parameters to get colorful usage/examples or see [readme.txt](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt)) for further extractions/mining.
     ```
     lzmw --help # same as : lzmw -h / lzmw
     nin  --help # same as : nin  -h / nin
     lzmw | lzmw -t "^\s*-{1,2}\S+" -q "^\s*-h\s+"
     nin | lzmw -t "^\s*-{1,2}\S+" -q "^\s*-h\s+"
     ```
### One limitation:
* Cannot process Unicode files/pipe so far; Fine with UTF-8 and ANSI etc.

Just run the exe, you'll get the usage and examples.
Besides, some script/batch/shell files are also examples.

Search/Replace text by **lzmw.exe** / **lzmw.gcc**** / **lzmw.cygwin**
  * in files or from pipe
    - pipe (command line result);
    - files recursively in directories and multiple root paths separated by comma or semicolon.
  * with
    - Normal/Plain text searching/replacing;
    - Regex text searching/replacing, and with single-line/multi-line mode.
  * with excluding and including syntax meanwhile for
    - Filtering file-name/directory-name/full-path-string;
    - Filtering  include text and exclude text;
    - Filtering files by write-time range and file size.
  * Finally Sort result text by specified time or text (regex pattern);
  * Output with hierarchy colors by searching-regex and enhancing-regex.

## Typical scenarios of lzmw: Coding/Deploying/Test/Operation/Log-Mining
1. Find text in pipe (command line result) or files (such as code, log)
2. Replace text from pipe or files **recursively** in **multiple** root path.
3. Search/Replace and get percentage, distribution; further extraction on previous pipe or even command line.
4. [Find processes](https://github.com/qualiu/lzmw/blob/master/tools/psall.bat) / [Kill processes](https://github.com/qualiu/lzmw/blob/master/tools/pskill.bat) by regex/pid with colorful matching.
5. Find files with specified name, in modification time range, size range and other filters, then use the path list to operate (**-X** is helpful).
6. Look up a tool's usage with colors and context (Up/Down lines).
7. Grep a command's result with matching info and time cost, and colorful matched lines or blocks.
8. Adding colors to your scripts, especially nice to usage and examples section.
9. Map <--> Reduce : Filter files and load, extract, transform, ... , pipe endless.
 ... ...

### With requirements of : (you can use short alias like -t/-o , or full name --text-match/--replace-to )
1. Basic text searching(**-x**) / replacing-to(**-o**) , plus case sensitive or not (**-i**).
2. General Regex (regular expression) searching(**-t**)/replacing(**-o**) : consistent regex syntax with C#/C++/Java, not like strange or limited regex as AWK/GAWK/SED/FINDSTR …
3. Recursively (**-r**) search / replace files in paths (**-p**) (multiple paths separated by "," or ";")
   * For replacing: replace regex-pattern(**-t**)/normal-text(**-x**) to (**-o**) final-text
     * Preview: no **-R**
     * Replace : with **-R**
     * Backup files only if changed/replaced (**-K**) :
   * Backup : Original files will be backuped to : {name}--lz-backup--{file-last-write-time}-{N}
     * Such as : myConfig.xml--lz-backup-2013-11-13__11_38_24
      * But if replaced many times in a second :
      * Will be : myConfig.xml--lz-backup-2013-11-13__11_38_24**-N** (**N**  start from 1 )
   
4. Powerful filtering: (can use all of following options meanwhile)
   * For file : Sorting order by the prior of **--wt** and **--sz** if use both.
      - file-name(**-f**) / directory-name(**-d**) / path(**-pp**) + ALL :
      - include/exclude(**--nf**/**--nd**/**--np**) +ALL;
      - file modification time filter: **--w1**,**--w2** : like --w1 2012-09-08  --w2 "2013-03-12 15" (or "2013-03-12 15:00")
      - file size range filter: **--s1** , **--s2** : like --s1 100KB --s2 1M
      - show file modification time and sort : **--wt** : useful if list file with **-l**
      - show file size and unit and sort : **--sz** : useful if list file with **-l**
   * For file row : if not begin or stopped, not output/match/replace even if matched.
     - Regex pattern
       * start reading  (**-b**)
       * stop reading (**-q**) ignore if has matched start pattern.
       * stop reading if has matched start pattern (**-Q**)
     - File line number
       * start at row (**-L**)
       * stop at row (**-N**)
  
5. Matching(**-t**/**-x**) and non-matching(**--nt**/**--nx**) filter at mean while.(like file filter)
6. Powerful output control:
   * Can sort by time if specified time format **-F** for the logs from multiple paths;
   * Colorful output and with hierarchy for captured matching group;
   * Capture(**-t**/**-x**) and enhance(**-e**) and with different colors;
   * Lines up(**-U**) and down(**-D**) as context to the captured row;
   * Head(**-H**) and tail(**-T**) for whole result rows.
   * Out summary info only if matched (**-O**)
   * No any info just pure result (**-A**)
   * Out summary info to stderr (**-I**)
   * Execute(**-X**) output lines as commands (if they're callable commands) : because 'for' loop on Windows need escape | to ^| , > to ^> , etc.
7. Extra and useful output info : if not use **-A**
   * **When** you did it;
   * **What** command line (**-c**) you used; What's the percentage and distribution.
   * **Where** the files and rows (if not use **-P**) you searched/modified and working directory.
   * **How** much time cost (so you know to start it at night/lunch if too long)
   * Matching count and percentages (Also can use **-l** to get just brief file list and count/percentage)
   * Use **-PAC** to get clean result (no path-line, no any info, no color)
   * Use **-PIC** to output info to stderr pipe.
   * Use **-PC**/**-POC**/**-l -PC**/**-lPOC** >nul(nul on Windows, /dev/null on Linux) to use summary info as source input for latter process/tool.
   * If has **-c** in command line, can append any extra text, useful with **-O** **-H 0** or **>nul** to do further extraction based on summary info:
     - lzmw -x "D:\data" -p xx.log -O >nul | lzmw -xxx xxx -c Checking D:\data
   * Use **-z** to directly input string to read, avoid using echo which is clumsy in pipe on Windows.

#### lzmw on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![lzmw on Windows](https://raw.githubusercontent.com/qualiu/lzmw/master/usage-picture/lzmw-Windows.png)

#### lzmw on Linux
![lzmw on Cygwin](https://raw.githubusercontent.com/qualiu/lzmw/master/usage-picture/lzmw-Cygwin.png)

# 2. nin / not-in-later

## **nin** replaces old not-in-later-xxx. Just run nin or see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)

**xxx-in-later-xxx** ** is an old tool category of **nin**: Just 2 exe in fact, with copy/link of variants. Run them to get the usages and examples.

#### nin on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![nin on Windows](https://raw.githubusercontent.com/qualiu/lzmw/master/usage-picture/nin-Windows.png)

#### nin on Cygwin : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![nin on Cygwin](https://raw.githubusercontent.com/qualiu/lzmw/master/usage-picture/nin-Cygwin.png)
