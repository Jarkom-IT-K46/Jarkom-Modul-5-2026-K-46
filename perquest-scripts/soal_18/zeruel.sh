#!/bin/sh
# Soal 18
#   - Zeruel (di dalam zona): boleh memulai koneksi ke mana saja,
#     dan balasannya tetap sampai.

echo "== ping 8.8.8.8 (internet)"
ping -c 3 -W 2 8.8.8.8 | tail -2
echo "== ping Lilith"
ping -c 3 -W 2 192.234.4.74 | tail -2
echo "== nc Tokyo3-Core port 80"
nc -v -n -w 3 192.234.4.106 80 < /dev/null; echo "exit=$?"
echo "== ping Radar-Array (sesama zona)"
ping -c 3 -W 2 192.234.4.90 | tail -2
