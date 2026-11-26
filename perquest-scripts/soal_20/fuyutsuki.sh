#!/bin/sh
# Soal 20
#   - Fuyutsuki: pulihkan rute statis yang ditambahkan sendiri (soal 3).
#     `ip route replace` aman dijalankan berulang, sehingga rute tidak dobel.

ip route replace default via 192.234.4.169   # Gendou
ip route replace 192.234.3.192/27 via 192.234.4.138   # Medic (Maya)
ip route replace 192.234.4.72/29 via 192.234.4.142   # Dogma (Toji)

ip route
