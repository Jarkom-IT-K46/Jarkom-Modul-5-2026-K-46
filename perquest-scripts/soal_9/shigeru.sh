#!/bin/sh

ip route replace default via 192.234.4.165 dev eth0
ip route del blackhole 192.234.4.72/29 2>/dev/null || true
sysctl -w net.ipv4.ip_forward=1
ip rule del pref 90 iif eth1 table 100 2>/dev/null || true
ip route del unreachable default table 100 2>/dev/null || true
