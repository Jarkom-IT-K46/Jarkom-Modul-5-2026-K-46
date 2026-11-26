#!/bin/sh
# Soal 20
#   - Shigeru: pulihkan rute statis yang ditambahkan sendiri (soal 3).
#     `ip route replace` aman dijalankan berulang, sehingga rute tidak dobel.

ip route replace default via 192.234.4.165   # Gendou
ip route replace 192.234.4.88/29 via 192.234.4.150   # Radar (Makoto)

ip route
