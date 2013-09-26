#!/bin/bash -x

BZR_BRANCHES="/home/stewart/percona-xtrabackup/percona-xtrabackup-1.6 /home/stewart/percona-xtrabackup/percona-xtrabackup-2.0 /home/stewart/percona-xtrabackup/percona-xtrabackup-2.1 /home/stewart/percona-xtrabackup/percona-xtrabackup-2.2"
BZR_REPO="percona-xtrabackup.bzr"
GIT_REMOTE="git@github.com:percona/percona-xtrabackup.git"
MARKS=`pwd`/percona-xtrabackup.marks
OUT=`pwd`/percona-xtrabackup.git

. sync.sh
