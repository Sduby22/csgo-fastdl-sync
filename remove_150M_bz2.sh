#!/bin/bash

# you may want to change the path to where the csgo/ folder is (include maps/ addons/ etc.)
CSGO_PATH=csgo/csgo/

cd $CSGO_PATH

SIZE=149M
coscmd list -ar | awk '{print $1}' > .coslist

# if some file is bigger than 150M, but was compressed to .bz2 and uploaded to the server
# then delete it because it's useless.
for path in `find . -type f -size +$SIZE | egrep "^\./(maps|models|materials|resource|sound)/"`
do
	path=${path:2}.bz2
	str=`grep "^${path}$" .coslist`
	if [ ! -z "$str" ]; then
		coscmd delete -y $path
	fi
done
	
rm .coslist
