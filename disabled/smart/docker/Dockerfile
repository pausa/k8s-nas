FROM alpine
RUN apk -U add bash smartmontools ssmtp ca-certificates
COPY check.sh  /bin/check.sh
COPY init.sh /bin/init.sh
COPY test.sh  /bin/test.sh
ENTRYPOINT ["/bin/init.sh"]
CMD ["/bin/bash"]
