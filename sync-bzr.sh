#!/bin/bash -x

BZR_BRANCHES="/home/stewart/bzr"
BZR_REPO="bzr.bzr"
GIT_REMOTE="git@github.com:stewartsmith/bzr.git"
MARKS=`pwd`/bzr.marks
OUT=`pwd`/bzr.git

. sync.sh
