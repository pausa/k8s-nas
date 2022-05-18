#!/usr/bin/env fish
docker run -it --rm \
    -v ~/.config/synapse:/data \
    -e SYNAPSE_SERVER_NAME=madpausa.sytes.net \
    -e SYNAPSE_REPORT_STATS=yes \
    -e UID=1000 \
    -e GID=1000 \
    matrixdotorg/synapse:latest generate
