#!/bin/bash -x

BZR_BRANCHES="/home/stewart/percona-server/percona-server-5.5 /home/stewart/percona-server/percona-server-5.6 /home/stewart/percona-server/percona-xtradb-cluster-5.5 /home/stewart/percona-server/percona-xtradb-cluster-5.6"
BZR_REPO="percona-xtradb-cluster.bzr"
GIT_REMOTE="git@github.com:percona/percona-xtradb-cluster.git"
MARKS=`pwd`/percona-xtradb-cluster.marks
OUT=`pwd`/percona-xtradb-cluster.git

. sync.sh
