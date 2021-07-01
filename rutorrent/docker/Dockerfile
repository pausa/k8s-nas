FROM romancin/rutorrent-flood:0.9.8-v5.0.1

RUN apk add openvpn ca-certificates

COPY run-flood /etc/services.d/flood/run
COPY run-openvpn /etc/services.d/openvpn/run
COPY run-rutorrent /etc/services.d/rutorrent/run

