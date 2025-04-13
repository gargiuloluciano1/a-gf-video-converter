#!/bin/bash

# Simple script for changing the video format (?)
# Add a coproc where to show percentage of completion

# TODO check for correct format
#

function get_files {
	FILES=''
	NEW_FILES=''
	
	echo "Please enter file names"
	read FILES
	NEW_FILES="$FILES"

	for file in $FILES; do
		if ! [ -a "$file" ]; then 
			echo "File $file doesnt exist"
			NEW_FILES=${NEW_FILES/$file}
		fi
	done
	
	declare -a FILES
	FILES=($NEW_FILES)
}

convert_videos() {
	for file in ${FILES[*]}; do
		ffmpeg -y -i $file -map 0:0 -c copy out.mov &> /dev/null;
		echo "$?";
	done
}

# Get name of files to convert 
get_files

coproc CHILD { convert_videos; }

INPUT=''
while { read -u ${CHILD[0]} INPUT;}; do
	echo "$INPUT";
done
