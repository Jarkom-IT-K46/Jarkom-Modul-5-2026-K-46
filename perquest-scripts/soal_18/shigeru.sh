#!/bin/sh
# Soal 18
#   - Shigeru: gerbang zona sensitif (Switch-Monolith di eth1, Radar lewat Makoto di eth2).
#   - Penolakan berdasarkan arah datang: semua yang masuk dari eth0 (sisi Gendou)
#     diperiksa di chain ZONA_GATE. Subnet luar tidak ditulis satu per satu,
#     sehingga subnet baru di luar zona langsung ikut terblokir.
#   - Isi ZONA_GATE:
#       1. Balasan koneksi yang dimulai dari dalam zona (ESTABLISHED,RELATED).
#       2. Pengecualian: ping (echo-request) dari subnet Terminal 192.234.4.56/29.
#       3. Selain itu (koneksi baru dari luar zona) dibuang.
#   - Lalu lintas dari dalam zona ke mana saja dan antar Monolith-Radar tidak masuk
#     ZONA_GATE, karena tidak datang dari eth0.

TERMINAL=192.234.4.56/29

# Chain khusus agar aman dijalankan berulang
iptables -N ZONA_GATE 2>/dev/null
iptables -F ZONA_GATE
iptables -A ZONA_GATE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A ZONA_GATE -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A ZONA_GATE -j DROP

iptables -D FORWARD -i eth0 -j ZONA_GATE 2>/dev/null
iptables -I FORWARD 1 -i eth0 -j ZONA_GATE

# Bukti
iptables -S
iptables -L FORWARD -v -n -x --line-numbers
iptables -L ZONA_GATE -v -n -x --line-numbers
