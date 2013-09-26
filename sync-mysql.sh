#!/bin/bash -x

BZR_BRANCHES="/home/stewart/mysql/mysql-5.1 /home/stewart/mysql/mysql-cluster-7.0 /home/stewart/mysql/mysql-cluster-7.1 /home/stewart/mysql/mysql-cluster-7.2 /home/stewart/mysql/mysql-cluster-7.3 /home/stewart/mysql-6.0-abandoned /home/stewart/mysql/mysql-5.5 /home/stewart/mysql/mysql-5.6 /home/stewart/mysql/mysql-5.7"
BZR_REPO="mysql.bzr"
GIT_REMOTE="git@github.com:percona/mysql.git"
MARKS=`pwd`/mysql.marks
OUT=`pwd`/mysql.git

. sync.sh
