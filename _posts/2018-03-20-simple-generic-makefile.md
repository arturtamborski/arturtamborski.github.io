---
layout: post
title: Simple generic Makefile
description: Just 40 lines!
comments: true
tags:
- make
---

Have you ever tried to write Makefile for your project? If not then I can tell you - its a mess.
It was so painful for me that I even made my own [build script](https://github.com/arturtamborski/build-sh).

But, eventually I had to learn Makefiles because my script was hitting its limits
and I didn't want to reinvent the wheel.

Sadly, I don't know how to write good Makefiles so I took some generic Makefiles and cut them in pieces.
After a while I had what I wanted - the core of a Makefile.  Here it is!

```makefile
app: ./bin/main.o
	gcc -o app ./bin/main.o

./bin/main.o: ./bin/main.o : ./src/main.c
	gcc -c -o ./bin/main.o ./src/main.c
```

These rules describe precisely the build project for simple main.c project.
It works like that:
  - make has to build the `app` file but it depends on the `./bin/main.o`,
  - `./bin/main.o` depends on the `./src/main.c`,
  - `./src/main.c` exists, so `main.o` can be built,
  - `./bin/main.o` is built as single object file (the `-c` flag assures it),
  - `app` can now be built from because all dependencies are met

It's plain and simple but it will work only for single source file named `main.c`
and that's a problem. But we can fix it with variables:

```makefile
$(TARGET): $(OBJS)
	gcc -o $@ $^

$(OBJS): $(OBJDIR)/%$(OBJEXT) : $(SRCDIR)/%$(SRCEXT)
	gcc -c -o $@ $?
```

Here's a description of these variables:
  - `$^` is list of all files after the target name (all object files)
  - `$?` is list of all modified files that have to be compiled (modified source files)
  - `$(TARGET)` is just the name of a compiled app,
  - `$(OBJS)` is a list of files based on source files,
  - `$(SRCDIR)` and `$(OBJDIR)` are the names of source and binary directories,
  - `$(SRCEXT)` and `$(OBJEXT)` contain file extensions for source and binary files.

One thing that might concern you is the fourth line:
```makefile
$(OBJS): $(OBJDIR)/%$(OBJEXT) : $(SRCDIR)/%$(SRCEXT)
```
Thanks to this the input files `$(OBJDIR)/%$(OBJEXT)` will be created from `$(SRCDIR)/%$(SRCEXT)`.
The `%` sign symbolizes currently processed file name, so all it does is
replaces `./src/<file>.c` to `./bin/<file>.o`.

Next, we can add few more standard rules and variables.

```makefile
all: $(TARGET)
	@echo Done.

run: $(TARGET)
	@./$(TARGET)

clean:
	@rm -r $(TARGET) $(OBJS) $(OBJDIR)

$(TARGET): $(OBJS)
	@$(LD) $(LDFLAGS) -o $@ $^

$(OBJS): $(OBJDIR)/%$(OBJEXT) : $(SRCDIR)/%$(SRCEXT) | $(OBJDIR)
	@$(CC) $(CCFLAGS) -c -o $@ $?

$(OBJDIR):
	@mkdir -p $(OBJDIR)

.PHONY: all run clean
```

I've added the `all`, `run` and `clean` rules and new variables:
`$(LD)`/`$(LDFLAGS)` and `$(CC)`/`$(CCFLAGS)` for linker/flags and compiler/flags
and a new rule for creating `$(OBJDIR)` if it doesn't exist yet
(`$(OBJDIR)` is often removed by the `clean` rule).

There's also a `$(OBJDIR)` for specifying output directory and `$(OBJEXT)` for object file extension.
The `@` sign mutes printing of currently executed command (we only want the output).

This makefile is pretty much done but it still won't work because these variables
are never defined. We can change that with some shell commands.

```makefile
TARGET	= $(notdir $(CURDIR))

SRCEXT	= .c
INCEXT	= .h
OBJEXT	= .o

SRCDIR	= ./src
INCDIR	= ./src
OBJDIR	= ./bin

CC	= gcc
LD	= gcc

LDFLAGS	= -lm
CCFLAGS	= -std=gnu99 -g -ggdb -Og -Wall -Wextra -pedantic

SRCTREE	= $(shell find $(SRCDIR) -type d)
INCS	= $(shell find $(INCDIR) -type f -name '*$(INCEXT)')
SRCS	= $(shell find $(SRCDIR) -type f -name '*$(SRCEXT)')
OBJTREE	= $(foreach D,$(SRCTREE),$(shell echo $(D) | sed 's/$(SRCDIR)/$(OBJDIR)/'))
OBJSTMP	= $(foreach F,$(SRCS),$(shell echo $(F) | sed -e 's/$(SRCDIR)/$(OBJDIR)/'))
OBJS	= $(foreach O,$(OBJSTMP),$(shell echo $(O) | sed -e 's/\$(SRCEXT)/\$(OBJEXT)/'))
```
The simple ones:
  - `TARGET` is the name of current directory,
  - `SRCEXT`, `INCEXT` and `OBJEXT` source code, header files and object files extensions,
  - `SRCDIR`, `INCDIR`, `OBJDIR` are set up for source and header files directory and output directory,
  - `CC`, `LD`, `LDFLAGS` and `CCFLAGS` compiler, linker, compiler flags and linker flags.

And the cool ones:
  - `SRCTREE` contains all directories found in `$(SRCDIR)`,
  - `INCS` has all header files in `$(INCDIR)`,
  - `SRCS` has all source files in `$(SRCDIR)`,
  - `OBJTREE` has all dirs from `SRCTREE` but with replaced source directory name for the object directory one,
  - `OBJSTMP` has all files from `SRCS` with the same rule as above applied,
  - `OBJS` all files from `OBJSTMP` with replaced source file extension for object file extension.

Those few lines will basically generate three file lists - `SRCS`, `INCS` and `OBJS` all nicely filled from `SRCDIR` and `INCDIR`.

That's it! Here's the final makefile - it contains our clever variables and simple rules.
Together it allows us to easily compile C/C++ projects.

```makefile
TARGET  = $(notdir $(CURDIR))

SRCEXT	= .c
INCEXT	= .h
OBJEXT	= .o

SRCDIR	= src
INCDIR	= src
OBJDIR	= bin

CC	= gcc
LD	= gcc

LDFLAGS	= -lm -lpthread
CCFLAGS	= -std=gnu99 -g -ggdb -Og -Wall -Wextra -pedantic

SRCTREE	= $(shell find $(SRCDIR) -type d)
INCS	= $(shell find $(INCDIR) -type f -name '*$(INCEXT)')
SRCS	= $(shell find $(SRCDIR) -type f -name '*$(SRCEXT)')
OBJTREE	= $(foreach D,$(SRCTREE),$(shell echo $(D) | sed 's/$(SRCDIR)/$(OBJDIR)/'))
OBJSTMP	= $(foreach F,$(SRCS),$(shell echo $(F) | sed -e 's/$(SRCDIR)/$(OBJDIR)/'))
OBJS	= $(foreach O,$(OBJSTMP),$(shell echo $(O) | sed -e 's/\$(SRCEXT)/\$(OBJEXT)/'))

all: $(TARGET)
	@echo Done.

run: $(TARGET)
	@./$(TARGET)

clean:
	@rm -r $(TARGET) $(OBJS) $(OBJDIR) 2>/dev/null || true

$(TARGET): $(OBJS) | $(OBJDIR)
	@$(LD) $(LDFLAGS) -L$(OBJDIR) -o $@ $^

$(OBJS): $(OBJDIR)/%$(OBJEXT) : $(SRCDIR)/%$(SRCEXT) | $(OBJDIR)
	@$(CC) $(CCFLAGS) -I$(INCDIR) -c -o $@ $?

$(OBJDIR):
	@mkdir -p $(OBJDIR) $(OBJTREE)

# comment

.PHONY: all run clean
```
