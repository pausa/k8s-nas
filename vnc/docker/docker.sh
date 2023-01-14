#!/usr/bin/env fish
docker stop vnc2
set UID (id -u)
docker build . -t localhost:32000/vnc2:latest --build-arg UID=$UID || exit 1
#docker run -d --rm -u 0 \
#	--security-opt seccomp=unconfined \
#	--name vnc2 -p15900:5900 localhost:32000/vnc2:latest
#docker logs vnc2 -f
docker push localhost:32000/vnc2:latest
