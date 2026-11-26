#!/bin/sh

iptables -C INPUT -p icmp \
--icmp-type echo-request -j DROP 2>/dev/null || \
iptables -I INPUT 1 -p icmp \
--icmp-type echo-request -j DROP
