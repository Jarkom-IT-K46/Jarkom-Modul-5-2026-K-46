#!/bin/sh
# Soal 17
#   - Fuyutsuki (gateway Switch-Terminal): alihkan setiap koneksi TCP dari
#     Magi-Casper (192.234.4.58) ke Zeruel (192.234.4.82) ke Pen-Pen (192.234.3.195).
#   - DNAT di PREROUTING mengubah tujuan paket pertama sebelum routing.
#     Conntrack mengingat terjemahannya, sehingga balasan dari Pen-Pen
#     dikembalikan sumbernya menjadi Zeruel. Casper tidak sadar.
#   - Hanya TCP (-p tcp), sehingga ping tidak dialihkan.
#   - Port tidak diubah, jadi port 9000 di Zeruel menjadi port 9000 di Pen-Pen.

RULE="PREROUTING -i eth1 -s 192.234.4.58 -d 192.234.4.82 -p tcp -j DNAT --to-destination 192.234.3.195"

# Tool untuk menampilkan tabel conntrack
command -v conntrack >/dev/null || apk add -q conntrack-tools

# Pasang sekali saja (aman dijalankan berulang)
iptables -t nat -D $RULE 2>/dev/null
iptables -t nat -A $RULE

# Bukti
iptables -t nat -L PREROUTING -v -n -x --line-numbers
