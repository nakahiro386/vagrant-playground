#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sed -i.bak -e "s%http://archive.ubuntu.com/%http://jp.archive.ubuntu.com/%g" /etc/apt/sources.list
apt-get update -q
apt-get purge -y -q nano
apt-get install -y -q git
apt-get upgrade -y -q
apt-get autoremove -y -q
