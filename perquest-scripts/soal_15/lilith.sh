#!/bin/sh
# Soal 15
#   - Lilith: uji batas ping Tokyo3-Core (192.234.4.106).

echo "== ping rapat: 10 ping/detik, sebagian harus hilang"
ping -i 0.1 -c 50 192.234.4.106 | tail -2

# Tunggu token limit terisi kembali setelah ping rapat
sleep 3

echo "== ping biasa: jeda 3 detik, semua harus berhasil"
ping -i 3 -c 5 192.234.4.106 | tail -2
