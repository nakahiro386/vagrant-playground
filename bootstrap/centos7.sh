#!/usr/bin/env bash

yum install -y -q kernel-devel kernel-devel-`uname -r` gcc binutils make perl bzip2 git
yum update -y -q