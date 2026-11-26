#!/bin/sh
# Soal 20
#   - Uji kebakaran: simpan rule, hapus semua rule dan rute sendiri,
#     lalu pulihkan dua kali berturut-turut. Dijalankan di Gendou, Fuyutsuki, dan Shigeru.
#   - Nama file mengikuti hostname: /root/<nama>.rules dan /root/<nama>.sh.

NAMA=$(hostname | tr 'A-Z' 'a-z')
RULES=/root/$NAMA.rules
RUTE=/root/$NAMA.sh

hitung() {
    echo "-- $1: iptables -S=$(iptables -S | wc -l) baris," \
         "iptables -t nat -S=$(iptables -t nat -S | wc -l) baris," \
         "ip route=$(ip route | wc -l) baris"
}

# Isi rule dan rute, untuk membandingkan hasil pemulihan
snapshot() {
    iptables -S
    iptables -t nat -S
    ip route
}

echo "== 1. Simpan rule ke $RULES"
iptables-save > $RULES
hitung "awal"
snapshot > /tmp/soal20_awal.txt

echo "== 2. Hapus semua rule (filter dan nat) dan rute sendiri"
for T in filter nat; do
    iptables -t $T -F
    iptables -t $T -X
done
for CH in INPUT FORWARD OUTPUT; do iptables -P $CH ACCEPT; done
# Hanya rute yang tercantum di script pemulihan yang dihapus
grep '^ip route replace' $RUTE | sed 's/#.*//; s/replace/del/' | while read CMD; do $CMD; done
hitung "setelah dihapus"

echo "== 3. Pemulihan pertama"
iptables-restore < $RULES
sh $RUTE > /dev/null
hitung "pemulihan 1"
snapshot > /tmp/soal20_pulih1.txt

echo "== 4. Pemulihan kedua"
iptables-restore < $RULES
sh $RUTE > /dev/null
hitung "pemulihan 2"
snapshot > /tmp/soal20_pulih2.txt

echo "== 5. Perbandingan isi"
cmp -s /tmp/soal20_pulih1.txt /tmp/soal20_pulih2.txt && echo "pemulihan 1 == pemulihan 2" || diff /tmp/soal20_pulih1.txt /tmp/soal20_pulih2.txt
cmp -s /tmp/soal20_awal.txt /tmp/soal20_pulih2.txt && echo "awal == pemulihan 2" || diff /tmp/soal20_awal.txt /tmp/soal20_pulih2.txt
