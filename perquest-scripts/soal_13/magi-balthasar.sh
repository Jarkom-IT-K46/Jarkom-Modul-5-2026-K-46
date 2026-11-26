#!/bin/sh

iptables -D INPUT -p tcp -m multiport \
--dports 5000,5001 -j REJECT \
--reject-with tcp-reset 2>/dev/null || true

for IP in 192.234.4.58 192.234.4.66 192.234.4.67 192.234.4.68 192.234.3.130
do
    iptables -C INPUT -s "$IP" \
    -p tcp -m multiport \
    --dports 5000,5001 -j ACCEPT 2>/dev/null || \
    iptables -A INPUT -s "$IP" \
    -p tcp -m multiport \
    --dports 5000,5001 -j ACCEPT
done

iptables -A INPUT -p tcp -m multiport \
--dports 5000,5001 -j REJECT \
--reject-with tcp-reset
