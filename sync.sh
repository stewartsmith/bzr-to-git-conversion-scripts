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

if [ ! -d $OUT ]; then
  mkdir $OUT
  (cd $OUT;
   git init;
   git remote add origin $GIT_REMOTE;
   git config core.compression 1
   )
fi

if [ ! -f $MARKS.bzr ]; then
  touch $MARKS.bzr
  touch $MARKS.git
fi

for BRANCH in $BZR_BRANCHES; do
 echo "Importing $BRANCH"
 (cd $BZR_REPO/`basename $BRANCH`; bzr fast-export \
 --marks=$MARKS.bzr \
 --git-branch=`bzr nick` --plain --rewrite-tag-names ) | \
 (bzr fast-import-filter --user-map=user-map.txt) | \
 (pv -B 256m) | \
 (cd $OUT; git fast-import \
 --import-marks=$MARKS.git --export-marks=$MARKS.git
)

done
