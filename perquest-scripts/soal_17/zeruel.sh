#!/bin/sh
# Soal 17
#   - Zeruel: listener TCP 9000 (pembanding, seharusnya tidak menerima pesan).
#     Pesan dan IP pengirim dicatat di /root/nc_9000.log.
#   - nc (OpenBSD) berhenti setelah satu koneksi, jadi dijalankan ulang dalam loop.
#     -d: tidak membaca stdin, hanya menerima.

pkill -f "nc-listener-9000" 2>/dev/null
pkill -f "nc -d -v -n -l 9000" 2>/dev/null
: > /root/nc_9000.log
setsid sh -c "while true; do nc -d -v -n -l 9000 >> /root/nc_9000.log 2>&1; done # nc-listener-9000" \
    < /dev/null > /dev/null 2>&1 &
sleep 1

# Bukti
ss -tlnp | grep 9000
