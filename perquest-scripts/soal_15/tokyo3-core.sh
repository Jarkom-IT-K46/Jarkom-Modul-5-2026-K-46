#!/bin/sh
# Soal 15
#   - Tokyo3-Core: jawab maksimal 5 ping per detik, kelebihannya dibuang.
#   - Hanya echo-request (ping masuk) yang dibatasi. Balasan untuk ping yang
#     dikirim Tokyo3-Core sendiri adalah echo-reply, sehingga tidak terkena.
#   - Rule dipasang di posisi 1 INPUT. Ping kedua dan seterusnya dengan id yang
#     sama dianggap ESTABLISHED oleh conntrack, jadi rule ACCEPT ESTABLISHED
#     di atasnya akan meloloskan banjir ping.

# Chain khusus agar aman dijalankan berulang
iptables -N PING_LIMIT 2>/dev/null
iptables -F PING_LIMIT
iptables -A PING_LIMIT -m limit --limit 5/second --limit-burst 5 -j ACCEPT
iptables -A PING_LIMIT -j DROP

iptables -D INPUT -p icmp --icmp-type echo-request -j PING_LIMIT 2>/dev/null
iptables -I INPUT 1 -p icmp --icmp-type echo-request -j PING_LIMIT

# Permanen: simpan dan pulihkan setiap eth0 naik
iptables-save > /etc/iptables.rules
grep -q iptables-restore /etc/network/interfaces ||
    sed -i '/^iface eth0 inet static/a\    up iptables-restore < /etc/iptables.rules' /etc/network/interfaces

# Bukti
iptables -S
cat /etc/network/interfaces
iptables -L INPUT -v -n -x --line-numbers
iptables -L PING_LIMIT -v -n -x --line-numbers
