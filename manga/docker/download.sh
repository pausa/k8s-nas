#!/bin/bash

function start {
	if [ "$MANGA_PWD" == "$1" ]
	then
		echo "downloading ${@:2}"
		manga-py -d manga ${@:2}
		return $?
	else
		echo "sir, you are not authorized"
		return 2
	fi
}
echo "listening for commands on port 30666"
while read input 
do 
	start $input
	echo "listening for commands on port 30666" 
done < <(nc -q -1 -k -l 30666)
