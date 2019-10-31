FROM alpine
RUN apk -U add bash smartmontools ssmtp
#COPY test.sh  /bin/test.sh
COPY check.sh  /bin/check.sh
ENTRYPOINT ["/bin/bash"]
