# ssh

To login in:
ssh -i PATH_TO_KEY USER@REMOTE_HOST

# pyenv
pyenv versions
pyenv install 3.8.0

# bash setup
nano .bashrc

# screen
Ctrl-a d        # detach session
screen -ls      # list all processes
screen -r NAME  # reconnect to detached session

# scp
scp -i KEY FILE USER@REMOTE_HOST:~/

# reboot
shutdown -r now     # r == reboot

# list processes
top
ps
ps aux

# check ubuntu version
lsb_release -a

# check available disc space
df -h

# check CPU info
arch
lshw
uname -a
cat /proc/cpuinfo | grep processor | wc -l         # core number
