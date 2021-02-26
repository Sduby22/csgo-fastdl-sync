#!/bin/bash

# you may want to change the path to where the csgo/ folder is (include maps/ addons/ etc.)
CSGO_PATH=csgo/csgo/

cd $CSGO_PATH
SIZE=149M

# list the cos server files.
coscmd list -ar | awk '{print $1}' > .coslist

# bzip2 the files that are smaller than 150M
for path in `find . -type f -size -$SIZE | egrep "^\./(maps|models|materials|resource|sound)/"`
do
	path=${path:2}
	str=`grep "^${path}.bz2$" .coslist`
	if [ -z "$str" ]; then
		bzip2 -k $path;
		coscmd upload $path.bz2 $path.bz2
		echo "Uploading $path.bz2..."
		rm $path.bz2
	fi
done

# if the file is bigger than 150M then dont bzip2 them (CSGO client refuses to decompress the files 
# that are bigger than 150M due to some limitations.)
for path in `find . -type f -size +$SIZE | egrep "^\./(maps|models|materials|resource|sound)/"`
do
	path=${path:2}
	str=`grep "^${path}$" .coslist`
	if [ -z "$str" ]; then
		coscmd upload $path $path
	fi
done
	
rm .coslist
