#!/bin/bash

declare -a FILE
echo "insert a file"
read -a FILE

ffmpeg -y -i $FILE -map 0:0 -c copy output.mov &> /dev/null
if [[ $? == 0 ]] then 
	echo "ffmpeg succeded";
fi
