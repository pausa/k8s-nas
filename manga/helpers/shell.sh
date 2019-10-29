#!/bin/bash
## Helper script to send right commands to manga pod
function ask {
	MARGS='--no-webp --cbz --rename-pages'
	read -ep 'manga url: ' URL
	[ -z "$URL" ] && echo 'specify a url' && return 1
	read -ep 'force manga name: ' MNAME
	[ -z "$MNAME" ] || MARGS="$MARGS -n $MNAME"
	read -ep 'skip chapters: ' MSKIP
	[ -z "$MSKIP" ] || MARGS="$MARGS -s $MSKIP"
	echo "starting download with params: $MARGS $URL"
	echo "$MANGA_PWD $MARGS $URL" | nc localhost 30666 -w0
	return $?
}

ask \
&& echo "started, check logs for progress" \
|| echo "there was a problem, try again"
