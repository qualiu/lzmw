# 1. lzmw
search/replace text file/pipe 
  with single-line/multi-line 
  with regex/normal mode, 
  with filtering file-name/directory/path 
  by both excluding and including syntax.
Running on multiple platforms. 

Using general Regex (Regular expression) as same as the Regex in C++, C# and Java,
you'll not need to learn strange regex alike patterns as Awk and Sed,etc.

Just run the exe, you'll get the usage and examples.
Besides, some script/batch/shell are also examples.

## Typical scenarios of lzmw
1. Find text in pipe (command line result) or files (such as code, log)
2. Replace text from pipe or files.
3. Enhance display with color for matching.
4. [Find processes](https://github.com/qualiu/lzmw/blob/master/tools/psall.bat) / [Kill processes](https://github.com/qualiu/lzmw/blob/master/tools/pskill.bat) by regex/pid with colorful matching.
5. Find file with specified name, modification time and other fitlers as following.
 ... ...

### With requirement of :
1. Basic text searching(**-x**)/replacing(**-o**) , plus case sensitive or not (**-i**).
2. General Regex (regular expression) searching(**-t**)/replacing(**-o**) : consistent regex syntax with C#/C++/Java, not like strange or limited regex as AWK/GAWK/SED/FINDSTR …
3. Recursively (**-r**) searching and replacing files, both with preview(no **-R**), backup(**-K**) for replacing file.
4. Powerful file filter: file-name(**-f**)/directory-name(**-d**)/path(**-pp**) + ALL : include/exclude(**--nf**/**--nd**/**--np**) +ALL; file-modification-time range filter: [**--w1**,**--w2**].
5. Matching(**-t**) and non-matching(**--nt**) filter at mean while.(like file filter)
6. Colorful output and with hierarchy for captured matching group.
7. Capture(**-t**/**-x**) and enhance(**-e**) and with different color, lines up(**-U**) and down(**-D**) context, head(**-H**) and tail(**-T**) result.
8. Searching logs in multiple pathes of services and filter/sort by time, and fitler log file time.
9. Time cost info, Processing date/time info(no **-A**); Just list file path(**-l**); Other info like command line (**-c**) , working directory, path and line number info(no **-P**); Out time/processing info(no **-I** **-A**)

#### lzmw on Windows
![lzmw on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Windows.png)

#### lzmw on Linux
![lzmw on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/lzmw-Cygwin.png)

# 2. in-later / not-in-later / --uniq / --capture
Another tool category: Just 2 exe in fact, with copy/link of variants. 
Run them to get the usage.

#### in-later on Windows
![in-later on Windows](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Winodws.png)

#### in-later on Linux
![in-later on Cygwin](https://github.com/qualiu/lzmw/blob/master/tools/usage-picture/not-in-later-uniq-Cygwin.png)
