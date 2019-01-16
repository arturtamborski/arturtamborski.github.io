---
layout: post
title: Quick notes on concurrency and parallelism
description: just a reference
comments: true
tags:
- programming
---

This is just a rough draft, I'm posting this because it's still might be useful,
but it's clearly not usable - sorry!


You might think, that the world is Object Oriented, *but it's not*. **It's parallel**.

Concurrency and parallelism are **not** the same thing. It's a common misunderstood problem.

Currency is a composition of *independently* running processes (not Linux process, more like an abstract kind of process) typically expressed with functions.


Parallelism is a *simultaneous* execution of *multiple* things, possibly related, possibly not.


General idea:

Concurrency is about dealing with a lot of things at once  
Parallelism is about doing a lot at once

Concurrency is a way to structure the program so that you can *maybe* use parallelism to do a better job, but parallelism is not the goal of concurrency.

Concurrency goal is a good, independent structure.


Analogy: Operating System might have things like Drivers. 
There might be a network driver, display driver, keyboard driver which are
running as independent things in the kernel, but those are concurrent things
not nessesarly parallel.
There's a concurrent model for those drivers, but it's not inherintly parallel.

Parallel thing might be a vector driver which you can break up into multiple things
and execute at once.


Concurrency gives you a way of breaking up pieces but then you have to coordinate
those pieces and to do that you need some kind of communication.


With concurrency it's not always matter of doing the less amount of work possible.
More often it's possible to run things faster by doing more work.

Parallelism can come from better concurrent expression of the problem.


BUT THIS DOES NOT MEAN THAT CONCURRENCY NEEDS PARALLELISM!
We can design a process in such a way that it will operate well in parallel execution,
but it doesn't have to be parallel to **still** be concurrent, ergo beneficial.

If you do the design of concurrent process right then it will scale well by applying parallelism.
It's sort of a free thing you get for good work.


So what essentially you should think is this:
that code is running concurrently, **maybe** in parallel.

Concurrency is powerful, but it's not parallelism.
Concurrency *enables* parallelism making it easy.


I still think the one missing feature is an "async yield". I suspect most won't immediately understand why though.


http://herpolhode.com/rob/lec1.pdf



[1](https://blog.golang.org/concurrency-is-not-parallelism)
[2](https://snarky.ca/how-the-heck-does-async-await-work-in-python-3-5/)
[3](https://www.cs.cmu.edu/~crary/819-f09/Hoare78.pdf)
[4](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/9b122a21c1436da94c67a74bfdfba7e57a4d203e.pdf)
