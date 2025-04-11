#!/bin/bash

print_hello () {
	for((i=0;i<10;++i)); do
		echo "$i";
	done;
}

# subprocess runs in background 
# will be the ffmpeg converter 
coproc NAME { print_hello; }

# process reads from stdout,
# prints everything necessary
INPUT=''
while { read -u ${NAME[0]} INPUT; }; do
	
done

