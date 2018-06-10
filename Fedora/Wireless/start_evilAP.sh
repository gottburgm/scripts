#!/bin/bash
ifconfig wlan0 10.0.0.1/24 up

# start dnsmasq for dhcp & dns resolution (runs in background)
killall dnsmasq
dnsmasq -C dnsmasq.conf

# reroute all port-80 traffic to our machine
iptables -N internet -t mangle
iptables -t mangle -A PREROUTING -j internet
iptables -t mangle -A internet -j MARK --set-mark 99
iptables -t nat -A PREROUTING -m mark --mark 99 -p tcp --dport 80 -j DNAT --to-destination 10.0.0.1
echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -A FORWARD -i eth0 -o wlan0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m mark --mark 99 -j REJECT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# start wifi access point (new terminal)
killall hostapd
hostapd ./hostapd.conf -i wlan0

# start webserver on port 80 (new terminal)
python -m SimpleHTTPServer 80

