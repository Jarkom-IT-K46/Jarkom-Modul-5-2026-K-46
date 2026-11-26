#!/bin/sh
# Soal 19
#   - Lilith: listener TCP 9000 untuk uji nc dari Armisael dan Zeruel.

pkill -f "nc-listener-9000" 2>/dev/null
pkill -f "nc -d -v -n -l 9000" 2>/dev/null
: > /root/nc_9000.log
setsid sh -c "while true; do nc -d -v -n -l 9000 >> /root/nc_9000.log 2>&1; done # nc-listener-9000" \
    < /dev/null > /dev/null 2>&1 &
sleep 1

# Bukti
ss -tlnp | grep 9000
