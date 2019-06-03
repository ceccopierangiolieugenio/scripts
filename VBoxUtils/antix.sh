#!/bin/sh -x
# antiX-17.4.1_x64
# https://netix.dl.sourceforge.net/project/antix-linux/Final/antiX-17.4/antiX-17.4.1_x64-net.iso

apt update
apt upgrade -y

# Install and configure ssh
apt install -y openssh-server xauth xterm telnet
sed -i 's,#PermitRootLogin.*,PermitRootLogin yes,' /etc/ssh/*
service ssh restart

