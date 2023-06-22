#!/bin/bash

# -----------------------------------------------------------------------------
# ALMOST everything below this line can probably stay the same
# --
DATE=$( date +"%Y-%m-%d" )

# --
# clean up local directory
echo -e $0:${LINENO}: store older packages
if  [[ ! -d pkg ]]; then
  mkdir pkg
fi
mv -f *.gz* ./pkg
rm *.gz*

# --
# get package name, version, and date... assumes pwd ends in the package name!
PWD=$( pwd )
PWD=(${PWD//\// })
PKG=${PWD[${#PWD[@]}-1]}
DIR=$PKG
CURRENT_VERSION=$( sed -n 2p ./$PKG/DESCRIPTION | sed s/Version://  | tr -d ' \r\n\s' )
echo -e $0:${LINENO}: current version: $CURRENT_VERSION
echo -e version update:
read NEW_VERSION
if [ ${#NEW_VERSION} -lt 5 ]; then  # versioning requires A.B.C format
  NEW_VERSION=$CURRENT_VERSION
fi

# update version
echo -e "\n"$0:${LINENO}:-- "\n"package: $PKG"\n"version: $CURRENT_VERSION to $NEW_VERSION "\n"date: $DATE "\n"--
sed -i "2s/^V.*/Version: $NEW_VERSION/" ./$PKG/DESCRIPTION
sed -i "3s/^D.*/Date: $DATE/" ./$PKG/DESCRIPTION

# --
# add function list so that the verbose description lists everything
echo -e "\n"$0:${LINENO}:-- "\n"update INDEX file"\n"--
echo "# $PKG function list" > $PKG/INDEX
echo "IO >> $PKG" >> $PKG/INDEX
echo $PKG >> $PKG/INDEX
cd $PKG/inst
mFILES=$( ls *.m )
for f in $mFILES; do
  echo " $f" >> ../INDEX
done
cd ../..

# --
# summon git!
if [ 0 -eq 1 ]; then
	echo -e comments:
	read COMMENTS
	git commit -m "$COMMENTS"
	echo -e $0:${LINENO}: update NEWS
	printf "\n=================\n%s %s\n" $NEW_VERSION $DATE >> ./$PKG/NEWS
	  CURRBRANCH=$( git log --max-count=1 --pretty=format:"%h" )
	  PREVBRANCH=$( git log --max-count=1 --pretty=format:"%p" )
	  MODS=$( git diff $CURRBRANCH $PREVBRANCH --name-only )
	  COMMENTS=$( git log -1 --pretty=%s | xargs echo -n )
	printf "$COMMENTS\n" >> ./$PKG/NEWS
	printf "modified files:\n" >> ./$PKG/NEWS
	printf "$MODS\n" >> ./$PKG/NEWS
else
  echo -e NOT summoning Git...
fi
# --
# create package
PKGVER=$PKG-$NEW_VERSION
PKGVERZIP=$PKGVER.tar.gz
echo -e $0:${LINENO}: archive $DIR to $PKGVERZIP
tar -czvf $PKGVERZIP $DIR
