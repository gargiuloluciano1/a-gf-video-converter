#!/bin/bash 

#FILE=''
#while ! [ -a "$FILE" ]; do read -p "Please enter filename: " FILE; done
# total size of array ${#FILES[@]}



declare -a FILES
echo "Enter file names"
read FILES

i=''
FILE=''
for ((i=0; i < ${#FILES[@]}; i++ )); do
	FILE=${FILES[$i]}
	while ! [ -a "$FILE" ]; do
		echo "file: $FILE doesnt exist"
		read -p "Do you want to continue? [y/N]: " FILE
		
		if   [ "$FILE" = 'y' ]; then
			unset ;
		elif [ "$FILE" = 'N' ]; then
			;
		else
			;
		fi
done


