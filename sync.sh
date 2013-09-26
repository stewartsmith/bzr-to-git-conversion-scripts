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

 touch $MARKS-`basename $BRANCH`.git

 cp $MARKS-`basename $BRANCH`.git $MARKS-`basename $BRANCH`.git.in

 (cd $BZR_REPO/`basename $BRANCH`; bzr fast-export \
 --git-branch=`bzr nick` --plain --rewrite-tag-names \
 --marks=$MARKS-`basename $BRANCH`.bzr \
 ) | \
 (bzr fast-import-filter --user-map=user-map.txt) | \
# tee `basename $BRANCH`.fast-export |
 (pv -B 256m) | \
 (cd $OUT; git fast-import \
 --import-marks=$MARKS-`basename $BRANCH`.git.in --export-marks=$MARKS-`basename $BRANCH`.git.out
)
cp $MARKS-`basename $BRANCH`.git.out $MARKS-`basename $BRANCH`.git
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
