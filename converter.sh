#!/bin/bash

# Simple script for changing the video format (?)
# Add a coproc where to show percentage of completion

# TODO check for correct format
#

# when subproc finishes converting file, send signal to main proc
# 

# $1 file to read from
update_status () {
	status=''
	read -u 11 status
	echo "status was $status"
}

convert_files() {
	for file in ${[FILES[*]}; do
		ffmpeg -y -i $file -map 0:0 -c copy out/${file/.*/.mov} &> /dev/null;
		echo "$?" >> $1
		#kill -n 10 $2 
	done
}


# Get name of files to convert 
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

# create pipe, set handler, start subprocess
11<>pipe.$$.tmp

#trap update_status SIGUSR1
convert_files FILES &
#
## wait for child to exit
#wait
11<&-
#rm pipe.$$.tmp
