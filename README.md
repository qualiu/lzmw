# 1. lzmw
Search/Replace text
  * in 
   - pipe(command line result) or 
   - files-in-multiple-directories 
  * with 
    - normal text searching/replacing
    - regex text searching/replacing, and with single-line/multi-line mode
  * with excluding and including syntax meanwhile for 
   - Filtering file-name/directory-name/full-path-string  and 
   - filtering  include text and exclude text , 
   - also filter files by write-time range; 
  * finally Sort result text by specified time-or-text regex pattern,
  * Output with hierarchy colors by search-regex and enhance-regex, 
  * running on multiple platforms(Windows/Linux/Cygwin/Ubuntu/CentOS/Fedora).

Using general Regex (Regular expression) as same as the Regex in C++, C# and Java, you'll not need to learn strange regex alike patterns as Awk and Sed, etc. (But cannot process Unicode) 

Just run the exe, you'll get the usage and examples.
Besides, some script/batch/shell are also examples.

## Typical scenarios of lzmw
1. Find text in pipe (command line result) or files (such as code, log)
2. Replace text from pipe or files.
3. Enhance display with color for matching.
4. [Find processes](https://github.com/qualiu/lzmw/blob/master/tools/psall.bat) / [Kill processes](https://github.com/qualiu/lzmw/blob/master/tools/pskill.bat) by regex/pid with colorful matching.
5. Find file with specified name, modification time and other fitlers as following.
 ... ...

### With requirements of : (you can short alias like -t/-o , or full name --text-match/--replace-to )
1. Basic text searching(**-x**)/replacing(**-o**) , plus case sensitive or not (**-i**).
2. General Regex (regular expression) searching(**-t**)/replacing(**-o**) : consistent regex syntax with C#/C++/Java, not like strange or limited regex as AWK/GAWK/SED/FINDSTR …
3. Recursively (**-r**) searching and replacing files
  * Both with preview(no **-R**), 
  * Backup(**-K**)
  * From different paths(separate by "," or ";")
4. Powerful filtering: (can use all of following optinons meanwhile)
  * for file 
    - file-name(**-f**) / directory-name(**-d**) / path(**-pp**) + ALL :
    - include/exclude(**--nf**/**--nd**/**--np**) +ALL;
    - file-modification-time range filter: [**--w1**,**--w2**].
  * for text row :
    - start reading regex pattern (**-z**) / stop reading (**-Z**)
    - start reading row (**-L**) / stop row (**-N**)
  
5. Matching(**-t**/**-x**) and non-matching(**--nt**/**--nx**) filter at mean while.(like file filter)
6. Powerful output control:
  * Can sort by time if specified time format **-F** for the logs from multiple paths;
  * Colorful output and with hierarchy for captured matching group;
  * Capture(**-t**/**-x**) and enhance(**-e**) and with different color;
  * Lines up(**-U**) and down(**-D**) as context to the captrued row;
  * Head(**-H**) and tail(**-T**) for whole result rows.
7. Extra and useful output info : if not use **-A**
  * **When** you did it;
  * **What** command line (**-c**) you used;
  * **Where** the files and rows you searched/modified and working direcory (if not use **-P**)
  * **How** much time cost (so you know to start it at night/lunch if too long)
  * Mathcing count and percentages (Also can use **-l** to get just brief file list and count/percentage)
  * Use **-PAC** to get clean result (no above info, no color)
  * Use **-PIC** to output info to stderr pipe

#### lzmw on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![lzmw on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Windows.png)

#### lzmw on Linux
![lzmw on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Cygwin.png)

# 2. in-later / not-in-later / --uniq / --capture

* Following 2 tools now can be replace with **nin.exe** 

Another tool category: Just 2 exe in fact, with copy/link of variants. 
Run them to get the usage.

#### in-later on Windows : also can see [tools/readme.txt](https://github.com/qualiu/lzmw/tree/master/tools)
![in-later on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Winodws.png)

#### in-later on Linux
![in-later on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Cygwin.png)
