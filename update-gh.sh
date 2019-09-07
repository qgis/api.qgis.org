#!/bin/bash

rsync --delete /var/cache/pbuilder/src/qgis/reps/api/html/ master
cp /usr/share/javascript/jquery/jquery.js master/


DIR=master
cd $DIR
for SUBDIR in `ls -d */`; do
  echo "Adding $DIR/$SUBDIR"; 
  git add $SUBDIR; 
  git commit -m "$DIR/$SUBDIR folder docs"; 
  # should not really be needed as our repo is clean
  git repack; git gc
  git push origin master; 
done
# Prevent issues with large commits in G by committing a letter group at a time
# first qgs prefix files
for LETTER in {a..z}; do
  git add qgs${LETTER}*; 
  git commit -m "$DIR folder docs letter $LETTER"; 
  # should not really be needed as our repo is clean
  git repack; git gc
  git push origin master; 
done
# Prevent issues with large commits in G by committing a letter group at a time
for LETTER in {a..z}; do
  git add ${LETTER}*; 
  git commit -m "$DIR folder docs letter $LETTER"; 
  # should not really be needed as our repo is clean
  git repack; git gc
  git push origin master; 
done

# add any left over files
git add .; 
git commit -m "$DIR folder docs"; 
# should not really be needed as our repo is clean
git repack; git gc
git push origin master; 
cd ..
