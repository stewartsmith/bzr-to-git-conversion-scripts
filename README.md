bzr-to-git-conversion-scripts
=============================

Some scripts to help with BZR to git conversion (esp MySQL, Percona Server and Drizzle trees)

Initial run:

1) modify the sync-BLAH.sh script to pull from the right location. Usually you have a local mirror 
of the bzr trees and you may as well do initial clone from them rather than pulling everything over
the internet.

2) run ./sync-BLAH.sh and wait (about 2 hours for MySQL based trees)

3) you can then change the BZR parent for the bzr trees to pull from lp if you like

4) running ./sync-BLAH.sh again will pull what's changed out of BZR and store it in git.

After the initial import, it does a git repack to get very efficient storage.
Subsequent imports do not do a repack.
