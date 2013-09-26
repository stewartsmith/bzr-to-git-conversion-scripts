#!/bin/bash -x

BZR_BRANCHES="/home/stewart/drizzle/drizzle-7.0 /home/stewart/drizzle/drizzle-7.1 /home/stewart/drizzle/drizzle-7.2"
BZR_REPO="drizzle.bzr"
GIT_REMOTE="git@github.com:stewartsmith/drizzle.git"
MARKS=`pwd`/drizzle.marks
OUT=`pwd`/drizzle.git

. sync.sh
