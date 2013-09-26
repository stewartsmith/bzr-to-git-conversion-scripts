#!/bin/bash -x

BZR_BRANCHES="/home/stewart/mysql/mysql-5.7 /home/stewart/mysql/mysql-5.6 /home/stewart/mysql/mysql-5.5 /home/stewart/mysql/mysql-5.1 "
BZR_REPO="mysql.bzr"
GIT_REMOTE="git@github.com:percona/mysql.git"
MARKS=`pwd`/mysql.marks
OUT=`pwd`/mysql.git

. sync.sh
