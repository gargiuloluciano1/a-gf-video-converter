#!/bin/bash

function get_files {
	FILES=''
	local NEW_FILES=''
	
	echo "Please enter file names"
	read FILES
	NEW_FILES="$FILES"

	for file in $FILES; do
		if ! [ -a "$file" ]; then 
			echo "File $file doesnt exist"
			NEW_FILES=${NEW_FILES/$file}
		fi
	done

	FILES=($NEW_FILES)
}

get_files
for file in "${FILES[@]}"; do
	echo "$file";
done
