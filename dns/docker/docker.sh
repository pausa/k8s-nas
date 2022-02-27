#!/usr/bin/env fish
docker pull cytopia/bind:latest || exit 1
docker tag cytopia/bind:latest localhost:32000/dns:latest
docker push localhost:32000/dns:latest
