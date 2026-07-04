#!/usr/bin/env fish
# docker build . -t localhost:32000/caddy:latest || exit 1
# docker push localhost:32000/caddy:latest
docker build . --no-cache -t pausa-caddy:latest || exit 1
