#!/bin/bash -x

BZR_BRANCHES="/home/stewart/libeatmydata"
BZR_REPO="libeatmydata.bzr"
GIT_REMOTE="git@github.com:stewartsmith/libeatmydata.git"
MARKS=`pwd`/libeatmydata.marks
OUT=`pwd`/libeatmydata.git

. sync.sh
