#!/bin/sh

iptables -t nat -D POSTROUTING \
-s 192.234.4.64/29 \
! -d 192.234.0.0/16 \
-o eth0 -j SNAT \
--to-source 172.31.99.1 2>/dev/null || true
