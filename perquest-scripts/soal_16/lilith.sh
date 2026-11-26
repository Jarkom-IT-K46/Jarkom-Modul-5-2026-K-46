#!/bin/sh
# Soal 16
#   - Lilith: klien lain, tidak boleh terganggu dan tidak tercatat.
#     Port 22, 23, 3306 tetap ditolak kernel (tidak ada listener), port 80 dan 8080 berhasil.
#     Durasi dan exit code menjadi bukti ditolak seketika, bukan menggantung.

probe() {
    start=$(date +%s%N)
    out=$(nc -v -n -w 5 $1 $2 < /dev/null 2>&1)
    rc=$?
    ms=$(( ($(date +%s%N) - start) / 1000000 ))
    echo "== $1:$2 exit=$rc durasi=${ms}ms"
    echo "$out"
}

for port in 22 23 3306 80 8080; do
    probe 192.234.4.106 $port
done
