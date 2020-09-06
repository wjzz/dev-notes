# ssh

To login in:

```
ssh -i PATH_TO_KEY USER@REMOTE_HOST
```

# pyenv

```
pyenv versions
pyenv install 3.8.0
```

# bash setup

```
nano .bashrc
```

# screen

```
screen          # start screen
Ctrl-a d        # detach session
Ctrl-a n        # next screen tab
screen -ls      # list all processes
screen -r NAME  # reconnect to detached session
```

# scp

```
scp -i KEY FILE USER@REMOTE_HOST:~/
```

# reboot

```
shutdown -r now     # r == reboot
```

# list processes
```
top
ps
ps aux
```

# check ubuntu version
```
lsb_release -a
```

# check available disc space
```
df -h
```

# check CPU info

```
arch
lshw
uname -a
cat /proc/cpuinfo | grep processor | wc -l         # core number
```

# check ports

```
netstat | grep 5432
```

# list open files

```
sudo lsof -i -P -n | grep 5432
sudo kill <process-id>
```

# use intel syntax

```
gcc -masm=intel -S hello.c
objdump -M intel -d a.out # or -D instead of -d to see everything
```
 
# Documentation for libc 

```
man libc
info libc
man assert

man time
man 2 time

man man # list of chapters
apropos assert # search the manuals
```

# find glibc

```
sudo find /lib -name libc.so.6
=> /lib/x86_64-linux-gnu/libc.so.6
=> /lib/i386-linux-gnu/libc.so.6

/lib/x86_64-linux-gnu/libc.so.6
	GNU C Library (Ubuntu GLIBC 2.27-3ubuntu1) stable release version 2.27.
	Copyright (C) 2018 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.
	There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
	PARTICULAR PURPOSE.
	Compiled by GNU CC version 7.3.0.
	libc ABIs: UNIQUE IFUNC
	For bug reporting instructions, please see:
	<https://bugs.launchpad.net/ubuntu/+source/glibc/+bugs>.
```

# objdump

```
objdump -p /lib/i386-linux-gnu/libc.so.6 | grep SONAME
```

# autoconf

```
autoconf
autoreconf
```

# command line history

```
history
history | grep python
```

# Assemblers etc can be found in GNU Binutils

```
strip
ld  # linker
strings 
as
```
	
# other assembler

```
nasm
```

# check file type

```
$ file hello.o 
hello.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped
```

# check architecture

```
name -a
```

# check Ubuntu's version

```
lsb_release

lsb_release -a # all
```

# check all aliases

```
alias
```

# remove package

```
sudo apt-get remove PACKAGE_NAME
```

# my version now is Ubuntu 18.04.3 LTS
# to update 

```
update-manager -c
```

# silent make

```
make -s command
# alternative: put '@' in the Makefile before lines to be made quiet
```

When looking for the path to an executable or checking what would happen if you enter a command name in a Unix shell, there's a plethora of different utilities (which, type, command, whence, where, whereis, whatis, hash, etc).

# find all places an executable can be found in the path:

```
which -a ghc
```

# check directory size

```
du -hs *               # s=summary, h=human readable
```

# show directory structure

```
tree 
tree -a        # show all
```

# sorting

```
sort -hr # human readable, reverse
```

# show only top 10 results

```
head -n 10
```

# show only last 10 results 

```
tail -n 10
```

# remove duplicated lines

```
uniq
```

# bidirectional pipe

```
socat EXEC:Program1 EXEC:Program2
```

# EMACS

I have some cool yas /ya snippets prepared for various modes

```
C-x e # goto emacs config file
```

# MERCURIAL

```
hg st
hg up
hg branch
hg branches
hg merge BRANCH_NAME
hg head
hg pull
hg push
```

# Server like task managing

```
crontab
```

# Startup applications

```
search 'startup application'
man 5 init # doesnt work for me
```

# Search the systemd journal

```
journalctl
```

# Find a program

```
which perl
```
