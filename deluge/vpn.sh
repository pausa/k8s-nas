#!/bin/bash
docker pull dperson/openvpn-client
docker container stop vpn
docker container rm vpn
docker run \
	--device /dev/net/tun \
	--name vpn \
	--cap-add=NET_ADMIN \
	-v ~/.config/vpn:/vpn:rw \
	-p 8112:8112 \
	-p 58846:58846 \
	-p 58946:58946 \
	-p 58946:58946/udp \
	-p 8000:8000 \
	-d dperson/openvpn-client \
	-r 192.168.178.0/24 \
	-r 172.22.0.0/16 \
	-v 'ams.tigervpn.com;tiger6029756;CBJAeAShd'
