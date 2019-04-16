---
layout: post
title: Poor man's ansible has got out of control
description: lesson learned - let simple stuff actually stay _simple_.
comments: true
tags:
- fun
- linux
---

OK, so my lovely but a bit scary script for simulating ansible without using ansible has grown a 
little in last few months. It wasn't supposed to do unfortunately.
Here's how it looks currently:

```
#!/usr/bin/env bash
#
#   -- run.sh help
#   print help information and quit
#
#   -- run.sh [commands file] [hosts file] [report file] [--verbose] [--dry]
#   run commands on specified hosts and save output to file.
#
#  --verbose - print every command before its execution
#        - default: false
#
#  --dry - print every command but don't execute it
#        - default: false
#
#   $1 - filename with bash script to execute
#        - default: 'commands/commands'
#        - required: no
#
#   $2 - filename with list of hosts
#        - default: 'hosts/hosts'
#        - required: no
#
#   $3 - filename where output will be saved
#        - default: 'reports/inventory-commands-report-YYYY-MM-DD-ID'
#        - required: no
#
# it's a joke.
[ "$1" = "help" ] && sed "/# it's a joke/q" $0 && exit 1

commands="${1:-commands/commands}"
hosts="${2:-hosts/hosts}"

# check if files exist and quit if they don't
[[ -f "$commands" ]] || { echo "error: file '$commands' does not exist!"; exit 1; }
[[ -f "$hosts" ]]    || { echo "error: file '$hosts' does not exist!";    exit 1; }

# prepare filename for default report, postfix it with next ID number based on
# number of files found with similar name that already exist
default_report="reports/$(basename $commands)-$(basename $hosts)-report-$(date +%F)"
report="${3:-$default_report}"
report="$report.$(ls $report* 2> /dev/null | wc -l | tr -d ' ')"

# because everyone does things by their own way
sed_flag=""
case "$OSTYPE" in
    linux*)     sed_flag="-u" ;;
    darwin*)    sed_flag="-l" ;;
esac

flags="-q -t -o StrictHostKeyChecking=no -o ConnectTimeout=5"


echo "Executing commands from '$commands' on hosts from '$hosts'..."
echo

while read -r host; do

    # print hostname and underline it with dashes
    echo "$host"
    echo "${host//?/-}"

    # prefix $commands with 'set -x' and postfix it with 'set +x'
    # convert to base64, send via ssh to $host using pass from `password` file
    # on the other end decode received string from base64 and pass it to bash
    cat - <<< 'set -x' "$commands" <(echo 'set +x') | base64 \
        | sshpass -f 'password' ssh $flags "$host" 'base64 -d | bash'

    echo ""

# filter out commented lines from hosts, filter out last login message
done < <(grep -v '#' "$hosts") | sed $sed_flag '/Last login/d' | tee "$report"

echo
echo "Report was saved to '$report'."
echo "Done."
```

So yeah, a _bit_ bigger than I last checked. It got few functionalities that are useful but now 
I'm kinda sorry for myself for creating it. It's still bash, it still lacks proper support for 
dynamic hosts range and has many many different issues which are not too easy to fix just like that.


I think I've learned a lesson here - don't reimplement working tools.
I could've used ansible, but I didn't because i thought of it as a waste of time.
This obviously came back now and bite me.


I guess I should've have seen this comming, oh well.
Anyways, it worked fine for quite a few times when I needed to do some dirty work in fastest way possible so I guess it wasn't a complete waste of time.

Or at least I hope so.


PS: This *is* a joke. Seriously. I've received at least few comments on why I have made it and do I really use it - no I do not.  
It's a joke, I made it to play around with a friend, it was fun but we both now use ansible. Please please please don't take this bash as a serious tool.  
