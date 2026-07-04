#!/usr/bin/env fish
set GUEST_IP 192.168.122.166
set GUEST_PORT 58846
set HOST_PORT $GUEST_PORT
/sbin/iptables -I FORWARD -o virbr0 -p tcp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
/sbin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT

/sbin/iptables -I FORWARD -o virbr0 -p udp -d $GUEST_IP --dport $GUEST_PORT -j ACCEPT
/sbin/iptables -t nat -I PREROUTING -p udp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
