#!/bin/sh

iptables -D INPUT -p icmp -j DROP 2>/dev/null || true
iptables -D OUTPUT -p udp --dport 53 -j DROP 2>/dev/null || true

iptables -C INPUT -i lo -j ACCEPT 2>/dev/null || \
iptables -I INPUT 1 -i lo -j ACCEPT

iptables -C INPUT -m conntrack \
--ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null || \
iptables -I INPUT 1 -m conntrack \
--ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -C INPUT -p icmp \
--icmp-type echo-request -j DROP 2>/dev/null || \
iptables -A INPUT -p icmp \
--icmp-type echo-request -j DROP

iptables -C INPUT -p tcp --dport 5000 -j ACCEPT 2>/dev/null || \
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

iptables -P INPUT DROP
