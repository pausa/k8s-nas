###################################################################################
# Based on node, since it needs it
###################################################################################

# Set the base image to alpine
# FROM arm32v7/node:alpine
FROM node:lts-alpine

ARG MANGA_USER=mangauser
ARG MANGA_HOME=/home/mangauser

RUN adduser -D ${MANGA_USER}

RUN apk -U add python3 \
 gcc libxml2-dev libxslt-dev python3-dev libc-dev \
 jpeg-dev zlib-dev \
 libffi-dev openssl-dev \
 g++ \
 nmap-ncat \
 bash 

RUN pip3 install --upgrade pip
RUN pip3 install lxml pillow

RUN pip3 install manga-py

USER ${MANGA_USER}

RUN mkdir ${MANGA_HOME}/bin
ENV PATH=${MANGA_HOME}/bin:${PATH}

RUN mkdir ${MANGA_HOME}/manga

EXPOSE 30666
VOLUME ${MANGA_HOME}/manga

WORKDIR ${MANGA_HOME}/

COPY download.sh ${MANGA_HOME}/bin/

ENTRYPOINT ["/bin/bash","bin/download.sh"]
