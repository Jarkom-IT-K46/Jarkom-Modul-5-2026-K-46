#!/bin/sh

iptables -t nat -D POSTROUTING \
-s 192.234.4.64/29 \
-o eth0 -j RETURN 2>/dev/null || true

iptables -t nat -C POSTROUTING \
-s 192.234.0.0/16 \
-o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING \
-s 192.234.0.0/16 \
-o eth0 -j MASQUERADE
