#!/bin/sh
# Soal 20
#   - Gendou: pulihkan rute statis yang ditambahkan sendiri (soal 3).
#     `ip route replace` aman dijalankan berulang, sehingga rute tidak dobel.

ip route replace 192.234.0.0/23 via 192.234.4.114   # Quarters (cabang Yui)
ip route replace 192.234.3.0/25 via 192.234.4.114   # Hangar (cabang Yui)
ip route replace 192.234.4.0/27 via 192.234.4.114   # Garden (cabang Yui)
ip route replace 192.234.4.32/28 via 192.234.4.114   # Dock (cabang Yui)
ip route replace 192.234.4.112/28 via 192.234.4.114   # L2-L5 link cabang Yui
ip route replace 192.234.2.0/24 via 192.234.4.110   # Comm (cabang Hikari)
ip route replace 192.234.3.224/27 via 192.234.4.110   # Relay (cabang Hikari)
ip route replace 192.234.4.144/30 via 192.234.4.110   # L10 Hikari-Kaworu
ip route replace 192.234.4.96/30 via 192.234.4.154   # Archive (cabang Asuka)
ip route replace 192.234.3.128/26 via 192.234.4.154   # Bunker (cabang Asuka)
ip route replace 192.234.4.48/29 via 192.234.4.154   # Lab (cabang Asuka)
ip route replace 192.234.4.128/29 via 192.234.4.154   # L6-L7 link cabang Asuka
ip route replace 192.234.4.100/30 via 192.234.4.158   # Intel (Kaji)
ip route replace 192.234.4.64/29 via 192.234.4.162   # Cage (Misato)
ip route replace 192.234.4.80/28 via 192.234.4.166   # Monolith + Radar (cabang Shigeru)
ip route replace 192.234.4.148/30 via 192.234.4.166   # L11 Shigeru-Makoto
ip route replace 192.234.4.56/29 via 192.234.4.170   # Terminal (cabang Fuyutsuki)
ip route replace 192.234.3.192/27 via 192.234.4.170   # Medic (cabang Fuyutsuki)
ip route replace 192.234.4.72/29 via 192.234.4.170   # Dogma (cabang Fuyutsuki)
ip route replace 192.234.4.136/29 via 192.234.4.170   # L8-L9 link cabang Fuyutsuki

ip route
