#!/bin/sh
# Soal 19
#   - Armisael: hanya listener TCP 9000 dan uji. Tidak ada rule isolasi di sini.
#     Semua uji ke Seele (8.8.8.8 TCP 53), Zeruel, Lilith, dan gateway harus gagal.

pkill -f "nc-listener-9000" 2>/dev/null
pkill -f "nc -d -v -n -l 9000" 2>/dev/null
: > /root/nc_9000.log
setsid sh -c "while true; do nc -d -v -n -l 9000 >> /root/nc_9000.log 2>&1; done # nc-listener-9000" \
    < /dev/null > /dev/null 2>&1 &
sleep 1
iptables -S

echo "== ping Seele 8.8.8.8"
ping -c 3 -W 2 8.8.8.8 | tail -2
echo "== nc Seele 8.8.8.8:53"
nc -v -n -z -w 3 8.8.8.8 53; echo "exit=$?"
echo "== ping Zeruel"
ping -c 3 -W 2 192.234.4.82 | tail -2
echo "== nc Zeruel:9000"
echo "Halo dari Armisael" | nc -v -n -N -w 3 192.234.4.82 9000; echo "exit=$?"
echo "== ping Lilith"
ping -c 3 -W 2 192.234.4.74 | tail -2
echo "== nc Lilith:9000"
echo "Halo dari Armisael" | nc -v -n -N -w 3 192.234.4.74 9000; echo "exit=$?"
echo "== ping gateway Shigeru"
ping -c 3 -W 2 192.234.4.81 | tail -2
