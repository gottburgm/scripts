#!/bin/bash

# stop processes
# ctrl+c hostapd
# ctrl+c python simple http server
killall dnsmasq

# reset iptables
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

