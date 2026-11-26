#!/bin/sh
# Soal 18
#   - Magi-Casper (subnet Terminal): ping ke zona boleh masuk.

echo "== ping Zeruel (Monolith)"
ping -c 3 -W 2 192.234.4.82 | tail -2
echo "== ping Radar-Array (Radar)"
ping -c 3 -W 2 192.234.4.90 | tail -2
