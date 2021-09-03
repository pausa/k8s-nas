#!/usr/bin/env fish
set UID (id -u)
docker build . -t localhost:32000/vnc:latest --build-arg UID=$UID || exit 1
#docker run -it --rm -u $UID -p15900:5900 vnc
docker push localhost:32000/vnc:latest
