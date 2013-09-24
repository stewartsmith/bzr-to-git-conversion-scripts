#!/bin/bash -x

MYSQL_BRANCHES="/home/stewart/mysql/mysql-5.1 /home/stewart/mysql/mysql-5.5 /home/stewart/mysql/mysql-5.6 /home/stewart/percona-server/percona-server-5.1 /home/stewart/percona-server/percona-server-5.5"
# /home/stewart/percona-server/percona-server-5.6"
BZR_REPO="percona-server.bzr"
GIT_REMOTE="git@github.com:percona/percona-server.git"
MARKS=`pwd`/percona-server.marks
OUT=`pwd`/percona-server

. sync.sh