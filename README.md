### Liberate & Digitize daily works by 2 exe: File Processing, Data Mining, Map-Reduce.

Most time **Just 1 command line** to solve your daily text or file processing work, pipe endless.

Since 2019-07-19 a `Visual Studio Code` extension: [**vscode-msr**]( https://marketplace.visualstudio.com/items?itemName=qualiu.vscode-msr) (source code: [here](https://github.com/qualiu/vscode-msr)) to help your coding work.

#### **M**atch/**S**earch/**R**eplace: on [Windows/MinGW/Cygwin + Ubuntu/CentOS/Fedora + Darwin + FreeBSD](#msr-color-doc-on-windowslinux--download-command)

- **Match/Search/Replace*** Lines/Blocks in Files/Pipe.
- **Filter/Load/Extract/Transform/Stats/*** Lines/Blocks in Files/Pipe.
- **Execute** transformed/replaced result lines as command lines.

#### **N**ot-**IN**-latter: on [Windows/MinGW/Cygwin + Ubuntu/CentOS/Fedora + Darwin + FreeBSD](#nin-color-doc-on-windowslinux--download-command)

- Get `Unique` or `Raw` **Exclusive/Mutual** Line-Set or Key-Set;
- **Stats** + **Get top distribution** in Files/Pipe.
- Remove(Skip) Line-Set or Key-Set matched in latter file/pipe.

# MSR Overview: [Windows](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Windows.html) or [Linux](https://qualiu.github.io/lzmw/usage-by-running/lzmw-CentOS-7.html) or [MacOS](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Darwin-Arm64.html)

### Performance Comparison: findstr + grep + lzmw

| Windows | MacOS | Linux |
| ------- | ----- | ----- |
| [**Summary table**](https://github.com/qualiu/lzmw/blob/gh-pages/perf/summary-full-Windows-comparison-2019-08-11.md) | [**Summary table**](https://github.com/qualiu/lzmw/blob/gh-pages/perf/summary-full-Darwin-Arm64-comparison-2021-11-20.md) | [**Summary table**](https://github.com/qualiu/lzmw/blob/gh-pages/perf/summary-part-CentOS-comparison-2019-08-11.md) |
| **2X**~**15X+** > findstr | **3X**~**10X+** > grep | **1.5~3X+** vs **1.5~3X+** |

### Quickly Get lzmw/nin + Demo + Related Resources

- To quickly get lzmw/nin without slowly cloning + storing many files: 
  - Method-1: Install a tiny extension [vscode-msr](https://marketplace.visualstudio.com/items?itemName=qualiu.vscode-msr) to **auto check + download** by system + terminal.
  - Method-2: Manually **click the URLs** in [**lzmw download commands**](#msr-color-doc-on-windowslinux--download-command) or [**nin download commands**](#nin-color-doc-on-windowslinux--download-command).
- To clone all files: 
  - git clone https://github.com/qualiu/lzmw (run `git reset --hard origin/master` when pulling conflicts).
- Preview functions: See HTML screenshots like [lzmw](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Windows.html) or [nin](https://qualiu.github.io/lzmw/usage-by-running/nin-CentOS-7.html) or vivid colorful [**demo on Windows**](https://qualiu.github.io/lzmw/demo/windows-test.html).
- Helpful **repos**: [**msrTools**](https://github.com/qualiu/msrTools)(like [psall.bat](https://github.com/qualiu/msrTools/blob/master/psall.bat) + [pskill.bat](https://github.com/qualiu/msrTools/blob/master/pskill.bat) + [Run-SQL.ps1](https://github.com/qualiu/msrTools/blob/master/SQL/Run-SQL.ps1)) + [**msrUI**](https://github.com/qualiu/msrUI) + **lzmw-nin** repo(if you're in Microsoft).

### Almost No Learning Cost

- Just general `Regex` as **C++, C#, Java, Scala**, needless to learn strange Regex syntax like `FINDSTR`, `Awk`, `Sed` etc.
- **Search**: (`-i` = `--ignore-case` like: `-i -t` or `-it` or `-ix`)
  - **Normal search**: lzmw -r -p `"path1,pathN"` -i -t `"Regex-pattern"` -x `"and-plain-text"` [Optional-Args](#optional-args)
  - **Advanced search**: [**code mining**](https://github.com/qualiu/vscode-msr#code-mining-without-or-with-little-knowledge) with the [cooked `doskeys`/`alias`](https://github.com/qualiu/vscode-msr#command-shortcuts) in `CMD`/`Bash` console or VSCode terminals.
- **Replace**: (You can use both `-x` and `-t`)
  - **Preview changes**: lzmw -r -p `path1,pathN` -t `"Regex-pattern"` -o `"replace-to"` **-j** [Optional-Args](#optional-args)
  - **Replace files**: lzmw -r -p `path1,pathN` -t `"Regex-pattern"` -o `"replace-to"` **-R** [Optional-Args](#optional-args)
- Use [optional args](#optional-args) like **-P -A -C** or **-PAC** or **-PIC** to get pure result as same as other tools like `grep`/`findstr`.
- All options are **optional** + **no order** + **effective meanwhile**; Free with **abbreviations** or **full-names**(like **-i** = `--ignore-case`).

## Usage + Examples + Color-Text-Screenshots

- Just run `lzmw --help` or `lzmw -h` or `lzmw` (same for `nin`) to see usage and examples, **brief quick start** at the [**bottom of output**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Windows.html).
- For **lzmw**: 
  - See [**Scenario Glance**](https://github.com/qualiu/lzmw/blob/master/README.md#scenario-glance) + [Brief Summary of lzmw EXE](https://github.com/qualiu/lzmw/blob/master/README.md#brief-summary-of-lzmw-exe) at the bottom of running `"lzmw -h"`.
  - See **additional UI helper**: [**msrUI**](https://github.com/qualiu/msrUI) to auto show usage + example + command line.
- For **lzmw** + **nin**: Also can see [tools/readme.txt](https://raw.githubusercontent.com/qualiu/lzmw/master/tools/readme.txt)
- **Zoom out** following screenshots to **90% or smaller** if it's not tidy or comfortable.

## MSR Color Doc on Windows/Linux + Download Command

You can use a **`tool folder`** (already in `%PATH%` or `$PATH`) instead of using **`%SystemRoot%`** or **`/usr/bin/`** (you can also link lzmw to there).

Validation with [**md5.txt**](tools/md5.txt) use `md5sum xxx` like: `md5sum lzmw* | lzmw -t "\s+\**" -o " " -PAC | nin md5.txt -m`

- [lzmw-Color-Doc on **Windows**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Windows.html) + **MinGW**: (You can get `wget` by [choco](https://chocolatey.org/packages/Wget) or [cygwin](https://github.com/qualiu/msrTools/blob/master/system/install-cygwin.bat); or get **lzmw** by [PowerShell](https://github.com/qualiu/vscode-msr#or-manually-download--set-path-once-and-forever))
  - **x86_64** + **Arm64**:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw.exe -O `lzmw.exe.tmp` && `move /y lzmw.exe.tmp lzmw.exe`  && `icacls lzmw.exe /grant %USERNAME%:RX` && `move lzmw.exe %SystemRoot%\`
  - Windows `32-bit`:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw-Win32.exe -O `lzmw.exe.tmp` && `move /y lzmw.exe.tmp lzmw.exe`  && `icacls lzmw.exe /grant %USERNAME%:RX` && `move lzmw.exe %SystemRoot%\`
  - [lzmw-Color-Doc on **Cygwin** x86_64](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Cygwin.html) (one command + green [install-cygwin.bat](https://github.com/qualiu/msrTools/blob/master/system/install-cygwin.bat)):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw.cygwin -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw`  && `chmod +x lzmw` && `mv lzmw /usr/bin/lzmw`
- [lzmw-Color-Doc on **MacBook**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Darwin-Arm64.html) `Arm64` (Darwin):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw-arm64.darwin -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw` && `chmod +x lzmw` && `sudo mv lzmw /usr/local/bin/lzmw`
- [lzmw-Color-Doc on **Linux**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-CentOS-7.html) + [**Fedora**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Fedora-25.html) + **WSL** + **Ubuntu**:
  - **x86_64** Linux (CentOS / Ubuntu / Fedora):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw.gcc48 -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw` && `chmod +x lzmw` && `sudo mv lzmw /usr/bin/lzmw`
  - **x86** `32-bit` like [**32-bit CentOS**](https://qualiu.github.io/lzmw/usage-by-running/lzmw-i386-CentOS-32bit.html):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw-i386.gcc48 -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw` && `chmod +x lzmw` && `sudo mv lzmw /usr/bin/lzmw`
  - **Arm64**:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw-aarch64.linux -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw` && `chmod +x lzmw` && `sudo mv lzmw /usr/bin/lzmw`
- **FreeBSD**
  - **amd64**:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/lzmw-amd64.freebsd -O `lzmw.tmp` && `mv -f lzmw.tmp lzmw` && `chmod +x lzmw` && `sudo mv lzmw /usr/bin/lzmw`

## NIN Color Doc on Windows/Linux + Download Command

Validation with [**md5.txt**](tools/md5.txt) use `md5sum xxx` like: `md5sum nin* | lzmw -t "\s+\**" -o " " -PAC | nin md5.txt -m`

- [nin-Color-Doc on **Windows**](https://qualiu.github.io/lzmw/usage-by-running/nin-Windows.html) + **MinGW**: (You can get `wget` by [choco](https://chocolatey.org/packages/Wget) or [cygwin](https://github.com/qualiu/msrTools/blob/master/system/install-cygwin.bat); or get **nin** by [PowerShell](https://github.com/qualiu/vscode-msr#or-manually-download--set-path-once-and-forever))
  - **x86_64** + **Arm64**:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin.exe -O `nin.exe.tmp` && `move /y nin.exe.tmp nin.exe`  && `icacls nin.exe /grant %USERNAME%:RX` && `move nin.exe %SystemRoot%\`
  - Windows `32-bit`:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin-Win32.exe -O `nin.exe.tmp` && `move /y nin.exe.tmp nin.exe`  && `icacls nin.exe /grant %USERNAME%:RX` && `move nin.exe %SystemRoot%\`
  - [nin-Color-Doc on **Cygwin** x86_64](https://qualiu.github.io/lzmw/usage-by-running/nin-Cygwin.html) (one command + green [install-cygwin.bat](https://github.com/qualiu/msrTools/blob/master/system/install-cygwin.bat)):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin.cygwin -O `nin.tmp` && `mv -f nin.tmp nin`  && `chmod +x nin` && `mv nin /usr/bin/nin`
- [nin-Color-Doc on **MacBook**](https://qualiu.github.io/lzmw/usage-by-running/nin-Darwin-Arm64.html) `Arm64` (Darwin):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin-arm64.darwin -O `nin.tmp` && `mv -f nin.tmp nin` && `chmod +x nin` && `sudo mv nin /usr/local/bin/nin`
- [nin-Color-Doc on **Linux**](https://qualiu.github.io/lzmw/usage-by-running/nin-CentOS-7.html) + [**Fedora**](https://qualiu.github.io/lzmw/usage-by-running/nin-Fedora-25.html) + **WSL** + **Ubuntu**:
  - **x86_64** Linux (CentOS / Ubuntu / Fedora):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin.gcc48 -O `nin.tmp` && `mv -f nin.tmp nin` && `chmod +x nin` && `sudo mv nin /usr/bin/nin`
  - **x86** `32-bit` like [**32-bit CentOS**](https://qualiu.github.io/lzmw/usage-by-running/nin-i386-CentOS-32bit.html):
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin-i386.gcc48 -O `nin.tmp` && `mv -f nin.tmp nin` && `chmod +x nin` && `sudo mv nin /usr/bin/nin`
  - **Arm64**:
    - wget https://github.com/qualiu/lzmw/raw/master/tools/nin-aarch64.linux -O `nin.tmp` && `mv -f nin.tmp nin` && `chmod +x nin` && `sudo mv nin /usr/bin/nin`
 - **FreeBSD**:
   - **amd64**:
     - wget https://github.com/qualiu/lzmw/raw/master/tools/nin-amd64.freebsd -O `nin.tmp` && `mv -f nin.tmp nin` && `chmod +x nin` && `sudo mv nin /usr/bin/nin`

## Demo and Test Screenshots

**Zoom out** following screenshots to **90% or smaller** if it's not tidy or comfortable.

- [Windows vivid demo test](https://qualiu.github.io/lzmw/demo/windows-test.html) (run `git clean -dfx` before re-running test if test failed).
- [Linux demo and test](https://qualiu.github.io/lzmw/demo/linux-test.html).

### Powerful

- Single exe for multiple platforms: **Windows** + **Cygwin** + **WSL** + **Ubuntu/CentOS/Fedora/Darwin**
- Smart Loading files with 8 composable kinds of filters:
  - 5 pairs of file attribute filters:
    - File name patterns (**-f**/**--nf**)
    - Directory patterns (**-d**/**--nd**)
    - Full path patterns:
      - Regex: 
        - **--pp** `need-regex`
        - **--np** `exclude-regex`
      - Texts:
        - **--xp** `"test,mock,/obj/"`
        - **--sp** `"src/,/common/"`
    - File size range:
      - **--s1** `1B` ; **--s2** `1.6MB`
      - **--s1** `file1-as-size`  ;  **--s2** `file2`
    - File modification time range:
      - **--w1** `2015-07-01T18:30:00`  ;  **--w2** `2015-08` or `"2015-07-01 20:00"`
      - **--w1** `10days` ;  **--w2** `+10d`
      - **--w1** `file1_as_time_plus_1s_if_no_w2`
      - **--w1** `file1_as_time` ; **--w2** `file_or_time_or_offset`
  - 3 kinds of file row / block filters to start/stop/skip reading/replacing each files/pipe:
    - Row/line number begin/end (**-L**, **-N**) like: 
      - `-L 30 -N 60` same with `-L 30 -N +30`
      - `-L 30 -N 0` same with `L 30 -N 30`
    - Block begin/end patterns (**-b**, **-Q**) for each block in each file/pipe; with **-q** to stop at once for pipe/each file.
    - Normal begin/end patterns (**b**, **-q**).
- Process pipe (output of self/other commands) **endless** as you want.
- Two composable single exe: [lzmw.exe/cygwin/gcc*](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) especially powerful with [nin.exe/cygwin/gcc*](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt).
- **70** composable options for [lzmw](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) and **30** composable options for [nin](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt) (just run them without parameters to get colorful usage/examples or see [readme.txt](https://github.com/qualiu/lzmw/blob/master/tools/readme.txt)) for further extractions/mining.

```batch
     lzmw --help # same as running: "lzmw -h" or "lzmw"
     nin --help # same as running: "nin -h" or "nin"
     lzmw | lzmw -t "^\s*-{1,2}\S+" -q "^\s*-h\s+" --nt "--help"
     nin | lzmw -t "^\s*-{1,2}\S+" -q "^\s*-h\s+" --nt "--help"
```

### One Limitation

- Cannot process Unicode files/pipe so far; Fine with UTF-8 and ANSI etc.

### Just Run the EXE to Get Color Usage and Examples

Besides the doc here and test scripts, some script/batch/shell files are also examples in this and sub-folders.

# Brief Summary of lzmw EXE

Use the rich searching options of like below, **combine** these **optional** options (**You Can Use All**):

- Set searching paths: (Can use both)
  - Recursively(`-r`) search one or more files or directories, like: **-r** **-p** `file1,folder2,file2,folder3,folderN`
  - Read paths (path list) from files, like: **-w** `path-list-1.txt,path-list-2.txt`
- Set max search depth (begin from input folder), like:
  **-k** `16` (default max search depth = `33`).
- Filter text by `line-matching` (default) or `whole-file-text-matching` (add **-S** / **--single-line** Regex mode):
  - Ignore case for text matching:
    - Add **-i** (`--ignore-case`)
  - Regex patterns:
    - **-t** `should-match-Regex-pattern`
    - **--nt** `should-not-match-Regex-pattern`
  - Plain text:
    - **-x** `should-contain-plain-text`
    - **--nx** `should-not-contain-plain-text`
- Single-line-Regex mode (**-S**) for Regex `"^"`and `"$"`:
  - Treat each file as one single line. If reading pipe, treat whole output as one line.
  - If block matching (used `-b` + `-Q`): Treat each block as one line in a file. Useful like removing a whole block.
- Filter `file name`: **-f** `should-match-Regex` , **--nf** `should-not-match-Regex`
- Filter `directory name`: **-d** `at-least-one-match-Regex` , **--nd** `none-should-match-Regex`
- Filter `full path pattern`: **--pp** `should-match-Regex` , **--np** `should-not-match-Regex`
- Filter `full or sub paths`: **--xp** `"d:\win\dir,my\sub,\bin\,\out\\"` , **--sp** `"\src\,common"`
  - Newer lzmw support **universal slash** `/` for `--pp`/`--np` + `--sp`/`--xp` like: 
    - **--xp** `"d:/win/dir,my/sub,/bin/,/out/"`
    - Check if support universal slash by command: `lzmw --help | lzmw -x "Support '/' on Windows"`
- Skip/Exclude link files: **--xf**
- Skip/Exclude link folders: **--xd**
- Try to read once for link files: **-G** (link files' folders must be or under input root paths of **-p** or/and **-w**)
- Filter `file size`: **--s1** <= size <= **s2** , like set one or two: **--s1** `1B` **--s2** `1.5MB`
- Filter `file time`: like **--w1** `2015-07`, **--w2** `"2015-07-16 13:20"` or `2015-07-16T13:20:01` (quote it if has spaces).
- Filter rows by begin + end row numbers: like **-L** 10 **-N** 200 (for each file).
- Filter rows by begin + end Regex: like **-b** `"^\s*public.*?class"` **-q** `"^\s*\}\s*$"`
- Filter rows by 1 or more blocks: **-b** `"^\s*public.*?class"` **-Q** `"^\s*\}\s*$"`
- Filter rows by 1 or more blocks + **stop** like: **-b** `"^\s*public.*?class"` **-Q** `"^\s*\}\s*$"` **-q** `"stop-matching-regex"`
- **Quickly** pick up `head{N}` results + **Jump out**(`-J`), like: **-H** `30` **-J** or **-J** **-H** `300` or **-JH** `300` etc.
- Don't color matched text: **-C**  (`Faster` to output, and **must be set** for `Linux/Cygwin` to further process).
- Output summary `info` to **stderr** + **hide** `warnings in stderr` (like BOM encoding): **-I** : Like **-I -C** or **-IC** or **-J -I -C** or **-JIC** etc.
- Use **--force** to force replace BOM files which header != 0xEFBBBF (if UTF8 encoding is acceptable).
- Use `--keep-color` on Windows/MinGW if you want to keep color for pipe or output file.
- Use `--colors` to change/set colors for match-result / file-paths / final summary: See [**Set-Or-Change-Color-Groups**](#set-or-change-color-groups).
- Use `--unix-slash 1` to output forward slash (`/`) of file paths on Windows (`lzmw`/`nin` accepts 2 types of slash: `'/'` and `'\'`).
- Use `--exit number/Math/Regex` to change exit code, like:
  - Use `--exit gt255-to-255` for Cygwin/Linux/MacOS shell.
  - Use `--exit gt127-to-127` for MinGW on Windows.
  - It's **not recommended** to set global MSR_XXX environments in your machine, because this may cause errors for other people/machines.
    - You can set environment temporarily(like [vscode-msr](https://marketplace.visualstudio.com/items?itemName=qualiu.vscode-msr)) in a command line or in a script header like: 
      - `export MSR_EXIT=gt0-to-0,le0-to-1`  (this will change to `traditional return value style`).
      - This is safe (only impact 1 script) + Convenient yourself if you're used to traditional usage.

## Scenario Glance

- Search code or log:
  - lzmw -rp `folder1,folder2,file1,fileN` -t `"Regex-Pattern"` -x `"And-Plain-text"` --nt ... --nx ... --nd ... -d ... --pp ... --np ... --xp ...

- Search files + Extract + Transform to target text/value:
  - lzmw -rp `folder1,folder2,file1,fileN`  -t `"Regex-Pattern"` -o `"Replace-To"`   + [Optional Args](#optional-args)

- Get matched file list (You can omit -o xxx). You can also append `| lzmw -t "(.+)" -o "command \1" -X` to process files.
  - lzmw -rp `folder1,folder2,file1,fileN`  -t `"Regex-Pattern"` -o `"Replace-To"`  -l  + [Optional Args](#optional-args)

- Replace text:
  - lzmw -rp `folder1,folder2,file1,fileN`  -t `"Regex-Pattern"` -o `"Replace-To"`    + [Optional Args](#optional-args)

- Just **preview** changed files + lines:
  - lzmw -rp `folder1,folder2,file1,fileN`  -t `"Regex-Pattern"` -o `"Replace-To"` **-j**  + [Optional Args](#optional-args)

- Replace files (`-R`) and backup (Add `-K`):
  - lzmw -rp `folder1,folder2,file1,fileN`  -t `"Regex-Pattern"` -o `"Replace-To"` **-R**  + [Optional Args](#optional-args)

- Insert or add a line with **same indention**:
  - lzmw -rp `paths` -f `"\.(xml|json)$"` -it `"^(\s*)(regex-groups)"` -o `"\1\2\n\1{add-your-line}"` -R

- Replace or remove specific matched block (multiple lines) like code files and config files(`XML`/`JSON`/`YAML`/`INI` etc.):
  - lzmw -rp `paths` -f `"\.xml$"` -b `"^\s*</Tag1>"` -Q `"^\s*</Tag1>"` -it `"match-regex"` -o `"replace-to or empty/to-remove"` -R with **-S** if you need.

- Sort log files by time text (**auto set to previous line's time if a line no time**) + Get error top distribution:
  - **lzmw** -rp `paths` -F `"\d{4}-\d{2}-\d{2}\D\d+:\d+:\d+[\.,]?\d*"` | **nin** nul `"\.(\w+Exception)\b"` -p -d -O -w

- Grep numbers in files or pipe, and sort (**-s**) as number (**-n**) + Show stats: `Count` + `Sum` + `Max` + `Min` + `Median` + `Average` + `Standard-Deviation` + `Percentiles` etc. :
  - lzmw -rp `paths` -f `"\.log$"` -t `"time cost = (\d+\.?\d*)"` -n -s `""`
  - xxx-cmd-output | lzmw -t `"(match-1), value = (-?\d+\.?\d*)` -n -s `"value = (-?\d+\.?\d*)"`

- Further processing based on summary (generate text, or command lines with `-X` to execute):
  - lzmw -rp `paths` -it `regex` -x `text` --nt `skip-regex` --nx `skip-text` -H 0 -c **key message** | lzmw -t `"^Matched (\d+) .*? -c (key message)"` -o `"replace to text or command line"` -X

### Tip for Captured Groups Reference to Replace Files or Transform Text

It's better to use **"\1"** than **"$1"** which let you easier to copy/migrate your replacing command lines.

- For example: lzmw -p paths -i -t `".*?text = (capture1).*?(capture2).*"` -o **"\1 \2"**
  - `"\1"` = `"$1"` for CMD console or batch files (`*.bat` or `*.cmd`) on Windows.
  - `"\1"` = `'$1'` for PowerShell (Windows / Linux) or Bash (Linux / Cygwin).

### Tips for Frequent Usages

- Execute output lines as command lines:
  - Often use **-X -M** (or **-XM**) to hide final summary of executions.
  - Use **-X -I** to avoid show each command's return value + time cost + command line.
  - Use **-X -P -I** or **-X -A** to hide all.
  - Run a command, exit if return != 0: `echo command line | lzmw -XM || exit -1` (use `exit /b -1` on Windows CMD)
  - Directly run a simple command line: `lzmw -XM -z "command line" || exit -1`  (use `exit /b -1` on Windows CMD).
  - Set **UTF-8 no-BOM** encoding if **matching head** failed due to encoding changed by `Python`/`PowerShell`/etc, like:
    - `[Console]::InputEncoding = New-Object System.Text.UTF8Encoding $false`
    - `file/pipe/command output | lzmw -t "^head-search-Regex" -o "replace-to" ...`
  - You don't need to change encoding if **execute**(-X) output, lzmw will **auto detect and trim** the BOM header before executing:
    - `file/pipe/command output | lzmw -X`
    - `file/pipe/command output | lzmw -t "search-Regex" -o "replace-to" ... -X`
- Replace Files(**-R**):
  - Use **-j** to preview changes before replacing(`-R`).
  - Use **-M -T 0** to hide summary + final changed file list, only output immediate change info (hide by `-H 0`).

### Optional Args

``` batch
:: No order, but case-sensitive. Free to use abbreviations (-i = --ignore-case; -r = recursive; -k = --max-depth)
 lzmw
  -r
  -p path1,path2,pathN
  -w path-list-file-1,path-list-file-N
  -k 18

  -i
  -t "Match-Regex"
  -x `"And-Plain-text"`

  -o `"Replace-To"`

  --nt "Exclude-Regex"
  --nx "Exclude-Plain-Text"

  -S  : Use single-line-Regex-mode for whole text in pipe or each-file or each-block

  -f "File-Name-Regex"
  --nf "Exclude-File-Name-Regex"

  -d "Match-Folder-Name-Regex"
  --nd "^(\.git|bin|Debug|Release|static|packages|test)$"

  --np "Exclude-Full-Path-Regex"
  --pp "Match-Full-Path-Regex"
  
  --xp "Exclude-Full-or-SubPath1,FullPath2,SubPathN"
  --sp "Need-SubPath1,SubPath2"

  --s1 1B
  --s2 10.50MB

  --w1 "2015-12-30 10:20"
  --w2 "2015-12-30T19:20:30"

  -L Begin-Row-Number
  -N End-Row-Number

  -F "Match-Regex-to-Sort-By-Text" : Usually for time like "\d{4}-\d{2}-\d{2}\D\d+:\d+:\d+[\.,]?\d*"
  -B "Begin-Text-Regex"
  -E "End-Text-Regex"

  -s "Sort-by-Regex-(Group1)-or-this" : This will skip lines not matches this Regex, different to -F

  -b "Begin-Regex-of-Block-or-Line"
  -Q "End-Regex-of-Block"
  -q "End-Regex-of-Line"

  -H {N} : {N} = 0 to hide output;  {N} > 0 to show head N lines;  {N} < 0 to skip head N lines.
  -T {N} : {N} = 0 to hide output;  {N} > 0 to show tail N lines;  {N} < 0 to skip tail N lines.

  -U 3 -D 3
  
  --colors "Green, t=Red + Yellow_Blue, x = Yellow, e = Cyan_Black, d = Blue, f = Green, p = Green, m = Green, u = Red."

  --timeout 30.5

  *** ***
  More detail/examples see the home doc or just run the exe with '--help' or '-h' or no args.
```

### Set or Change Color Groups

- Method-1: Use `--colors` to set color groups for matching text + file paths + summary.
  - Full color groups example (explanations see below):
    - `--colors "Green, t=Red+Blue_Yellow+Magenta_Red, x=Yellow, e=Cyan, d=Blue, f=Green, m=Green, u=Yellow"`
    - Valid color names(no-case): `Red + Green + Yellow + Blue + Cyan + Magenta + Black + White + None`.
- Method-2: Set environment variable `MSR_COLORS` with value of `--colors` example above.

#### Group-1 of Colors for Matching Text

##### Default Colors of Text Matching
- Plain text matching(`-x`) use `Yellow`(`Yellow_None`): 
  - Foreground Color = `Yellow`
  - Background Color = `None`(usually `Black`).
- Regex text matching(`-t`) use color arrays for **Regex-captured-groups**:
  - Linux = `Red_Black + Yellow_Red + White_Magenta + Cyan_Red`
  - Windows = `Red_Black + White_Red + Red_Yellow + White_Magenta`
- Regex enhance/extra-coloring (`-e`):
  - Windows = `Green_Black + White_Blue + Black_Cyan + Magenta_Black + Black_White + Yellow_Black`
  - Linux = `Green_Black + White_Blue + Yellow_Blue + Magenta_Black + Black_White + Yellow_Black`
- Example:
    - Command: 
      - `echo abc 123 extra plain | lzmw -t "\w+ (\d+)" -e "ext\w+" -x plain`
    - Group **-t** matched result:
      - Output `abc` with color `Red_Black`: foreground = `Red`, background = `Black`.
      - Output `123` with color `White_Red`.
    - Group **-e** matched result:
      - Output `extra` with color `Green_Black`.
    - Group **-x** matched result:
      - Output `plain` with color `Yellow`.

##### Change Default Matching Colors

- Change all colors with no group name of `x/t/e`:
  - Example command: `echo abc 123 extra plain | lzmw -t "\w+ (\d+)" -e "ext\w+" -x plain --colors Green`
  - All matched text of groups `-t/-x/-e` will be output with `Green` color.
- Change one group with group name of `x/t/e`:
  - Example command: `echo abc 123 extra plain | lzmw -t "\w+ (\d+)" -e "ext\w+" -x plain --colors Green,t=Cyan+Red_Blue`
  - Group **-t** result use `Cyan + Red_Blue`
    - Output `abc` with `Cyan`.
    - Output `123` with `Red_Blue`
  - Other matched result of `-x/-e` use `Green` color.
- Remove one or more group color:
  - Example command: `echo abc 123 extra plain | lzmw -t "\w+ (\d+)" -e "ext\w+" -x plain --colors t=none`
  - Group **-t** result will be no color, other groups (`-x/e`) keep colors.

#### Group-2 of Color for Result File Path

- Change result file path color with `d/f/p` for `directory`/`file-name` or `path` for both.
  - Example command: `lzmw -p . -l --colors p=green_blue`
  - Output file paths with color = `Green_Blue` (foreground = `Green`, background = `Blue`).
- Remove colors for file paths:
  - Example command: `lzmw -p . -l --colors p=none`
  - Output file paths with color = `None` which is no color.

#### Group-3 of Color for Final Summary Text
- Change summary color if matched (usually found results):
  - Example command: `lzmw -p . -f "\.cpp$" -t search -x plain-text --colors m=Green`.
- Remove summary color whatever matched(`m`) or not(`u`):
  - Example command: `lzmw -p . -f "\.cpp$" -t search -x plain-text --colors m=none,u=none`.
  
### If you Want to Use MSR to Color Execution

General example: Transform output to command lines then **execute**:

`echo command line` or `command output lines` | lzmw -t `Search-Regex` -o `Replace-To` **-X** `-P` `-I` `-M` `-A` ...

- Hide commands before execution: **-P** like **-X -P** or **-XP**
- Hide return value and time cost: **-I** like **-X -I** or **-XI**
- Hide summary of all executions:  **-M**  like **-X -M** or **-XM** (**-XM** or **-XMI** is mostly used)
- Hide all(command/cost/summary): **-A** like **-XA**
- Output `"return-value+command"` only if a command returns abnormal code (fail):
  - Use **-X -O** to output `"return-value+command"` only if a command `return != 0`.
  - Use **-X -O -V xxx** like `-V gt0` to output only if `return value > 0`.

### If you Want to Use MSR to Color Output

Brief introduction besides the color doc [lzmw-Color-Doc on Windows](https://qualiu.github.io/lzmw/usage-by-running/lzmw-Windows.html) as following:

Related controls and options that you can use at the same time:

- Color Options
  - **-x** `Plain-Text` : Set `Yellow` color to matched `Plain-Text`
  - **-t** `Regex-Pattern`: Set `Red` color to matched `Regex` **group[0]**, different **group[N]** different color.
  - **-e** `Regex-Pattern`: Set `Green` color to matched `Regex` **group[0]**, different **group[N]** different color.
    - Difference: **-e** just add colors, **-t** will add colors + only show matched lines if not used **-a**.

- Auxiliary Controls
  - **-P**: Hide path/line/row.
  - **-M**: Hide summary message.
  - **-A**: No any other info/text. Almost same to combination of **-P -M**
  - **-I**: Output summary to **stderr**.
  - **-a**: Show all output lines/text including not matched.

- Frequently Used Examples
  - **Only** show **captured** text with color:
    - echo `cmd output text` | lzmw **-PA** -t `"Regex, error or need Red color"`
    - echo `cmd output text` | lzmw **-PA** -x `"Plain text, warning or need Yellow color"`
  - Show **all** output: Add color to specific text:
    - echo `cmd output text` | lzmw **-aPA** -t `"Regex, error or need Red color.*?(group1) (group2)"` -e `"extra color (group1) (groupN)"`
    - echo `cmd output text` | lzmw **-aPA** -x `"Plain text, warning or need Yellow color"` -e `"extra color (group1) (groupN)"`
  - More complicate coloring:
    - echo `cmd output text` | lzmw **-aPA** -it `"Regex (group1) (group2)"` -e `"extra (color) (group)"` -x `"plain text"`
    - echo `cmd output text` | lzmw **-PA** -it `"Regex to only show matched"` --nx `"exclude text"` --nt `"exclude Regex"`
    - echo `cmd output text` | lzmw **-PA** -it `"Regex to only show matched with up/down rows, head 100, tail 100"` -U 3 -D 9 -H 100 -T 100
