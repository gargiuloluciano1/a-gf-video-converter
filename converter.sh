#!/bin/bash

pipe="pipe.$$.tmp"
rm -f ${pipe}

declare -i old_time
declare -i current_time

FILES=''
echo "Please insert name of file(s)"
read FILES
for file in FILES; do
{	
	#check if its a file
	if []
}


# TODO need way to kill shell when ^C
(old_time=` stat -c %Y ${pipe} `
 while [ 1 ]; do
	 sleep 1
	 current_time=` stat -c %Y ${pipe} `
	 if (( current_time != old_time )); then
		 read < ${pipe}
		 echo "was read: $REPLY"

	 fi;
 done
) &


declare -i i
for (( i=0; i < 10; i++ )); do
	ffmpeg -y -i $file -map 0:0 -c copy out/${file/.*/.mov} &> ${pipe};
done
kill -s SIGTERM %1 &> /dev/null

rm -f ${pipe}

unset i
unset old_time
unset current_time
