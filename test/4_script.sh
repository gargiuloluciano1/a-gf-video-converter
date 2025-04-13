#!/bin/bash

FILES=''
NEW_FILES=''
RES=''
echo "insert file names"
read FILES
for file in $FILES; do
	if [ ! -a "$file" ]; then
		echo "File $file doesnt exist"
		read -p "Do you wish to continue? [y/N]: " RES
		if [ "$RES" = 'y' ]; then #Remove word
			echo "here"
			NEW_FILES=${FILES/*( )${file}*( )}
			echo "$NEW_FILES";
		fi;
	 fi;
done
