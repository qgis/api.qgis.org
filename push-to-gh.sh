#!/bin/bash


sudo git init .
sudo chown -R timlinux.timlinux .git
git config pack.packSizeLimit 500m
git config pack.windowMemory 500m

git add .gitignore push-to-gh.sh README.md .nojekyll
git commit -m "Initial setup" -a
git remote add origin git@qgis-api-repo:qgis/api.qgis.org.git
# First commit clears existing repo on GH by uisng force
git push -f origin master 


for DIR in `ls -r`; do 
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
done
