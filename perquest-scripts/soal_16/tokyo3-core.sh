#!/bin/sh
# Soal 16
#   - Tokyo3-Core: koneksi TCP baru dari Dummy-Plug (192.234.4.51) ke port
#     22, 23, dan 3306 dicatat dengan prefix "SCAN-NERV: " lalu ditolak seketika
#     dengan TCP RST (REJECT --reject-with tcp-reset).
#   - Rule hanya mengenai Dummy-Plug dan ketiga port itu, sehingga port 80/8080
#     dan klien lain tidak terganggu.
#   - Rule dipasang di posisi 1 INPUT agar tidak didahului rule lain.

DUMMY=192.234.4.51

# Chain khusus agar aman dijalankan berulang
iptables -N SCAN_NERV 2>/dev/null
iptables -F SCAN_NERV
iptables -A SCAN_NERV -j LOG --log-prefix "SCAN-NERV: "
iptables -A SCAN_NERV -p tcp -j REJECT --reject-with tcp-reset

iptables -D INPUT -s $DUMMY -p tcp -m multiport --dports 22,23,3306 \
    -m conntrack --ctstate NEW -j SCAN_NERV 2>/dev/null
iptables -I INPUT 1 -s $DUMMY -p tcp -m multiport --dports 22,23,3306 \
    -m conntrack --ctstate NEW -j SCAN_NERV

# Bukti
iptables -S
iptables -L INPUT -v -n -x --line-numbers
iptables -L SCAN_NERV -v -n -x --line-numbers
