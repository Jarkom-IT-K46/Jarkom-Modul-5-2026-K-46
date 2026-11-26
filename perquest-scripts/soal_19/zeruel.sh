#!/bin/sh
# Soal 19
#   - Zeruel (tetangga satu switch): lalu lintas Armisael-Zeruel tidak lewat router,
#     jadi diblokir di Zeruel sendiri. Hanya lalu lintas dari/ke Armisael yang
#     dibuang, sehingga Zeruel tidak ikut terhukum.
#   - Listener TCP 9000, lalu uji ping dan nc ke Seele (8.8.8.8 TCP 53) dan Lilith.

ARMISAEL_IP=192.234.4.83
ARMISAEL_MAC=02:42:9e:4d:4b:00

# Isolasi Armisael
iptables -N ISOLASI_MASUK 2>/dev/null
iptables -F ISOLASI_MASUK
iptables -A ISOLASI_MASUK -m mac --mac-source $ARMISAEL_MAC -j DROP
iptables -A ISOLASI_MASUK -s $ARMISAEL_IP -j DROP
iptables -D INPUT -j ISOLASI_MASUK 2>/dev/null
iptables -I INPUT 1 -j ISOLASI_MASUK

iptables -N ISOLASI_KELUAR 2>/dev/null
iptables -F ISOLASI_KELUAR
iptables -A ISOLASI_KELUAR -d $ARMISAEL_IP -j DROP
iptables -D OUTPUT -j ISOLASI_KELUAR 2>/dev/null
iptables -I OUTPUT 1 -j ISOLASI_KELUAR
iptables -S

# Listener TCP 9000
pkill -f "nc-listener-9000" 2>/dev/null
pkill -f "nc -d -v -n -l 9000" 2>/dev/null
: > /root/nc_9000.log
setsid sh -c "while true; do nc -d -v -n -l 9000 >> /root/nc_9000.log 2>&1; done # nc-listener-9000" \
    < /dev/null > /dev/null 2>&1 &
sleep 1

# Uji
echo "== ping Seele 8.8.8.8"
ping -c 3 -W 2 8.8.8.8 | tail -2
echo "== nc Seele 8.8.8.8:53"
nc -v -n -z -w 3 8.8.8.8 53; echo "exit=$?"
echo "== ping Lilith"
ping -c 3 -W 2 192.234.4.74 | tail -2
echo "== nc Lilith:9000"
echo "Halo dari Zeruel" | nc -v -n -N -w 3 192.234.4.74 9000; echo "exit=$?"
