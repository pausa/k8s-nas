FROM alpine
RUN apk -U add bash rsync
COPY backup.sh  /bin/backup.sh
ENTRYPOINT ["/bin/backup.sh"]
