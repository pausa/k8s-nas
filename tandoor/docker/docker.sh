#!/usr/bin/env fish
docker build . -t localhost:32000/tandoor-tls:latest || exit 1
docker push localhost:32000/tandoor-tls:latest
