#!/bin/bash -x

if [ ! -d $BZR_REPO ]; then
  bzr init-repo $BZR_REPO
fi

echo "Grabbing BZR branches"

for BRANCH in $BZR_BRANCHES; do
  (cd $BZR_REPO;
      if [ ! -d `basename $BRANCH` ]; then
        bzr branch --no-tree $BRANCH;
      else
	(cd `basename $BRANCH`; bzr pull)
      fi
  )
done

NEW_GIT=0
if [ ! -d $OUT ]; then
  mkdir $OUT
  (cd $OUT;
   git init --bare;
   git remote add origin $GIT_REMOTE;
   git config core.compression 1
   )
   NEW_GIT=1
fi

LAST_BRANCH=

for BRANCH in $BZR_BRANCHES; do
 echo "Importing $BRANCH"

 touch $MARKS.git

 (cd $BZR_REPO/`basename $BRANCH`; bzr fast-export --checkpoint=1000\
 --git-branch=`bzr nick` --plain --rewrite-tag-names \
 --marks=$MARKS.bzr \
 ) | \
 sed -e ':begin;$!N;s/^committer billy-earney billy.earney@gmail.com\n <>/committer billy-earney <billy.earney@gmail.com>/' | \
 (bzr fast-import-filter --dont-squash-empty-commits --user-map=user-map.txt -x .git/) | \
# tee `basename $BRANCH`.fast-export |
 (pv -B 256m) | \
 (cd $OUT; git fast-import \
 --import-marks=$MARKS.git --export-marks=$MARKS.git
)
 LAST_BRANCH=`basename $BRANCH`
done

if [ $NEW_GIT = 1 ]; then
 (cd $OUT;
 git config core.compression 9
 git symbolic-ref HEAD refs/heads/$LAST_BRANCH
# git prune;
 git repack -AdfF --depth=100 --window=500;
 )
fi
