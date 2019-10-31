#!/bin/bash
function send_error_mail {
	local DEVICE=$1
	local BODY=$2
	sendmail -t << EOF
To: $MAIL_TO
From: $HOSTNAME
Subject: S.M.A.R.T. Error for device: `basename $DEVICE`

Smart self tests were not successful, please consider replacing the device.

Here the full log:
$BODY
EOF

}

for dev in `ls -d1 /scanning/*`
do
	ERRORS=$(smartctl -l selftest -d sat $dev | grep 'Extended offline' | grep -v 'without error' | wc -l)
	if [[ $ERRORS -ne 0 ]]; then
		FULL_LOG=$(smartctl -d sat -a $dev)
		echo "$FULL_LOG"
		echo "$dev is BROKEN"
		send_error_mail $dev "$FULL_LOG"

	else
		echo "$dev is fine, great!"
	fi
done
