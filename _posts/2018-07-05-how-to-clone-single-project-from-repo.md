---
layout: post
title: How to clone single directory from git repo
description: simple and effective
comments: true
tags:
- linux
---

Just a quick tip - I was looking for a way to download a single directory from
my github repo. Unfortunately, the internet told me that this wasn't possible 
because git doesn't support this.

But after some searching I've found few solutions:
  - some webistes can do this but it is hard to automate because they use js on
client side and thats just too much hassle for me 
([downGit seems cool tho](https://minhaskamal.github.io/DownGit/#/home)).
  - github supports `svn` which can handle these sorts of stuff but I don't want another program just for this simple task
  - hacky scripts that basically scrap the website and download everything
  - or just download the whole repo and remove everything thats not needed (_bad solution_)


I didn't like these so I've searched some more and found this - `git sparse-checkout`. This thing (quite well documented on multiple blogs) is exactly what I was looking for.

All you need is git!


Here's how to set it up:

Create working directory for your project

	mkdir work
	cd work

Init git directory inside and enable sparse checkout

	git init
	git config core.sparsecheckout true

Add remote repo

	git remote add -f origin https://github.com/arturtamborski/c-playground

Write dirs that you want to pull to `sparse-checkout`

	# this one is important (dont forget the leading slash!)
	echo qotdd/ >> .git/info/sparse-checkout

Optionally you can link to this file for easier usage in the future

	# now i can just add up dirs in this file
	ln -s .git/info/sparse-checkout projects

	# nice
	echo echod/ >> projects


Finally, pull the files
	
	git pull origin master

	# if you want to do this
	git pull

	# then you'll have to do this
	git branch --set-upstream-to=origin/master

And if you later want to pull other directory then add it up to projects

	echo nslookup/ >> projects

	# important
	git read-tree -mu HEAD

	# it should appear now
	ls


Okay, this still seems like a hack because it breaks few things and effectively
makes commits useless but this is still cool if you don't want to play around
with zips and tarballs.


Yeaaaah, I've searched some more and this feature seems way too hacky for me.
It doesn't _really_ pull separate directries - instead it kinda hides everything
except these from `sparse-checkout` and I don't like that.

I mean it does the job but maybe these tarballs aren't that bad after all.
Or maybe I shouldn't just put everything into one repo.


Yeah, that was bad idea.

_Don't do that._
