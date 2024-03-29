#!/bin/bash
SRC=${SRC:-src}
DST=${DST:-dst}
echo "src: $SRC -> dst: $DST"
if [ -d "$DST" ]; then
	echo "backing up"
	rsync -zavh --delete $SRC/ $DST
	date > $DST/backup-time
else
	echo "not backing up since $DST is not available"
fi
