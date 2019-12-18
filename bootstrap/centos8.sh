#!/usr/bin/env bash

dnf install -y -q kernel-devel kernel-devel-`uname -r` gcc binutils make perl bzip2 git
dnf update -y -q
