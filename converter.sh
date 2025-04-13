#!/bin/bash

# Simple script for changing the video format (?)
# Add a coproc where to show percentage of completion


convert_videos() {
	for file in ${FILES[*]}; do
		ffmpeg -y -i $file -map 0:0 -c copy out.mov &> /dev/null;
		echo "$?";
	done
}

declare -a FILES






## keep asking user for file name if they are incorrect
echo "Please write name of files"
read -a FILES
for file in ${FILES[*]}; do
	if {! test -a $file; }; then
		echo "$file is not a valid filename";
	fi
done

coproc CHILD { convert_videos; }

INPUT=''
while { read -u ${CHILD[0]} INPUT;}; do
	echo "$INPUT";
done
