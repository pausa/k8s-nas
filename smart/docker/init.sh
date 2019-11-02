#!/bin/bash
## Initializing config files based on env
echo "creating /etc/ssmtp/ssmtp.conf"
cat << EOF > /etc/ssmtp/ssmtp.conf
root=$MAIL_TO
mailhub=$SMTP_SERVER
rewriteDomain=$MAIL_DOMAIN
hostname=$HOSTNAME
TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
UseTLS=Yes
UseSTARTTLS=Yes
AuthUser=$MAIL_USR
AuthPass=$MAIL_PWD
AuthMethod=LOGIN
FromLineOverride=Yes
EOF

echo "Finished initialization, starting: $@"
$@
