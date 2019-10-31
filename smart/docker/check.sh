#!/bin/bash
for dev in `ls -d1 /scanning/*`
do
	ERRORS=$(smartctl -l selftest -d sat $dev | grep 'Extended offline' | grep -v 'without error' | wc -l)
	if [[ $ERRORS -ne 0 ]]; then
		#TODO send email
		FULL_LOG=$(smartctl -d sat -a $dev)
		echo "$FULL_LOG"
		echo "$dev is BROKEN"
	else
		echo "$dev is fine, great!"
	fi
done
