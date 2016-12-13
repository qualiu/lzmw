# 1. lzmw.exe/gcc* overview: (usage/examples: [readme.txt](https://github.com/qualiu/lzmw/tree/master/tools/readme.txt) )
[**New**] [Performance comparison with findstr and grep ](https://github.com/qualiu/lzmw/tree/master/perf) : [on-Windows-comparison.PNG](https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Windows-comparison.PNG) [on-Cygwin-comparison.PNG](https://raw.githubusercontent.com/qualiu/lzmw/master/perf/on-Cygwin-comparison.PNG)
### [**Vivid Colorful Demo/examples**]: Run [windows-test.bat](https://github.com/qualiu/lzmw/blob/master/tools/windows-test.bat) without parameters.
Download all by command : **git clone** https://github.com/qualiu/lzmw/

Search/Replace text by **lzmw.exe** / **lzmw.gcc**** / **lzmw.cygwin** 
  * in 
   - pipe(command line result) or 
   - files-in-multiple-directories 
  * with 
    - normal text searching/replacing
    - regex text searching/replacing, and with single-line/multi-line mode
  * with excluding and including syntax meanwhile for 
   - Filtering file-name/directory-name/full-path-string  and 
   - filtering  include text and exclude text , 
   - also filter files by write-time range and file size.
  * finally Sort result text by specified time-or-text regex pattern,
  * Output with hierarchy colors by search-regex and enhance-regex, 
  * running on multiple platforms(Windows/Linux/Cygwin/Ubuntu/CentOS/Fedora).

Using general Regex (Regular expression) as same as the Regex in C++, C# and Java, you'll not need to learn strange regex alike patterns as Awk and Sed, etc. (But cannot process Unicode) 

Just run the exe, you'll get the usage and examples.
Besides, some script/batch/shell are also examples.

## Typical scenarios of lzmw
1. Find text in pipe (command line result) or files (such as code, log)
2. Replace text from pipe or files **recursively** in **multiple** root path.
3. Enhance display with color for matching.
4. [Find processes](https://github.com/qualiu/lzmw/blob/master/tools/psall.bat) / [Kill processes](https://github.com/qualiu/lzmw/blob/master/tools/pskill.bat) by regex/pid with colorful matching.
5. Find file with specified name, in modification time range, size range and other fitlers as following.
6. Look up a tool's usage with brief context (Up/Down lines)
7. Grep a command's result with matching info and time.
8. Color your script execution.
9. Map <--> Reduce ...
 ... ...

### With requirements of : (you can short alias like -t/-o , or full name --text-match/--replace-to )
1. Basic text searching(**-x**) / replacing-to(**-o**) , plus case sensitive or not (**-i**).
2. General Regex (regular expression) searching(**-t**)/replacing(**-o**) : consistent regex syntax with C#/C++/Java, not like strange or limited regex as AWK/GAWK/SED/FINDSTR …
3. Recursively (**-r**) search / replace files in paths (**-p**) (multiple paths separated by "," or ";")
  * For replacing: replace regex-pattern(**-t**)/normal-text(**-x**) to (**-o**) final-text
    * Preview: no **-R**
    * Replace : with **-R**
    * Backup files only if changed/replaced (**-K**) :
  * Backup :  orgional files will be backup to : {name}--lz-backup--{file-last-write-time}-{N}
    - Such as : myConfig.xml--lz-backup-2013-11-13__11_38_24
    - But if replaced many times in a second : 
    - Will  be : myConfig.xml--lz-backup-2013-11-13__11_38_24**-N** (**N**  start from 1 )
   
4. Powerful filtering: (can use all of following optinons meanwhile)
  * for file : sorting order by the prior of **--wt** and **--sz** if use both
    - file-name(**-f**) / directory-name(**-d**) / path(**-pp**) + ALL :
    - include/exclude(**--nf**/**--nd**/**--np**) +ALL;
    - file modification time filter: **--w1**,**--w2** : like --w1 2012-09-08  --w2 "2013-03-12 15" (or "2013-03-12 15:00")
    - file size range filter: **--s1** , **--s2** : like --s1 100KB --s2 1M
    - show file modification time and sort : **--wt** : useful if list file with **-l** 
    - show file size and unit and sort : **--sz** : useful if list file with **-l** 
  * for file row : if not begin or stopped, not output/match/replace even if matched.
    - regex pattern 
      * start reading  (**-b**) 
      * stop reading (**-q**) ignore if has matched start pattern.
      * stop reading if has matched start pattern (**-Q**)
    - file line number
      * start at row (**-L**)
      * stop at row (**-N**)
  
5. Matching(**-t**/**-x**) and non-matching(**--nt**/**--nx**) filter at mean while.(like file filter)
6. Powerful output control:
  * Can sort by time if specified time format **-F** for the logs from multiple paths;
  * Colorful output and with hierarchy for captured matching group;
  * Capture(**-t**/**-x**) and enhance(**-e**) and with different color;
  * Lines up(**-U**) and down(**-D**) as context to the captrued row;
  * Head(**-H**) and tail(**-T**) for whole result rows.
  * Out summary info only if matched (**-O**)
  * No any info just pure result (**-A**)
  * Out summary info to stderr (**-I**)
  * Execute(**-X**) output lines as commands (if they're callable commands) : because for loop on Windows need escape | to ^| , > to ^> , etc.
7. Extra and useful output info : if not use **-A**
  * **When** you did it;
  * **What** command line (**-c**) you used;
  * **Where** the files and rows (if not use **-P**) you searched/modified and working direcory.
  * **How** much time cost (so you know to start it at night/lunch if too long)
  * Mathcing count and percentages (Also can use **-l** to get just brief file list and count/percentage)
  * Use **-PAC** to get clean result (no above info, no color)
  * Use **-PIC** to output info to stderr pipe
  * Use **-PC**/**-POC**/**-l -PC**/**-lPOC** >nul(nul on Windows, /dev/null on Linux) to use summary info as source input for later process/tool.
  * If has **-c** in command line any where, can append any extra text as a info, such as : 
    - lzmw -x "D:\data" -p xx.log -O >nul | lzmw -c -xxx xxx secondary extraction of matched result contains D:\data
  * **-z** to directly read from input string, avoid using echo which is clumsy in pipe on Windows.

#### lzmw on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![lzmw on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Windows.png)

#### lzmw on Linux
![lzmw on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Cygwin.png)

# 2. in-later / not-in-later / --uniq / --capture

* Following 2 tools now can be replaced with **nin.exe** [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)

Another tool category: Just 2 exe in fact, with copy/link of variants. 
Run them to get the usage.

#### in-later on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![in-later on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Winodws.png)

#### in-later on Linux
![in-later on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Cygwin.png)