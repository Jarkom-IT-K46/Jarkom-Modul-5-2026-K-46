#!/bin/sh
# Soal 18
#   - Lilith (di luar zona, bukan Terminal): tidak boleh memulai koneksi ke zona.

echo "== ping Zeruel (Monolith)"
ping -c 3 -W 2 192.234.4.82 | tail -2
echo "== ping Radar-Array (Radar)"
ping -c 3 -W 2 192.234.4.90 | tail -2
echo "== nc Zeruel port 9000"
nc -v -n -w 3 192.234.4.82 9000 < /dev/null; echo "exit=$?"
