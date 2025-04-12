#!/bin/bash

# Simple script for changing the video format (?)
# Add a coproc where to show percentage of completion


convert_videos() {
	for file in ${FILES[*]}; do
		ffmpeg -i $file -map 0:0 -c copy file_out > /dev/null; #get return value
		if [[ $? == 0 ]] then
			echo "success";
		fi
	done
}

declare -a FILES

echo "Please write name of files"
read -a FILES

coproc CHILD { convert_videos; }

INPUT=''
while { read -u ${CHILD[0]} INPUT; }; do
	echo "file finished processing";
done

