#!/bin/sh
set -e

# Jadwal UTC (WIB - 7 jam)
PILOT_START="${PILOT_START:-01:00}"
PILOT_STOP="${PILOT_STOP:-09:00}"
PILOT_DAYS="${PILOT_DAYS:-Mon,Tue,Wed,Thu,Fri}"

STAF_START="${STAF_START:-10:00}"
STAF_STOP="${STAF_STOP:-16:00}"

PILOT_IP="192.234.4.66 192.234.4.67 192.234.4.68 192.234.3.130"
STAF_IP="192.234.4.74 192.234.4.75"
DUMMY_IP="192.234.4.51 192.234.4.50 192.234.4.102"

# Membuat chain khusus
iptables -N PENPEN_TIME 2>/dev/null || true
iptables -F PENPEN_TIME

# Dummy System
for IP in $DUMMY_IP; do
    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

# Jadwal Pilot
for IP in $PILOT_IP; do
    iptables -A PENPEN_TIME -s "$IP" \
        -m time --timestart "$PILOT_START" \
        --timestop "$PILOT_STOP" \
        --weekdays "$PILOT_DAYS" -j ACCEPT

    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

# Jadwal Staf Geofront
for IP in $STAF_IP; do
    iptables -A PENPEN_TIME -s "$IP" \
        -m time --timestart "$STAF_START" \
        --timestop "$STAF_STOP" -j ACCEPT

    iptables -A PENPEN_TIME -s "$IP" -j DROP
done

# Node lainnya
iptables -A PENPEN_TIME -j ACCEPT

# Pembatasan ping
iptables -C INPUT -p icmp --icmp-type echo-request \
-j PENPEN_TIME 2>/dev/null || \
iptables -I INPUT 1 -p icmp --icmp-type echo-request \
-j PENPEN_TIME

# Pembatasan TCP 80
iptables -C INPUT -p tcp --dport 80 \
-j PENPEN_TIME 2>/dev/null || \
iptables -I INPUT 1 -p tcp --dport 80 \
-j PENPEN_TIME
