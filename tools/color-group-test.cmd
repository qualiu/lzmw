lzmw -PA -z "  -u " -t "^\s{2}(-+(\S+))\s"
lzmw -PA -z "ExactMatchCount = 3" -t "Match|(\d+)" -e "Exact\w+" -x Count
lzmw -PA -z "ExactMatchCount = 3, " -t "Match|(\d+)" -e "Exact\w+" -x Count
lzmw -PA -z "not captured, abc = 2" -t "\w+ = (\S+)"
lzmw -PA -z "not captured, abc = 2, ok" -t "\w+ = (\S+)"
lzmw -PA -z "Test file info : 3332543 lines 1.39 GB : Plain text finding by findstr / grep / lzmw ; To find = Exception" -t "(\d+\.\d+)" -e "(\d+)|\w+" -a
lzmw -PA -z "Test:217 TimeCost = 6467 ms, ExactMatches = 0, TotalResults = 0, ExtraResults = 0, Types = All" -t "^\s*$|Cost|Ex\w+ = (\d+)" -e "Test:\d+.*"
lzmw -PA -z "lzmw -c -p %~dp0 -l -f bat -T -2 # Should skip bottom 2 items." -t t -e txt
lzmw -PA -p %~dp0\sample-file.txt -ib "<Tag name" -q "Switch" -Q "</Tag" -t MailTo -e Switch
lzmw -PA -z "myFileLog" -t "(.+)File(.+)"
lzmw -PA -z "myFileLog" -t "(.+)(File)(.+)"
lzmw -PA -z "myFileLog" -t ".+(File)(.+)"
lzmw -PA -z "myFileLog" -t ".+(File).+"
lzmw -PA -z "myFileLog" -t ".+(File)"
lzmw -aPA -z "see 'quotes' | lzmw -t" -e "see (.+?) \| (lzmw.*?)" -t " \| "
lzmw -PA -z CENTOS_MANTISBT_PROJECT_VERSION-7a -it centos.*7
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)|(Value)"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)" -x "=Value"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)" -x "command"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)" -x " command:"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)" -x "SET Name"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)|(=Value)" -x "Name="
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)" -t "(%%*Name%%*)|(Value)" -x "Name="
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)|(\w+=\w+)" -t "(%%*Name%%*)" -x "Name=Value"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)|(\w+=\w+)" -t "(%%*Name%%*)" -x "=Value"
lzmw -PA -z "by %%Name%% command: SET Name=Value" -e ".+?(SET \S+)|(\w+=\w+)" -t "(%%*Name%%*)"
lzmw -PA -z "by %%Name%% command: SET \"Name=Value\"" -e ".+?(SET \S+)|(\w+=\w+)" -t "(%%*Name%%*)"
