---
layout: post
title: How to Install LLVM 9 on Debian Buster
description: and clangd, also!
comments: true
tags:
- c
---

Well, it's a bit of a hassle, honestly.
1. Go here [http://apt.llvm.org/](http://apt.llvm.org/)2. Find your `deb/deb-src` pair under `Debian` section.
For me it was `Buster (Debian 10 - stable)` and I want the latest stable version, so I got this:

    deb http://apt.llvm.org/buster/ llvm-toolchain-buster-9 main
    deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-9 main

3. Paste the above somewhere in `/etc/apt/sources.list.d/llvm.list`
4. `sudo apt update`
5. Tricky one - `sudo apt install -t llvm-toolchain-buster-9 clang-tools-9 clang`
If you will not specify the `-9` part in `clang-tools` then it will install `-7` which sucks.
If you will not specify `-t` part then it will not look for `[apt.llvm.org](http://apt.llvm.org)` for said package and instead will hit debian package which is outdated.

That's it, you should now have `clang-9` and `clangd` both in version `9`.
    $ clangd --version
    clangd version 9.0.1-svn374858-1~exp1~20191015042909.61 (branches/release_90)Well, almost. `clang` binary does not exist, so you'll have to link it to `clang-9` but that's no brainer.

    sudo ln -s $(which clang-9) /usr/bin/clang

There, now it should work :)

    clang --version
    clang version 9.0.1-svn374858-1~exp1~20191015042909.61 (branches/release_90)
    Target: x86_64-pc-linux-gnu
    Thread model: posix
    InstalledDir: /usr/bin
