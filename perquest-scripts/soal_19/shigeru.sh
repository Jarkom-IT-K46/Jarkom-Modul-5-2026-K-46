#!/bin/sh
# Soal 19
#   - Shigeru (gateway Switch-Monolith): isolasi Armisael dari gateway dan dari
#     semua tujuan di luar switch. Isolasi tidak dikerjakan di dalam Armisael.
#   - Paket dari Armisael dikenali dari MAC dan IP-nya, sehingga mengganti IP
#     tidak meloloskannya. Paket menuju Armisael dikenali dari IP tujuan.
#   - Chain isolasi dipasang di posisi 1 INPUT, OUTPUT, dan FORWARD,
#     sebelum ZONA_GATE dari soal 18.

ARMISAEL_IP=192.234.4.83
ARMISAEL_MAC=02:42:9e:4d:4b:00

# Paket dari Armisael (MAC dan IP). Match MAC hanya berlaku untuk paket masuk,
# jadi chain ini dipakai di INPUT dan FORWARD.
iptables -N ISOLASI_MASUK 2>/dev/null
iptables -F ISOLASI_MASUK
iptables -A ISOLASI_MASUK -m mac --mac-source $ARMISAEL_MAC -j DROP
iptables -A ISOLASI_MASUK -s $ARMISAEL_IP -j DROP

# Paket menuju Armisael, dipakai di OUTPUT dan FORWARD.
iptables -N ISOLASI_KELUAR 2>/dev/null
iptables -F ISOLASI_KELUAR
iptables -A ISOLASI_KELUAR -d $ARMISAEL_IP -j DROP

for CH in INPUT FORWARD; do
    iptables -D $CH -j ISOLASI_MASUK 2>/dev/null
    iptables -I $CH 1 -j ISOLASI_MASUK
done
for CH in OUTPUT FORWARD; do
    iptables -D $CH -j ISOLASI_KELUAR 2>/dev/null
    iptables -I $CH 1 -j ISOLASI_KELUAR
done

# Bukti
iptables -S
