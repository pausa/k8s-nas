#!/usr/bin/env bash
docker build . -t localhost:32000/rutorrent-flood:latest
docker push localhost:32000/rutorrent-flood:latest
