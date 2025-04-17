#!/bin/bash

#TODO hide notification for start/end of jobs    ^
#TODO check for any major script error		 | order of importance
#TODO check if file is video format		 | todos
#TODO check, do i need to unset vars in bash?	 |
#TODO overall cleanup of script			 +


#create and open pipe
pipe="pipe.tmp"
rm -f ${pipe}
>${pipe}


FILES=''
echo "Insert file name"
read FILES

# check file exist 
for file in "$FILES"; do
	if ! [  -a "${file}" ]; then
		# file doesnt exist
		# exit for now
		exit -1
	fi
	if [ -d "${file}" ]; then
		# directory
		echo "is dir"
	fi
done



## bg shell reads from pipe, prints status in the stdin
function print_status () {

echo -ne '\033[01;33m'
	echo '
	  \,`/ / 
	 _)..  `_
	( __  -\
	    ``.                  
	} }_ ( \>_-_,    W< '
	echo -e '\033[0;0m'
	if [ -z $2 ]; then
		echo -ne "File "${1}" loaded succesfully\r"
	
	else    
		echo -ne "File "${1}" loaded unsuccesfully\r";
	fi
}

declare -a LOAD=('/' '|' '-' '|' '\' '-' )
declare -i counter=0
TAG="#"
loading_bar () {
	if (( counter > 5 )); then let counter=0; fi
	echo -n  "${LOAD[$counter]}                                     "                                     
	let ++counter
	echo -ne "\r"

}

declare -i old_time current_time
# check each second for update
# TODO may want to bg process in same shell env
{ (
	old_time=` stat -c %Y ${pipe} ` 
	while [ 1 ]; do 
		sleep 0.2
		current_time=` stat -c %Y ${pipe} `
		if  (($current_time>${old_time})); then
			old_time=${current_time}
			loaded=`awk '/from/ { print $5 }' <${pipe}`
			result=``
			# $1 name of file
			# $2 result of download
			#
			print_status $loaded
		else
			loading_bar ;
		fi	
	done
) & }

OUT_DIR="out"
mkdir -p "${OUT_DIR}"
for file in "${FILES}"; do 
	ffmpeg -y -i "$file" -map 0:0 -c copy ${OUT_DIR}/out.mov &> ${pipe};
done
sleep 10
echo
{ kill -n 9 %%; } &> /dev/null
