#!/bin/bash -x

MYSQL_BRANCHES="/home/stewart/mysql/mysql-5.1 /home/stewart/mysql/mysql-5.5 /home/stewart/mysql/mysql-5.6"

BZR_REPO="mysql.bzr"

if [ ! -d $BZR_REPO ]; then
  bzr init-repo $BZR_REPO
fi

echo "Grabbing BZR branches"

for BRANCH in $MYSQL_BRANCHES; do
  (cd $BZR_REPO;
      if [ ! -d `basename $BRANCH` ]; then
        bzr branch --no-tree $BRANCH;
      else
	(cd `basename $BRANCH`; bzr pull)
      fi
  )
done

MARKS=`pwd`/mysql.marks

OUT=`pwd`/mysql

if [ ! -d mysql ]; then
  mkdir $OUT
  (cd $OUT;
   git init;
   git remote add origin git@github.com:percona/mysql.git;
   git config core.compression 1
   )
fi

if [ ! -f $MARKS.bzr ]; then
  touch $MARKS.bzr
  touch $MARKS.git
fi

for BRANCH in $MYSQL_BRANCHES; do
 echo "Importing $BRANCH"
 (cd $BZR_REPO/`basename $BRANCH`; bzr fast-export --marks=$MARKS.bzr --git-branch=`bzr nick` --plain --rewrite-tag-names ) | (pv -B 256m) | \
 (cd $OUT; git fast-import --import-marks=$MARKS.git --export-marks=$MARKS.git)

done
