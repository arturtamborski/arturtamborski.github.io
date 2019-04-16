---
layout: post
title: Poor man's ansible
description: it's simple and it works :)
comments: true
tags:
- fun
- linux
---

Let's say that something broke badly. On multiple servers. And you can't fix 
it with one-liner because it's not that simple and there aren't enough quotes
left anyways.

Well, then you would probably want to use something like ansible or mcollective 
to run a bunch of commands on some list of servers, but sadly this time you
don't have access to these fancy tools. What then?

Well, then you are left with your creativity - and there's something cool 
about that when you have to use linux shells - they are uber elastic.

I had to fix 40 servers which all broke in the same way so the problem was
to run non-trivial list of commands on multiple servers as robustly as 
possible in quickest time possible.
I had to use quite a few commands accually which couldn't be just thrown 
onto a shell because there was some logic behind it so oneliner wouldn't do
it.

And it basically came down to using SSH and some script which is not suprising
but the solution is - the run script is encrypting the file with commands using 
base64 algorithm and then sends the output via SSH to receiving servers where 
it's decrypted and passed to bash shell.

This is cool for few reasons:
  - all of the commands are in its own separate file which is much easier
  to modify, save and keep track of than a bash line buffer or oneliner.
  - these commands are run as written which gives you the ability to
  use all of the bash features such as variables or logic statements
  - no escaping, base64 perserves everything about the text but passes
  it as a string of characters so it's harmless to other commands  until
  they are executed by bash.
  - low priviledges, you don't have to run this as root and be afraid of 
  breaking something - instead you can write commands just as if you
  were there in SSH session. You can run sudo and then exit etc.


Ok, enough talking, here's the code:


This is the run script, you should specify here hostnames, ports and rules
for iterating over them.
It's also worth mentioning the `StrictHostKeyChecking=no` flag which 
takes care of annoying question when you connect to new servers.

```
# ssh: -o StrictHostKeyChecking=no

$HOST=<your hostname>

for i in {30..50}; do
    base64 commands | ssh $HOST$i 'base64 -d | bash'
done
```


And here's the magic `commands` file.
```
echo '------------------------'
hostname
echo

echo "Hi there, I'm $(whoami)"

su root
  echo 'Who am I?"
  whoami
  echo 'I AM GROOT!"
exit

# our job is done, we're disconnecting
echo

```

And that's basically all. It's really simple, clever and clean solution.
Like, really. This thing made my day today. I mean, yeah I could
just use some ugly oneliner or write some commands multiple times
but that little sneaky trick with base64 just caught me from surprise.

It's not really ideal and well, the ansible is better
but when all you have is a shell then it's still more than enough.
