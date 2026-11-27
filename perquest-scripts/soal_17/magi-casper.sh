#!/bin/sh
# Soal 17
#   - Magi-Casper: kirim pesan ke IP Zeruel (192.234.4.82) port 9000.
#     -v menampilkan alamat yang dilihat Casper: koneksi tetap terlihat ke Zeruel.
#   - nc.openbsd dipanggil langsung: soal 7 mengarahkan nc ke nc.traditional,
#     yang tidak mengenal opsi -N.
#   - Ping ke Zeruel tidak dialihkan.

echo "Pesan rahasia Casper untuk Zeruel" | nc.openbsd -v -n -N -w 3 192.234.4.82 9000
echo "exit=$?"

ping -c 3 192.234.4.82 | tail -2
