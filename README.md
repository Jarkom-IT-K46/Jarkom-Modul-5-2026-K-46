# Jarkom Modul 5 K-46

| 	Nama              	| NRP        | Pembagian Pengerjaaan  |
| ---------------------	| ---------- | ---------------------- |
| Hendra Manudinata 	| 5027251051 | Babak 1 (soal 1-8) dan Babak 3 (soal 13-19) |
| Daffa Rifqi As Shidiq	| 5027251038 | Babak 2 (soal 9-12) |

* Kelompok: K-46
* Prefix IP: 192.234.x.x
* Project GNS3: `K-46-MODUL-5`

Struktur repository:

* `subnetting/` berisi tabel VLSM (`vlsm.md`, `vlsm.csv`), IP tiap node (`ip-node.csv`), dan pohon IP (`pohon-ip.png`, `pohon-ip.svg`).
* `perquest-scripts/soal_N/<node>.sh` berisi script tiap soal. Script dikirim ke node sebagai `/root/soal_N.sh` lalu dijalankan.

---

## Soal 1
**Markas tanpa peta:** tengah malam alarm meraung, dan Ritsuko terdiam. Markas sebesar ini dibangun tanpa peta alamat. Gendo anti pemborosan, jadi tiap subnet memakai **prefix terkecil yang muat**. Bagi prefix IP kelompokmu dengan **VLSM** untuk **17 LAN dan 16 link antar-router**, urut dari kebutuhan terbesar. Tunjukkan **tabel** berisi network, prefix, gateway, broadcast, IP terpakai, dan sisa. Tunjukkan juga **gambar pohon IP**, dengan subnet jalur **Dummy-Plug ke Armisael dilingkari**. Di laporan, jelaskan hitungan satu subnet.

### Jawaban dan Penjelasan

#### 1. Aturan Pembagian

* Kebutuhan alamat tiap LAN = jumlah host + 1 (gateway). Link antar-router selalu butuh 2 alamat.
* Prefix dipilih yang terkecil dengan jumlah usable `2^(32 - prefix) - 2` yang masih muat.
* Subnet diurutkan dari blok terbesar. Jika ukurannya sama, LAN didahulukan daripada link, lalu mengikuti urutan tabel.
* Gateway memakai IP usable pertama. Node pada switch memakai IP berikutnya sesuai urutan nama di gambar (kiri ke kanan).
* Pada link, IP pertama untuk router atas (arah Gendou) dan IP kedua untuk router bawah.
* Urutan link disusun agar subnet satu cabang bisa diringkas tepat menjadi satu CIDR pada soal 3.

#### 2. Tabel VLSM

<details>
<summary>Tabel VLSM (33 subnet: 17 LAN + 16 link)</summary>

| No | Subnet | Kebutuhan | Prefix | Network | Gateway | Broadcast | Usable | Terpakai | Sisa |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Switch-Quarters | 501 | /23 | 192.234.0.0 | 192.234.0.1 | 192.234.1.255 | 510 | 501 | 9 |
| 2 | Switch-Comm | 201 | /24 | 192.234.2.0 | 192.234.2.1 | 192.234.2.255 | 254 | 201 | 53 |
| 3 | Switch-Hangar | 101 | /25 | 192.234.3.0 | 192.234.3.1 | 192.234.3.127 | 126 | 101 | 25 |
| 4 | Switch-Bunker | 56 | /26 | 192.234.3.128 | 192.234.3.129 | 192.234.3.191 | 62 | 56 | 6 |
| 5 | Switch-Medic | 27 | /27 | 192.234.3.192 | 192.234.3.193 | 192.234.3.223 | 30 | 27 | 3 |
| 6 | Switch-Relay | 26 | /27 | 192.234.3.224 | 192.234.3.225 | 192.234.3.255 | 30 | 26 | 4 |
| 7 | Switch-Garden | 15 | /27 | 192.234.4.0 | 192.234.4.1 | 192.234.4.31 | 30 | 15 | 15 |
| 8 | Switch-Dock | 13 | /28 | 192.234.4.32 | 192.234.4.33 | 192.234.4.47 | 14 | 13 | 1 |
| 9 | Switch-Lab | 6 | /29 | 192.234.4.48 | 192.234.4.49 | 192.234.4.55 | 6 | 6 | 0 |
| 10 | Switch-Terminal | 4 | /29 | 192.234.4.56 | 192.234.4.57 | 192.234.4.63 | 6 | 4 | 2 |
| 11 | Switch-Cage | 4 | /29 | 192.234.4.64 | 192.234.4.65 | 192.234.4.71 | 6 | 4 | 2 |
| 12 | Switch-Dogma | 3 | /29 | 192.234.4.72 | 192.234.4.73 | 192.234.4.79 | 6 | 3 | 3 |
| 13 | Switch-Monolith | 3 | /29 | 192.234.4.80 | 192.234.4.81 | 192.234.4.87 | 6 | 3 | 3 |
| 14 | Switch-Radar | 5 | /29 | 192.234.4.88 | 192.234.4.89 | 192.234.4.95 | 6 | 5 | 1 |
| 15 | Switch-Archive | 2 | /30 | 192.234.4.96 | 192.234.4.97 | 192.234.4.99 | 2 | 2 | 0 |
| 16 | Switch-Intel | 2 | /30 | 192.234.4.100 | 192.234.4.101 | 192.234.4.103 | 2 | 2 | 0 |
| 17 | Switch-Cmd | 2 | /30 | 192.234.4.104 | 192.234.4.105 | 192.234.4.107 | 2 | 2 | 0 |
| 18 | L1 Gendou-Hikari | 2 | /30 | 192.234.4.108 | 192.234.4.109 | 192.234.4.111 | 2 | 2 | 0 |
| 19 | L2 Gendou-Yui | 2 | /30 | 192.234.4.112 | 192.234.4.113 | 192.234.4.115 | 2 | 2 | 0 |
| 20 | L3 Yui-Mari | 2 | /30 | 192.234.4.116 | 192.234.4.117 | 192.234.4.119 | 2 | 2 | 0 |
| 21 | L4 Yui-Rei | 2 | /30 | 192.234.4.120 | 192.234.4.121 | 192.234.4.123 | 2 | 2 | 0 |
| 22 | L5 Yui-Shinji | 2 | /30 | 192.234.4.124 | 192.234.4.125 | 192.234.4.127 | 2 | 2 | 0 |
| 23 | L6 Asuka-Kensuke | 2 | /30 | 192.234.4.128 | 192.234.4.129 | 192.234.4.131 | 2 | 2 | 0 |
| 24 | L7 Asuka-Ritsuko | 2 | /30 | 192.234.4.132 | 192.234.4.133 | 192.234.4.135 | 2 | 2 | 0 |
| 25 | L8 Fuyutsuki-Maya | 2 | /30 | 192.234.4.136 | 192.234.4.137 | 192.234.4.139 | 2 | 2 | 0 |
| 26 | L9 Fuyutsuki-Toji | 2 | /30 | 192.234.4.140 | 192.234.4.141 | 192.234.4.143 | 2 | 2 | 0 |
| 27 | L10 Hikari-Kaworu | 2 | /30 | 192.234.4.144 | 192.234.4.145 | 192.234.4.147 | 2 | 2 | 0 |
| 28 | L11 Shigeru-Makoto | 2 | /30 | 192.234.4.148 | 192.234.4.149 | 192.234.4.151 | 2 | 2 | 0 |
| 29 | L12 Gendou-Asuka | 2 | /30 | 192.234.4.152 | 192.234.4.153 | 192.234.4.155 | 2 | 2 | 0 |
| 30 | L13 Gendou-Kaji | 2 | /30 | 192.234.4.156 | 192.234.4.157 | 192.234.4.159 | 2 | 2 | 0 |
| 31 | L14 Gendou-Misato | 2 | /30 | 192.234.4.160 | 192.234.4.161 | 192.234.4.163 | 2 | 2 | 0 |
| 32 | L15 Gendou-Shigeru | 2 | /30 | 192.234.4.164 | 192.234.4.165 | 192.234.4.167 | 2 | 2 | 0 |
| 33 | L16 Gendou-Fuyutsuki | 2 | /30 | 192.234.4.168 | 192.234.4.169 | 192.234.4.171 | 2 | 2 | 0 |

</details>

Total alokasi adalah `192.234.0.0` sampai `192.234.4.171`. Tabel lengkap dengan netmask dan range ada di [`subnetting/vlsm.md`](subnetting/vlsm.md), sedangkan IP tiap node ada di [`subnetting/ip-node.csv`](subnetting/ip-node.csv).

#### 3. Hitungan Satu Subnet: Switch-Garden

1. Kebutuhan: Garden-Staff 14 host + 1 gateway (Shinji) = **15 alamat**.
2. Prefix /28 memberi `2^4 - 2 = 14` usable, sehingga **tidak muat**. Prefix /27 memberi `2^5 - 2 = 30` usable, sehingga dipakai **/27** (netmask `255.255.255.224`).
3. Subnet sebelumnya (Switch-Relay `192.234.3.224/27`) berakhir di `192.234.3.255`, sehingga Switch-Garden dimulai di `192.234.4.0`.
4. Blok /27 berisi 32 alamat, yaitu `192.234.4.0` sampai `192.234.4.31`:
   * Network: `192.234.4.0`
   * Gateway (Shinji): `192.234.4.1`
   * Garden-Staff: `192.234.4.2`
   * Broadcast: `192.234.4.31`
5. Terpakai 15 dari 30 usable, sehingga sisa 15.

#### 4. Pohon IP

Subnet pada jalur Dummy-Plug ke Armisael digambar sebagai lingkaran merah: Switch-Lab (`192.234.4.48/29`), L7 Asuka-Ritsuko (`192.234.4.132/30`), L12 Gendou-Asuka (`192.234.4.152/30`), L15 Gendou-Shigeru (`192.234.4.164/30`), dan Switch-Monolith (`192.234.4.80/29`).

```mermaid
flowchart LR
    n192_234_0_0_21["192.234.0.0/21"]
    n192_234_0_0_22["192.234.0.0/22"]
    n192_234_0_0_23["192.234.0.0/23<br/>Switch-Quarters"]:::used
    n192_234_2_0_23["192.234.2.0/23"]
    n192_234_2_0_24["192.234.2.0/24<br/>Switch-Comm"]:::used
    n192_234_3_0_24["192.234.3.0/24"]
    n192_234_3_0_25["192.234.3.0/25<br/>Switch-Hangar"]:::used
    n192_234_3_128_25["192.234.3.128/25"]
    n192_234_3_128_26["192.234.3.128/26<br/>Switch-Bunker"]:::used
    n192_234_3_192_26["192.234.3.192/26"]
    n192_234_3_192_27["192.234.3.192/27<br/>Switch-Medic"]:::used
    n192_234_3_224_27["192.234.3.224/27<br/>Switch-Relay"]:::used
    n192_234_4_0_22["192.234.4.0/22"]
    n192_234_4_0_23["192.234.4.0/23"]
    n192_234_4_0_24["192.234.4.0/24"]
    n192_234_4_0_25["192.234.4.0/25"]
    n192_234_4_0_26["192.234.4.0/26"]
    n192_234_4_0_27["192.234.4.0/27<br/>Switch-Garden"]:::used
    n192_234_4_32_27["192.234.4.32/27"]
    n192_234_4_32_28["192.234.4.32/28<br/>Switch-Dock"]:::used
    n192_234_4_48_28["192.234.4.48/28"]
    n192_234_4_48_29(("192.234.4.48/29<br/><b>Switch-Lab</b>")):::hot
    n192_234_4_56_29["192.234.4.56/29<br/>Switch-Terminal"]:::used
    n192_234_4_64_26["192.234.4.64/26"]
    n192_234_4_64_27["192.234.4.64/27"]
    n192_234_4_64_28["192.234.4.64/28"]
    n192_234_4_64_29["192.234.4.64/29<br/>Switch-Cage"]:::used
    n192_234_4_72_29["192.234.4.72/29<br/>Switch-Dogma"]:::used
    n192_234_4_80_28["192.234.4.80/28"]
    n192_234_4_80_29(("192.234.4.80/29<br/><b>Switch-Monolith</b>")):::hot
    n192_234_4_88_29["192.234.4.88/29<br/>Switch-Radar"]:::used
    n192_234_4_96_27["192.234.4.96/27"]
    n192_234_4_96_28["192.234.4.96/28"]
    n192_234_4_96_29["192.234.4.96/29"]
    n192_234_4_96_30["192.234.4.96/30<br/>Switch-Archive"]:::used
    n192_234_4_100_30["192.234.4.100/30<br/>Switch-Intel"]:::used
    n192_234_4_104_29["192.234.4.104/29"]
    n192_234_4_104_30["192.234.4.104/30<br/>Switch-Cmd"]:::used
    n192_234_4_108_30["192.234.4.108/30<br/>L1 Gendou-Hikari"]:::used
    n192_234_4_112_28["192.234.4.112/28"]
    n192_234_4_112_29["192.234.4.112/29"]
    n192_234_4_112_30["192.234.4.112/30<br/>L2 Gendou-Yui"]:::used
    n192_234_4_116_30["192.234.4.116/30<br/>L3 Yui-Mari"]:::used
    n192_234_4_120_29["192.234.4.120/29"]
    n192_234_4_120_30["192.234.4.120/30<br/>L4 Yui-Rei"]:::used
    n192_234_4_124_30["192.234.4.124/30<br/>L5 Yui-Shinji"]:::used
    n192_234_4_128_25["192.234.4.128/25"]
    n192_234_4_128_26["192.234.4.128/26"]
    n192_234_4_128_27["192.234.4.128/27"]
    n192_234_4_128_28["192.234.4.128/28"]
    n192_234_4_128_29["192.234.4.128/29"]
    n192_234_4_128_30["192.234.4.128/30<br/>L6 Asuka-Kensuke"]:::used
    n192_234_4_132_30(("192.234.4.132/30<br/><b>L7 Asuka-Ritsuko</b>")):::hot
    n192_234_4_136_29["192.234.4.136/29"]
    n192_234_4_136_30["192.234.4.136/30<br/>L8 Fuyutsuki-Maya"]:::used
    n192_234_4_140_30["192.234.4.140/30<br/>L9 Fuyutsuki-Toji"]:::used
    n192_234_4_144_28["192.234.4.144/28"]
    n192_234_4_144_29["192.234.4.144/29"]
    n192_234_4_144_30["192.234.4.144/30<br/>L10 Hikari-Kaworu"]:::used
    n192_234_4_148_30["192.234.4.148/30<br/>L11 Shigeru-Makoto"]:::used
    n192_234_4_152_29["192.234.4.152/29"]
    n192_234_4_152_30(("192.234.4.152/30<br/><b>L12 Gendou-Asuka</b>")):::hot
    n192_234_4_156_30["192.234.4.156/30<br/>L13 Gendou-Kaji"]:::used
    n192_234_4_160_27["192.234.4.160/27"]
    n192_234_4_160_28["192.234.4.160/28"]
    n192_234_4_160_29["192.234.4.160/29"]
    n192_234_4_160_30["192.234.4.160/30<br/>L14 Gendou-Misato"]:::used
    n192_234_4_164_30(("192.234.4.164/30<br/><b>L15 Gendou-Shigeru</b>")):::hot
    n192_234_4_168_29["192.234.4.168/29"]
    n192_234_4_168_30["192.234.4.168/30<br/>L16 Gendou-Fuyutsuki"]:::used
    n192_234_4_172_30["192.234.4.172/30<br/>(sisa)"]:::sisa
    n192_234_4_176_28["192.234.4.176/28<br/>(sisa)"]:::sisa
    n192_234_4_192_26["192.234.4.192/26<br/>(sisa)"]:::sisa
    n192_234_5_0_24["192.234.5.0/24<br/>(sisa)"]:::sisa
    n192_234_6_0_23["192.234.6.0/23<br/>(sisa)"]:::sisa
    n192_234_0_0_21 --> n192_234_0_0_22
    n192_234_0_0_22 --> n192_234_0_0_23
    n192_234_0_0_22 --> n192_234_2_0_23
    n192_234_2_0_23 --> n192_234_2_0_24
    n192_234_2_0_23 --> n192_234_3_0_24
    n192_234_3_0_24 --> n192_234_3_0_25
    n192_234_3_0_24 --> n192_234_3_128_25
    n192_234_3_128_25 --> n192_234_3_128_26
    n192_234_3_128_25 --> n192_234_3_192_26
    n192_234_3_192_26 --> n192_234_3_192_27
    n192_234_3_192_26 --> n192_234_3_224_27
    n192_234_0_0_21 --> n192_234_4_0_22
    n192_234_4_0_22 --> n192_234_4_0_23
    n192_234_4_0_23 --> n192_234_4_0_24
    n192_234_4_0_24 --> n192_234_4_0_25
    n192_234_4_0_25 --> n192_234_4_0_26
    n192_234_4_0_26 --> n192_234_4_0_27
    n192_234_4_0_26 --> n192_234_4_32_27
    n192_234_4_32_27 --> n192_234_4_32_28
    n192_234_4_32_27 --> n192_234_4_48_28
    n192_234_4_48_28 --> n192_234_4_48_29
    n192_234_4_48_28 --> n192_234_4_56_29
    n192_234_4_0_25 --> n192_234_4_64_26
    n192_234_4_64_26 --> n192_234_4_64_27
    n192_234_4_64_27 --> n192_234_4_64_28
    n192_234_4_64_28 --> n192_234_4_64_29
    n192_234_4_64_28 --> n192_234_4_72_29
    n192_234_4_64_27 --> n192_234_4_80_28
    n192_234_4_80_28 --> n192_234_4_80_29
    n192_234_4_80_28 --> n192_234_4_88_29
    n192_234_4_64_26 --> n192_234_4_96_27
    n192_234_4_96_27 --> n192_234_4_96_28
    n192_234_4_96_28 --> n192_234_4_96_29
    n192_234_4_96_29 --> n192_234_4_96_30
    n192_234_4_96_29 --> n192_234_4_100_30
    n192_234_4_96_28 --> n192_234_4_104_29
    n192_234_4_104_29 --> n192_234_4_104_30
    n192_234_4_104_29 --> n192_234_4_108_30
    n192_234_4_96_27 --> n192_234_4_112_28
    n192_234_4_112_28 --> n192_234_4_112_29
    n192_234_4_112_29 --> n192_234_4_112_30
    n192_234_4_112_29 --> n192_234_4_116_30
    n192_234_4_112_28 --> n192_234_4_120_29
    n192_234_4_120_29 --> n192_234_4_120_30
    n192_234_4_120_29 --> n192_234_4_124_30
    n192_234_4_0_24 --> n192_234_4_128_25
    n192_234_4_128_25 --> n192_234_4_128_26
    n192_234_4_128_26 --> n192_234_4_128_27
    n192_234_4_128_27 --> n192_234_4_128_28
    n192_234_4_128_28 --> n192_234_4_128_29
    n192_234_4_128_29 --> n192_234_4_128_30
    n192_234_4_128_29 --> n192_234_4_132_30
    n192_234_4_128_28 --> n192_234_4_136_29
    n192_234_4_136_29 --> n192_234_4_136_30
    n192_234_4_136_29 --> n192_234_4_140_30
    n192_234_4_128_27 --> n192_234_4_144_28
    n192_234_4_144_28 --> n192_234_4_144_29
    n192_234_4_144_29 --> n192_234_4_144_30
    n192_234_4_144_29 --> n192_234_4_148_30
    n192_234_4_144_28 --> n192_234_4_152_29
    n192_234_4_152_29 --> n192_234_4_152_30
    n192_234_4_152_29 --> n192_234_4_156_30
    n192_234_4_128_26 --> n192_234_4_160_27
    n192_234_4_160_27 --> n192_234_4_160_28
    n192_234_4_160_28 --> n192_234_4_160_29
    n192_234_4_160_29 --> n192_234_4_160_30
    n192_234_4_160_29 --> n192_234_4_164_30
    n192_234_4_160_28 --> n192_234_4_168_29
    n192_234_4_168_29 --> n192_234_4_168_30
    n192_234_4_168_29 --> n192_234_4_172_30
    n192_234_4_160_27 --> n192_234_4_176_28
    n192_234_4_128_25 --> n192_234_4_192_26
    n192_234_4_0_23 --> n192_234_5_0_24
    n192_234_4_0_22 --> n192_234_6_0_23
    classDef used fill:#e8f1fb,stroke:#557,color:#000
    classDef sisa fill:#f3f3f3,stroke:#aaa,color:#888,stroke-dasharray:4 3
    classDef hot fill:#fde2e2,stroke:#d00,stroke-width:3px,color:#d00
```

Setiap cabang membagi blok induknya menjadi dua bagian sama besar, dari `192.234.0.0/21` sampai prefix tiap subnet. Kotak biru adalah subnet terpakai, dan kotak abu-abu putus-putus adalah sisa yang belum dialokasikan. Versi gambar statis tersedia di `subnetting/pohon-ip.png`.


## Soal 2
**Geofront gelap gulita:** kabel sudah ditarik, tapi saat Misato menekan tombol daya, Geofront tetap gelap. Tidak ada alamat dan tidak ada rute. Pasang semua node di GNS3 sesuai topologi. Beri IP ke tiap interface router sesuai soal 1, lalu aktifkan **IP forwarding** di semua router. Hanya **Gendou** yang terhubung ke NAT1 dan mendapat alamat lewat **DHCP**. Router lain baru bisa memasang paket setelah soal 4, karena internet baru ada saat itu. Tunjukkan `ip -br` di tiap router dan ping dua ujung tiap link router ke router.

### Jawaban dan Penjelasan

#### 1. Topologi GNS3

Topologi berisi 17 router, 17 switch, 25 host, dan NAT1 dengan total 59 link. Semua router dan host memakai image `ardhptr21/alpinet:latest`, kecuali Magi-Casper, Magi-Balthasar, dan Magi-Melchior yang memakai `ardhptr21/debinet:latest` karena soal 7 membutuhkan paket `netcat-traditional`.

Pemetaan interface pada setiap router dibuat seragam:

* `eth0` selalu menuju router di atasnya (Gendou menuju NAT1).
* `eth1` selalu menuju switch LAN milik router tersebut.
* `eth2` dan seterusnya menuju router di bawahnya.

<details>
<summary>Pemetaan interface 17 router</summary>

| Router | eth0 | eth1 | eth2 | eth3 | eth4 | eth5–eth8 |
|---|---|---|---|---|---|---|
| Gendou | NAT1 (DHCP) | Switch-Cmd `.4.105/30` | Yui `.4.113/30` | Hikari `.4.109/30` | Asuka `.4.153/30` | Kaji `.4.157`, Misato `.4.161`, Shigeru `.4.165`, Fuyutsuki `.4.169` (/30) |
| Yui | Gendou `.4.114/30` | Switch-Hangar `.3.1/25` | Mari `.4.117/30` | Rei `.4.121/30` | Shinji `.4.125/30` | |
| Mari | Yui `.4.118/30` | Switch-Dock `.4.33/28` | | | | |
| Rei | Yui `.4.122/30` | Switch-Quarters `.0.1/23` | | | | |
| Shinji | Yui `.4.126/30` | Switch-Garden `.4.1/27` | | | | |
| Hikari | Gendou `.4.110/30` | Switch-Comm `.2.1/24` | Kaworu `.4.145/30` | | | |
| Kaworu | Hikari `.4.146/30` | Switch-Relay `.3.225/27` | | | | |
| Asuka | Gendou `.4.154/30` | Switch-Archive `.4.97/30` | Kensuke `.4.129/30` | Ritsuko `.4.133/30` | | |
| Kensuke | Asuka `.4.130/30` | Switch-Bunker `.3.129/26` | | | | |
| Ritsuko | Asuka `.4.134/30` | Switch-Lab `.4.49/29` | | | | |
| Kaji | Gendou `.4.158/30` | Switch-Intel `.4.101/30` | | | | |
| Misato | Gendou `.4.162/30` | Switch-Cage `.4.65/29` | | | | |
| Shigeru | Gendou `.4.166/30` | Switch-Monolith `.4.81/29` | Makoto `.4.149/30` | | | |
| Makoto | Shigeru `.4.150/30` | Switch-Radar `.4.89/29` | | | | |
| Fuyutsuki | Gendou `.4.170/30` | Switch-Terminal `.4.57/29` | Maya `.4.137/30` | Toji `.4.141/30` | | |
| Maya | Fuyutsuki `.4.138/30` | Switch-Medic `.3.193/27` | | | | |
| Toji | Fuyutsuki `.4.142/30` | Switch-Dogma `.4.73/29` | | | | |

Semua alamat di atas berawalan `192.234.`.

</details>

#### 2. Konfigurasi `Gendou`

Gendou adalah satu-satunya router yang terhubung ke NAT1, sehingga `eth0` memakai DHCP. Interface lainnya diberi IP statis sesuai tabel VLSM.

```bash
auto eth0
iface eth0 inet dhcp
    up sysctl -w net.ipv4.ip_forward=1

# Switch-Cmd
auto eth1
iface eth1 inet static
    address 192.234.4.105
    netmask 255.255.255.252

# L2 ke Yui
auto eth2
iface eth2 inet static
    address 192.234.4.113
    netmask 255.255.255.252

# ... eth3 sampai eth8 mengikuti pola yang sama
```

Konfigurasi ditulis ke `/etc/network/interfaces`, yang diterapkan ulang oleh GNS3 setiap kali node dinyalakan, sehingga IP bertahan setelah restart. Baris `up sysctl -w net.ipv4.ip_forward=1` memastikan IP forwarding aktif setiap kali interface naik. Agar langsung berlaku tanpa restart, script juga menerapkan konfigurasi saat itu juga:

```bash
ip link set eth0 up
udhcpc -i eth0 -n -q
ip addr flush dev eth1; ip addr add 192.234.4.105/30 dev eth1; ip link set eth1 up
# ... dan seterusnya untuk eth2 sampai eth8
sysctl -w net.ipv4.ip_forward=1
```

#### 3. Konfigurasi Router Lain

Router lain memakai pola yang sama, hanya saja semua interface statis. Sebagai contoh, konfigurasi `Asuka`:

```bash
# L12 ke Gendou
auto eth0
iface eth0 inet static
    address 192.234.4.154
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1

# Switch-Archive
auto eth1
iface eth1 inet static
    address 192.234.4.97
    netmask 255.255.255.252

# L6 ke Kensuke
auto eth2
iface eth2 inet static
    address 192.234.4.129
    netmask 255.255.255.252

# L7 ke Ritsuko
auto eth3
iface eth3 inet static
    address 192.234.4.133
    netmask 255.255.255.252
```

Script lengkap tiap router ada di `perquest-scripts/soal_2/<router>.sh` dan dijalankan di node sebagai `/root/soal_2.sh`. Pada soal ini belum ada rute antar-subnet, sehingga yang bisa saling ping hanya dua ujung link yang terhubung langsung. Rute dibuat pada soal 3.

### Verifikasi

#### 1. Verifikasi `Gendou`

```bash
ip -4 -br addr
ping -c 2 192.168.122.1      # NAT1
ping -c 2 192.234.4.114      # Yui (dan seterusnya untuk 7 link lainnya)
```

```
lo               UNKNOWN        127.0.0.1/8
eth0             UNKNOWN        192.168.122.172/24
eth1             UNKNOWN        192.234.4.105/30
eth2             UNKNOWN        192.234.4.113/30
eth3             UNKNOWN        192.234.4.109/30
eth4             UNKNOWN        192.234.4.153/30
eth5             UNKNOWN        192.234.4.157/30
eth6             UNKNOWN        192.234.4.161/30
eth7             UNKNOWN        192.234.4.165/30
eth8             UNKNOWN        192.234.4.169/30
```

`eth0` mendapat `192.168.122.172/24` dari DHCP NAT1, dan `eth1` sampai `eth8` sudah memiliki IP sesuai tabel. Ping ke NAT1 dan ke tujuh router tetangga (Yui, Hikari, Asuka, Kaji, Misato, Shigeru, Fuyutsuki) menghasilkan 0% packet loss.

#### 2. Verifikasi Link Router ke Router

Ping dijalankan dari kedua ujung setiap link. Seluruh 16 link berhasil dengan 0% packet loss:

<details>
<summary>Hasil ping 16 link router ke router</summary>

| Link | Ujung atas | Ujung bawah | Hasil |
|---|---|---|---|
| L1 Gendou-Hikari | 192.234.4.109 | 192.234.4.110 | 0% loss dua arah |
| L2 Gendou-Yui | 192.234.4.113 | 192.234.4.114 | 0% loss dua arah |
| L3 Yui-Mari | 192.234.4.117 | 192.234.4.118 | 0% loss dua arah |
| L4 Yui-Rei | 192.234.4.121 | 192.234.4.122 | 0% loss dua arah |
| L5 Yui-Shinji | 192.234.4.125 | 192.234.4.126 | 0% loss dua arah |
| L6 Asuka-Kensuke | 192.234.4.129 | 192.234.4.130 | 0% loss dua arah |
| L7 Asuka-Ritsuko | 192.234.4.133 | 192.234.4.134 | 0% loss dua arah |
| L8 Fuyutsuki-Maya | 192.234.4.137 | 192.234.4.138 | 0% loss dua arah |
| L9 Fuyutsuki-Toji | 192.234.4.141 | 192.234.4.142 | 0% loss dua arah |
| L10 Hikari-Kaworu | 192.234.4.145 | 192.234.4.146 | 0% loss dua arah |
| L11 Shigeru-Makoto | 192.234.4.149 | 192.234.4.150 | 0% loss dua arah |
| L12 Gendou-Asuka | 192.234.4.153 | 192.234.4.154 | 0% loss dua arah |
| L13 Gendou-Kaji | 192.234.4.157 | 192.234.4.158 | 0% loss dua arah |
| L14 Gendou-Misato | 192.234.4.161 | 192.234.4.162 | 0% loss dua arah |
| L15 Gendou-Shigeru | 192.234.4.165 | 192.234.4.166 | 0% loss dua arah |
| L16 Gendou-Fuyutsuki | 192.234.4.169 | 192.234.4.170 | 0% loss dua arah |

</details>

<!-- TODO: tambahkan screenshot ip -br dan ping dari GNS3 -->


## Soal 3
**Pulau-pulau yang terpisah:** lampu mulai menyala, tapi tiap segmen masih seperti pulau terpisah. Fuyutsuki mengingatkan: bangun jalur dari Gendo ke bawah, cabang demi cabang. Hubungkan semua subnet dengan **routing statis** dan **jumlah rute sesedikit mungkin**. Router selain Gendo cukup punya satu **default route ke atas** dan rute untuk subnet di bawahnya. Gendo memakai default route ke NAT1. Subnet satu cabang yang bisa digabung tepat menjadi satu CIDR **harus diringkas**. Untuk soal 3 sampai 5, beri IP dan gateway **sementara** pada node uji. IP permanen dibuat di soal 6. Buktikan **Armisael bisa ping ke Lilith, Sachiel, dan Comm-Net**.

### Jawaban dan Penjelasan

#### 1. Prinsip Routing

* **Router daun** (Mari, Rei, Shinji, Kaworu, Kensuke, Ritsuko, Kaji, Misato, Makoto, Maya, Toji) hanya memiliki LAN sendiri, sehingga cukup satu default route ke router di atasnya.
* **Router cabang** (Yui, Hikari, Asuka, Shigeru, Fuyutsuki) memiliki default route ke Gendou, ditambah satu rute untuk setiap LAN milik router di bawahnya. Link ke router bawah sudah terhubung langsung, sehingga tidak perlu rute.
* **Gendou** memakai default route ke NAT1 yang didapat dari DHCP, ditambah rute ke setiap subnet di tiap cabang yang tidak terhubung langsung.
* **Peringkasan**: subnet satu cabang yang bersebelahan dan tepat membentuk satu blok CIDR digabung menjadi satu rute. Urutan link pada soal 1 sengaja disusun agar hal ini bisa dilakukan:

| Rute ringkasan | Isi | Via |
|---|---|---|
| `192.234.4.112/28` | L2 Gendou-Yui, L3 Yui-Mari, L4 Yui-Rei, L5 Yui-Shinji | Yui |
| `192.234.4.128/29` | L6 Asuka-Kensuke, L7 Asuka-Ritsuko | Asuka |
| `192.234.4.136/29` | L8 Fuyutsuki-Maya, L9 Fuyutsuki-Toji | Fuyutsuki |
| `192.234.4.80/28` | Switch-Monolith (`.80/29`), Switch-Radar (`.88/29`) | Shigeru |

Subnet lain tidak bisa diringkas tepat. Contohnya, Garden (`4.0/27`) dan Dock (`4.32/28`) sama-sama di cabang Yui, tetapi blok gabungannya `4.0/26` ikut memuat Lab (`4.48/29`) milik cabang Asuka.

Rute ditulis sebagai baris `up ip route replace ...` di `/etc/network/interfaces`, di bawah interface yang menjadi jalan keluar ke next hop. Dengan begitu rute dipasang setiap kali interface naik dan bertahan setelah restart. Script juga langsung menerapkan rute dengan `ip route replace`, yang aman dijalankan berulang tanpa membuat rute dobel.

#### 2. Konfigurasi `Gendou`

Gendou memiliki 20 rute statis, ditambah default route dari DHCP NAT1:

<details>
<summary>20 rute statis Gendou</summary>

```bash
# Cabang Yui (5 rute)
ip route replace 192.234.0.0/23   via 192.234.4.114   # Quarters
ip route replace 192.234.3.0/25   via 192.234.4.114   # Hangar
ip route replace 192.234.4.0/27   via 192.234.4.114   # Garden
ip route replace 192.234.4.32/28  via 192.234.4.114   # Dock
ip route replace 192.234.4.112/28 via 192.234.4.114   # L2-L5 (ringkasan)

# Cabang Hikari (3 rute)
ip route replace 192.234.2.0/24   via 192.234.4.110   # Comm
ip route replace 192.234.3.224/27 via 192.234.4.110   # Relay
ip route replace 192.234.4.144/30 via 192.234.4.110   # L10 Hikari-Kaworu

# Cabang Asuka (4 rute)
ip route replace 192.234.4.96/30  via 192.234.4.154   # Archive
ip route replace 192.234.3.128/26 via 192.234.4.154   # Bunker
ip route replace 192.234.4.48/29  via 192.234.4.154   # Lab
ip route replace 192.234.4.128/29 via 192.234.4.154   # L6-L7 (ringkasan)

# Kaji dan Misato (1 rute masing-masing)
ip route replace 192.234.4.100/30 via 192.234.4.158   # Intel
ip route replace 192.234.4.64/29  via 192.234.4.162   # Cage

# Cabang Shigeru (2 rute)
ip route replace 192.234.4.80/28  via 192.234.4.166   # Monolith + Radar (ringkasan)
ip route replace 192.234.4.148/30 via 192.234.4.166   # L11 Shigeru-Makoto

# Cabang Fuyutsuki (4 rute)
ip route replace 192.234.4.56/29  via 192.234.4.170   # Terminal
ip route replace 192.234.3.192/27 via 192.234.4.170   # Medic
ip route replace 192.234.4.72/29  via 192.234.4.170   # Dogma
ip route replace 192.234.4.136/29 via 192.234.4.170   # L8-L9 (ringkasan)
```

</details>

#### 3. Konfigurasi Router Cabang

Sebagai contoh, `Yui` memiliki default route ke Gendou dan satu rute untuk LAN setiap router di bawahnya:

```bash
# L2 ke Gendou
auto eth0
iface eth0 inet static
    address 192.234.4.114
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1
    up ip route replace default via 192.234.4.113   # Gendou

# L3 ke Mari
auto eth2
iface eth2 inet static
    address 192.234.4.117
    netmask 255.255.255.252
    up ip route replace 192.234.4.32/28 via 192.234.4.118   # Dock (Mari)

# ... eth3 (Rei) dan eth4 (Shinji) mengikuti pola yang sama
```

Rute pada router cabang lainnya:

| Router | Default route | Rute ke bawah |
|---|---|---|
| Yui | `via 192.234.4.113` | `4.32/28` via Mari, `0.0/23` via Rei, `4.0/27` via Shinji |
| Hikari | `via 192.234.4.109` | `3.224/27` via Kaworu |
| Asuka | `via 192.234.4.153` | `3.128/26` via Kensuke, `4.48/29` via Ritsuko |
| Shigeru | `via 192.234.4.165` | `4.88/29` via Makoto |
| Fuyutsuki | `via 192.234.4.169` | `3.192/27` via Maya, `4.72/29` via Toji |

#### 4. Konfigurasi Router Daun

Router daun cukup memiliki satu default route ke router di atasnya. Contohnya pada `Mari`:

```bash
ip route replace default via 192.234.4.117   # Yui
```

#### 5. IP Sementara Node Uji

| Node | IP sementara | Gateway |
|---|---|---|
| Armisael | `192.234.4.83/29` | `192.234.4.81` (Shigeru) |
| Lilith | `192.234.4.74/29` | `192.234.4.73` (Toji) |
| Sachiel | `192.234.3.130/26` | `192.234.3.129` (Kensuke) |
| Comm-Net | `192.234.2.2/24` | `192.234.2.1` (Hikari) |

```bash
ip addr flush dev eth0
ip addr add 192.234.4.83/29 dev eth0
ip link set eth0 up
ip route replace default via 192.234.4.81
```

IP ini hanya diterapkan langsung dan tidak disimpan ke `/etc/network/interfaces`, karena IP permanen dibuat pada soal 6.

Script lengkap tiap node ada di `perquest-scripts/soal_3/<node>.sh` dan dijalankan di node sebagai `/root/soal_3.sh`.

### Verifikasi

#### 1. Tabel Routing `Gendou`

```bash
ip route
```

<details>
<summary>Output <code>ip route</code> di Gendou</summary>

```
default via 192.168.122.1 dev eth0 metric 161637
192.168.122.0/24 dev eth0 proto kernel scope link src 192.168.122.172
192.234.0.0/23 via 192.234.4.114 dev eth2
192.234.2.0/24 via 192.234.4.110 dev eth3
192.234.3.0/25 via 192.234.4.114 dev eth2
192.234.3.128/26 via 192.234.4.154 dev eth4
192.234.3.192/27 via 192.234.4.170 dev eth8
192.234.3.224/27 via 192.234.4.110 dev eth3
192.234.4.0/27 via 192.234.4.114 dev eth2
192.234.4.32/28 via 192.234.4.114 dev eth2
192.234.4.48/29 via 192.234.4.154 dev eth4
192.234.4.56/29 via 192.234.4.170 dev eth8
192.234.4.64/29 via 192.234.4.162 dev eth6
192.234.4.72/29 via 192.234.4.170 dev eth8
192.234.4.80/28 via 192.234.4.166 dev eth7
192.234.4.96/30 via 192.234.4.154 dev eth4
192.234.4.100/30 via 192.234.4.158 dev eth5
192.234.4.104/30 dev eth1 proto kernel scope link src 192.234.4.105
192.234.4.108/30 dev eth3 proto kernel scope link src 192.234.4.109
192.234.4.112/30 dev eth2 proto kernel scope link src 192.234.4.113
192.234.4.112/28 via 192.234.4.114 dev eth2
192.234.4.128/29 via 192.234.4.154 dev eth4
192.234.4.136/29 via 192.234.4.170 dev eth8
192.234.4.144/30 via 192.234.4.110 dev eth3
192.234.4.148/30 via 192.234.4.166 dev eth7
192.234.4.152/30 dev eth4 proto kernel scope link src 192.234.4.153
192.234.4.156/30 dev eth5 proto kernel scope link src 192.234.4.157
192.234.4.160/30 dev eth6 proto kernel scope link src 192.234.4.161
192.234.4.164/30 dev eth7 proto kernel scope link src 192.234.4.165
192.234.4.168/30 dev eth8 proto kernel scope link src 192.234.4.169
```

</details>

Rute `192.234.4.112/28` (ringkasan) dan `192.234.4.112/30` (terhubung langsung) muncul bersamaan. Kernel memilih rute dengan prefix terpanjang, sehingga paket ke Yui tetap lewat link langsung, sedangkan paket ke L3–L5 lewat rute ringkasan.

#### 2. Ping dari `Armisael`

```bash
ping -c 3 192.234.4.74    # Lilith
ping -c 3 192.234.3.130   # Sachiel
ping -c 3 192.234.2.2     # Comm-Net
```

| Tujuan | Jalur | Hasil |
|---|---|---|
| Lilith `192.234.4.74` | Shigeru → Gendou → Fuyutsuki → Toji | 3/3 diterima, 0% loss |
| Sachiel `192.234.3.130` | Shigeru → Gendou → Asuka → Kensuke | 3/3 diterima, 0% loss |
| Comm-Net `192.234.2.2` | Shigeru → Gendou → Hikari | 3/3 diterima, 0% loss |

Ketiga ping berhasil, sehingga routing statis dari cabang Shigeru ke cabang Fuyutsuki, Asuka, dan Hikari sudah benar.

<!-- TODO: tambahkan screenshot ip route dan ping dari GNS3 -->


## Soal 4
**Haus kabar dari dunia luar:** Maya melapor bahwa semua sistem butuh update dari luar, padahal pintu keluarnya hanya Gendo. IP dari NAT1 juga bisa berganti kapan saja. Beri seluruh jaringan akses internet lewat Gendo. Konfigurasinya tidak boleh perlu diubah saat IP NAT1 berganti. Hanya traffic dari prefix internal yang keluar lewat NAT1 yang boleh diterjemahkan alamatnya, sedangkan traffic antar-LAN harus tetap membawa alamat asli pengirimnya. Node yang nanti memasang paket juga harus bisa me-resolve nama domain. Selesaikan sebelum node lain memasang paket. Buktikan ping 8.8.8.8 dan ping `deb.debian.org` dari Armisael dan Lilith berhasil, dan tunjukkan counter rule NAT.

### Jawaban dan Penjelasan

#### 1. NAT di `Gendou`

```bash
iptables -t nat -C POSTROUTING -s 192.234.0.0/16 -o eth0 -j MASQUERADE 2>/dev/null ||
    iptables -t nat -A POSTROUTING -s 192.234.0.0/16 -o eth0 -j MASQUERADE
```

Setiap bagian rule punya alasan:

* **`MASQUERADE`**, bukan `SNAT --to-source`. MASQUERADE selalu memakai IP `eth0` yang sedang aktif, sehingga rule tidak perlu diubah walaupun IP dari DHCP NAT1 berganti. SNAT harus menuliskan IP secara eksplisit.
* **`-s 192.234.0.0/16`** membatasi agar hanya alamat dari prefix internal yang diterjemahkan.
* **`-o eth0`** membatasi agar hanya paket yang keluar ke NAT1 yang diterjemahkan. Traffic antar-LAN keluar lewat `eth1` sampai `eth8`, sehingga tidak tersentuh rule ini dan tetap membawa alamat asli pengirimnya.
* **`-C ... || -A ...`** memeriksa dulu apakah rule sudah ada, sehingga script aman dijalankan berulang tanpa membuat rule dobel.

Agar bertahan setelah restart, rule yang sama ditambahkan ke stanza `eth0` di `/etc/network/interfaces`:

```bash
auto eth0
iface eth0 inet dhcp
    up sysctl -w net.ipv4.ip_forward=1
    up iptables -t nat -C POSTROUTING -s 192.234.0.0/16 -o eth0 -j MASQUERADE 2>/dev/null || iptables -t nat -A POSTROUTING -s 192.234.0.0/16 -o eth0 -j MASQUERADE
```

Pada soal 5, seluruh konfigurasi Gendou dipindahkan ke `gendo.sh`, dan rule MASQUERADE dipasang ulang dengan menjalankan script tersebut (lihat soal 5).

#### 2. DNS

* **Gendou** memakai nameserver dari DHCP NAT1 (`192.168.122.1`), yang diperbarui otomatis oleh `udhcpc`.
* **Router lain** memakai nameserver `8.8.8.8`. Server ini dijangkau lewat NAT di Gendou, sehingga tidak bergantung pada alamat NAT1 yang bisa berganti.

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

Agar bertahan setelah restart, baris berikut ditambahkan ke stanza `eth0` di `/etc/network/interfaces` setiap router:

```bash
    up echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

Semua router sudah bisa me-resolve `deb.debian.org` sebelum memasang paket. Node non-router mendapat nameserver permanen pada soal 6. Untuk node uji Armisael dan Lilith, nameserver dipasang sementara dengan perintah yang sama.

Script lengkap tiap node ada di `perquest-scripts/soal_4/<node>.sh` dan dijalankan di node sebagai `/root/soal_4.sh`.

### Verifikasi

#### 1. Ping dari `Armisael` dan `Lilith`

```bash
ping -c 3 8.8.8.8
ping -c 3 deb.debian.org
```

| Node | `ping 8.8.8.8` | `ping deb.debian.org` |
|---|---|---|
| Armisael | 3/3 diterima, 0% loss | 3/3 diterima, 0% loss |
| Lilith | 3/3 diterima, 0% loss | 3/3 diterima, 0% loss |

Ping ke `deb.debian.org` berhasil, artinya nama domain berhasil di-resolve dan paket keluar ke internet lewat NAT di Gendou.

#### 2. Counter Rule NAT di `Gendou`

```bash
iptables -t nat -L POSTROUTING -v -n -x
```

Counter pada tabel `nat` hanya bertambah satu kali untuk setiap koneksi baru, bukan untuk setiap paket, karena paket berikutnya dalam koneksi yang sama ditangani oleh conntrack. Pengujian dilakukan dengan membaca counter sebelum dan sesudah dua jenis ping dari Armisael:

| Langkah | Counter (pkts / bytes) |
|---|---|
| Sebelum pengujian | `40 / 2684` |
| Setelah `ping -c 3 192.234.4.74` (Lilith, antar-LAN) | `40 / 2684` (tidak berubah) |
| Setelah `ping -c 3 8.8.8.8` (internet) | `41 / 2768` (bertambah 1 koneksi) |

```
pkts bytes target     prot opt in     out     source               destination
  41  2768 MASQUERADE  all  --  *      eth0    192.234.0.0/16       0.0.0.0/0
```

Counter tidak berubah saat Armisael ping Lilith, sehingga traffic antar-LAN tidak diterjemahkan dan tetap membawa alamat asli `192.234.4.83`. Counter bertambah saat Armisael ping `8.8.8.8`, sehingga hanya traffic ke internet yang diterjemahkan.

<!-- TODO: tambahkan screenshot ping dan counter NAT dari GNS3 -->


## Soal 5
**Pintu depan dikunci rapat:** Kaji memperingatkan Kaworu bahwa SEELE cukup mengetuk pintu depan. Gendo mengunci NAT1: boleh keluar, tidak boleh dimasuki. Di Gendo, ubah policy INPUT dan FORWARD menjadi DROP. Lalu izinkan empat hal: (a) balasan koneksi yang sudah ada, (b) traffic dari jaringan internal ke internet, (c) traffic antar-LAN, dan (d) traffic dari jaringan internal ke Gendo sendiri. Loopback dan DHCP dari NAT1 juga harus tetap jalan. Koneksi baru dari sisi NAT1 tidak boleh masuk. Soal 2 sampai 4 harus tetap jalan, dan semuanya ditulis di `gendo.sh`. Tunjukkan `iptables -S` di Gendo, dan buktikan ping 8.8.8.8 dari Armisael masih berhasil.

### Jawaban dan Penjelasan

Seluruh konfigurasi Gendou (soal 2 sampai 5) digabung menjadi satu script `/root/gendo.sh` (`perquest-scripts/soal_5/gendo.sh`). Urutannya:

1. **Soal 2 + 3:** menulis `/etc/network/interfaces` berisi IP tiap interface dan rute statis, lalu menerapkannya langsung.
2. **Soal 4:** rule MASQUERADE.
3. **Soal 5:** firewall.
4. Menyimpan salinan rule iptables ke `/etc/iptables.rules`.

Script diawali dengan flush chain (`-F`) sebelum menambah rule, sehingga aman dijalankan berulang tanpa rule dobel.

#### 1. Firewall

```bash
INTERNAL=192.234.0.0/16

iptables -F INPUT
iptables -F FORWARD
iptables -P INPUT DROP
iptables -P FORWARD DROP

# Loopback
iptables -A INPUT -i lo -j ACCEPT
# (a) balasan koneksi yang sudah ada
iptables -A INPUT   -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# DHCP dari NAT1 (server 67 -> client 68)
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
# (d) jaringan internal ke Gendou sendiri
iptables -A INPUT ! -i eth0 -s $INTERNAL -j ACCEPT
# (b) jaringan internal ke internet
iptables -A FORWARD ! -i eth0 -s $INTERNAL -o eth0 -j ACCEPT
# (c) antar-LAN
iptables -A FORWARD ! -i eth0 -s $INTERNAL ! -o eth0 -d $INTERNAL -j ACCEPT
```

| Rule | Kebutuhan | Penjelasan |
|---|---|---|
| `-P INPUT DROP`, `-P FORWARD DROP` | Kunci default | Semua paket yang tidak cocok dengan rule di bawah dibuang. `OUTPUT` tetap `ACCEPT` agar Gendou sendiri bisa keluar. |
| `-i lo` | Loopback | Komunikasi lokal Gendou tidak terblokir. |
| `--ctstate ESTABLISHED,RELATED` | (a) | Balasan dari koneksi yang dimulai dari dalam (termasuk balasan dari internet yang sudah di-NAT) boleh masuk. |
| `-i eth0 -p udp --sport 67 --dport 68` | DHCP NAT1 | Balasan DHCP dari NAT1 tetap diterima agar `eth0` bisa memperpanjang lease. |
| `INPUT ! -i eth0 -s 192.234.0.0/16` | (d) | Jaringan internal boleh mengakses Gendou. `! -i eth0` mencegah paket palsu ber-alamat internal yang datang dari NAT1. |
| `FORWARD ! -i eth0 -s 192.234.0.0/16 -o eth0` | (b) | Jaringan internal boleh keluar ke internet. |
| `FORWARD ! -i eth0 -s 192.234.0.0/16 ! -o eth0 -d 192.234.0.0/16` | (c) | Traffic antar-LAN yang lewat Gendou boleh diteruskan. |

Koneksi baru dari sisi NAT1 tidak cocok dengan rule mana pun: bukan balasan, bukan DHCP, dan masuk dari `eth0`. Akibatnya paket tersebut jatuh ke policy `DROP`.

#### 2. Memasang Ulang Rule

Rule iptables disimpan di memori kernel, sehingga hilang setiap kali node Gendou di-restart. Rule MASQUERADE (soal 4) dan firewall (soal 5) dipasang ulang dengan menjalankan script:

```bash
sh /root/gendo.sh
```

Script ini aman dijalankan berulang, dan sekaligus memasang ulang IP serta rute dari soal 2 dan 3.

Script juga menyimpan salinan rule dengan `iptables-save > /etc/iptables.rules` dan menambahkan baris `up iptables-restore < /etc/iptables.rules` pada stanza `eth0`. Baris ini menggantikan baris `up iptables -t nat ...` dari soal 4. Namun pemulihan otomatis ini tidak dapat diandalkan. GNS3 hanya mempertahankan isi `/root` dan `/etc/network` saat container dibuat ulang, sehingga `/etc/iptables.rules` bisa hilang. Karena itu, cara yang dipakai adalah menjalankan ulang `gendo.sh`.

### Verifikasi

#### 1. `iptables -S` di `Gendou`

```
-P INPUT DROP
-P FORWARD DROP
-P OUTPUT ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i eth0 -p udp -m udp --sport 67 --dport 68 -j ACCEPT
-A INPUT -s 192.234.0.0/16 ! -i eth0 -j ACCEPT
-A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -s 192.234.0.0/16 ! -i eth0 -o eth0 -j ACCEPT
-A FORWARD -s 192.234.0.0/16 -d 192.234.0.0/16 ! -i eth0 ! -o eth0 -j ACCEPT
```

```
$ iptables -t nat -S POSTROUTING
-P POSTROUTING ACCEPT
-A POSTROUTING -s 192.234.0.0/16 -o eth0 -j MASQUERADE
```

#### 2. Soal 2 sampai 4 tetap jalan

| Uji | Hasil |
|---|---|
| `udhcpc` di `eth0` Gendou | Lease `192.168.122.172` dari `192.168.122.1` diperoleh (DHCP tetap jalan) |
| Armisael `ping 8.8.8.8` | 3/3 diterima, 0% loss (internet, rule b) |
| Armisael `ping deb.debian.org` | 3/3 diterima, 0% loss (DNS + internet) |
| Armisael `ping 192.234.4.74` (Lilith) | 3/3 diterima, 0% loss (antar-LAN, rule c) |
| Armisael `ping 192.234.4.105` (Gendou) | 2/2 diterima, 0% loss (internal ke Gendou, rule d) |
| Gendou `ping 8.8.8.8` | 2/2 diterima, 0% loss (balasan diterima, rule a) |

Counter `FORWARD` setelah pengujian menunjukkan setiap rule terpakai:

```
Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
   21  2101 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
    6   445 ACCEPT     all  --  !eth0  eth0    192.234.0.0/16       0.0.0.0/0
    9   756 ACCEPT     all  --  !eth0  !eth0   192.234.0.0/16       192.234.0.0/16
```

<!-- TODO: tambahkan screenshot iptables -S di Gendou dan ping 8.8.8.8 dari Armisael -->

## Soal 6
**Alamat para pilot:** jaringan sudah hidup, tapi para pilot dan staf tidak tahu alamat mereka sendiri. Unit-01 bahkan tidak tahu siapa gateway-nya. Beri IP statis dan gateway ke semua node non-router, sesuai aturan alamat di glosarium. Simpan agar bertahan setelah restart. Tunjukkan `ip -br` dan ping ke gateway di Unit-01.

### Jawaban dan Penjelasan

Sesuai glosarium, gateway adalah IP usable pertama subnet. Node di switch mendapat IP usable berikutnya sesuai urutan nama di gambar, dari kiri ke kanan. Alamat setiap node diambil dari `subnetting/ip-node.csv` (soal 1).

Setiap node non-router menjalankan script yang sama polanya. Contoh untuk `Unit-01`:

```bash
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

# Switch-Cage
auto eth0
iface eth0 inet static
    address 192.234.4.66
    netmask 255.255.255.248
    gateway 192.234.4.65
    up echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

# Terapkan sekarang
ip addr flush dev eth0
ip addr add 192.234.4.66/29 dev eth0
ip link set eth0 up
ip route replace default via 192.234.4.65
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

* **`/etc/network/interfaces`** diterapkan GNS3 setiap node start, sehingga IP, gateway, dan nameserver bertahan setelah restart.
* **`gateway`** menjadi default route ke router di switch yang sama.
* **`nameserver 8.8.8.8`** melanjutkan soal 4 agar node bisa me-resolve nama domain saat memasang paket.

Script lengkap tiap node ada di `perquest-scripts/soal_6/<node>.sh` dan dijalankan di node sebagai `/root/soal_6.sh`.

<details>
<summary>Daftar IP statis seluruh node non-router (25 node)</summary>

| Node | Switch | IP | Gateway |
|---|---|---|---|
| Quarters | Switch-Quarters | `192.234.0.2/23` | `192.234.0.1` |
| Comm-Net | Switch-Comm | `192.234.2.2/24` | `192.234.2.1` |
| Hangar-Crew | Switch-Hangar | `192.234.3.2/25` | `192.234.3.1` |
| Sachiel | Switch-Bunker | `192.234.3.130/26` | `192.234.3.129` |
| Medic-Bay | Switch-Medic | `192.234.3.194/27` | `192.234.3.193` |
| Pen-Pen | Switch-Medic | `192.234.3.195/27` | `192.234.3.193` |
| Relay-Node | Switch-Relay | `192.234.3.226/27` | `192.234.3.225` |
| Garden-Staff | Switch-Garden | `192.234.4.2/27` | `192.234.4.1` |
| Dock-Crew | Switch-Dock | `192.234.4.34/28` | `192.234.4.33` |
| Entry-Plug | Switch-Lab | `192.234.4.50/29` | `192.234.4.49` |
| Dummy-Plug | Switch-Lab | `192.234.4.51/29` | `192.234.4.49` |
| Magi-Casper | Switch-Terminal | `192.234.4.58/29` | `192.234.4.57` |
| Magi-Balthasar | Switch-Terminal | `192.234.4.59/29` | `192.234.4.57` |
| Magi-Melchior | Switch-Terminal | `192.234.4.60/29` | `192.234.4.57` |
| Unit-01 | Switch-Cage | `192.234.4.66/29` | `192.234.4.65` |
| Unit-02 | Switch-Cage | `192.234.4.67/29` | `192.234.4.65` |
| Unit-00 | Switch-Cage | `192.234.4.68/29` | `192.234.4.65` |
| Lilith | Switch-Dogma | `192.234.4.74/29` | `192.234.4.73` |
| Adam | Switch-Dogma | `192.234.4.75/29` | `192.234.4.73` |
| Zeruel | Switch-Monolith | `192.234.4.82/29` | `192.234.4.81` |
| Armisael | Switch-Monolith | `192.234.4.83/29` | `192.234.4.81` |
| Radar-Array | Switch-Radar | `192.234.4.90/29` | `192.234.4.89` |
| Archive-Vault | Switch-Archive | `192.234.4.98/30` | `192.234.4.97` |
| Spy | Switch-Intel | `192.234.4.102/30` | `192.234.4.101` |
| Tokyo3-Core | Switch-Cmd | `192.234.4.106/30` | `192.234.4.105` |

</details>

### Verifikasi

#### 1. `ip -br` dan ping ke gateway di `Unit-01`

```
$ ip -br addr
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UNKNOWN        192.234.4.66/29
eth1             UNKNOWN        fe80::42:36ff:fe4f:4d01/64
eth2             UNKNOWN        fe80::42:36ff:fe4f:4d02/64
eth3             UNKNOWN        fe80::42:36ff:fe4f:4d03/64

$ ping -c 3 192.234.4.65
PING 192.234.4.65 (192.234.4.65) 56(84) bytes of data.
64 bytes from 192.234.4.65: icmp_seq=1 ttl=64 time=0.306 ms
64 bytes from 192.234.4.65: icmp_seq=2 ttl=64 time=0.484 ms
64 bytes from 192.234.4.65: icmp_seq=3 ttl=64 time=0.519 ms

--- 192.234.4.65 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2085ms
```

`eth0` Unit-01 memakai `192.234.4.66/29`, dan gateway Misato (`192.234.4.65`) menjawab ping.

#### 2. Seluruh node non-router

Setiap node diperiksa dengan `ip -4 -br addr show eth0` dan `ping -c 3 <gateway>`.

<details>
<summary>Hasil ping ke gateway (25/25 berhasil)</summary>

```
Quarters        192.234.0.2/23     gw 192.234.0.1    recv 3/3
Comm-Net        192.234.2.2/24     gw 192.234.2.1    recv 3/3
Hangar-Crew     192.234.3.2/25     gw 192.234.3.1    recv 3/3
Sachiel         192.234.3.130/26   gw 192.234.3.129  recv 3/3
Medic-Bay       192.234.3.194/27   gw 192.234.3.193  recv 3/3
Pen-Pen         192.234.3.195/27   gw 192.234.3.193  recv 3/3
Relay-Node      192.234.3.226/27   gw 192.234.3.225  recv 3/3
Garden-Staff    192.234.4.2/27     gw 192.234.4.1    recv 3/3
Dock-Crew       192.234.4.34/28    gw 192.234.4.33   recv 3/3
Entry-Plug      192.234.4.50/29    gw 192.234.4.49   recv 3/3
Dummy-Plug      192.234.4.51/29    gw 192.234.4.49   recv 3/3
Magi-Casper     192.234.4.58/29    gw 192.234.4.57   recv 3/3
Magi-Balthasar  192.234.4.59/29    gw 192.234.4.57   recv 3/3
Magi-Melchior   192.234.4.60/29    gw 192.234.4.57   recv 3/3
Unit-01         192.234.4.66/29    gw 192.234.4.65   recv 3/3
Unit-02         192.234.4.67/29    gw 192.234.4.65   recv 3/3
Unit-00         192.234.4.68/29    gw 192.234.4.65   recv 3/3
Lilith          192.234.4.74/29    gw 192.234.4.73   recv 3/3
Adam            192.234.4.75/29    gw 192.234.4.73   recv 3/3
Zeruel          192.234.4.82/29    gw 192.234.4.81   recv 3/3
Armisael        192.234.4.83/29    gw 192.234.4.81   recv 3/3
Radar-Array     192.234.4.90/29    gw 192.234.4.89   recv 3/3
Archive-Vault   192.234.4.98/30    gw 192.234.4.97   recv 3/3
Spy             192.234.4.102/30   gw 192.234.4.101  recv 3/3
Tokyo3-Core     192.234.4.106/30   gw 192.234.4.105  recv 3/3
```

</details>

Delapan router (Asuka, Kaji, Kaworu, Makoto, Mari, Maya, Ritsuko, Shinji) sempat berstatus stopped di GNS3. Setelah dinyalakan ulang, IP dan rute dari soal 2 dan 3 langsung aktif kembali tanpa konfigurasi ulang. Ini membuktikan konfigurasi di `/etc/network/interfaces` bertahan setelah restart.

<!-- TODO: tambahkan screenshot ip -br dan ping ke gateway di Unit-01 -->

## Soal 7
**Membangunkan MAGI:** Casper, Balthasar, dan Melchior di Switch-Terminal menunggu diaktifkan. Ritsuko ingin ketiganya melayani dulu, urusan keamanan dibahas nanti. Pasang iptables dan netcat-traditional lewat `/root/<nama>.sh`, lalu nyalakan listener sesuai port di glosarium. Dari Lilith, kirim pesan ke ketiganya dan ke port 5001 Balthasar. Tampilkan pesan yang diterima di tiap node.

### Jawaban dan Penjelasan

Port listener diambil dari tabel layanan di glosarium:

| Node | IP | Port TCP | Script |
|---|---|---|---|
| Magi-Casper | `192.234.4.58` | 5000 | `/root/magi-casper.sh` |
| Magi-Balthasar | `192.234.4.59` | 5000 dan 5001 | `/root/magi-balthasar.sh` |
| Magi-Melchior | `192.234.4.60` | 5000 | `/root/magi-melchior.sh` |

#### 1. Instalasi

```bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get install -y -q iptables netcat-traditional
update-alternatives --set nc /bin/nc.traditional
```

Image MAGI (Debian 13) bawaannya memakai `nc.openbsd`. `update-alternatives --set` mengarahkan perintah `nc` ke `nc.traditional`.

Saat `apt-get update`, repo `trixie-security` ditolak karena signature-nya dibuat setelah batas tanggal keyring di image. Repo utama `trixie` tetap valid, sehingga `iptables 1.8.11-2` dan `netcat-traditional 1.10-50` terpasang dari repo utama.

#### 2. Listener

```bash
listen() {
    port=$1
    pkill -f "nc-listener-$port" 2>/dev/null
    pkill -f "nc.traditional -v -n -l -p $port" 2>/dev/null
    : > /root/nc_$port.log
    setsid sh -c "while true; do nc.traditional -v -n -l -p $port >> /root/nc_$port.log 2>&1; done # nc-listener-$port" \
        < /dev/null > /dev/null 2>&1 &
}
listen 5000
listen 5001   # hanya di Balthasar
```

* **`-l -p <port>`** membuka listener TCP di port tersebut.
* **`-v -n`** mencatat baris `connect to ... from ...` berisi IP pengirim tanpa reverse DNS.
* **`while true`**: `nc.traditional` berhenti setelah satu koneksi selesai, jadi listener dijalankan ulang dalam loop.
* **`setsid ... &`** melepas loop dari sesi console agar tetap jalan setelah console ditutup.
* **`pkill`** di awal menghentikan loop lama, sehingga script aman dijalankan berulang.
* Pesan yang diterima dicatat di `/root/nc_<port>.log`.

#### 3. Pengirim di `Lilith`

```bash
send() {
    echo "$3" | nc -N -w 3 $1 $2
    echo "$1:$2 exit=$?"
}

send 192.234.4.58 5000 "Halo Casper dari Lilith (port 5000)"
send 192.234.4.59 5000 "Halo Balthasar dari Lilith (port 5000)"
send 192.234.4.59 5001 "Halo Balthasar dari Lilith (port 5001)"
send 192.234.4.60 5000 "Halo Melchior dari Lilith (port 5000)"
```

`-N` menutup koneksi setelah pesan terkirim, dan `-w 3` membatasi waktu tunggu koneksi.

Script lengkap ada di `perquest-scripts/soal_7/`.

### Verifikasi

#### 1. Paket dan listener di MAGI

```
$ dpkg -l iptables netcat-traditional | tail -2
ii  iptables           1.8.11-2     amd64        administration tools for packet filtering and NAT
ii  netcat-traditional 1.10-50      amd64        TCP/IP swiss army knife

$ ss -tlnp | grep nc        # Magi-Balthasar
LISTEN 0      1            0.0.0.0:5000      0.0.0.0:*    users:(("nc.traditional",pid=401,fd=3))
LISTEN 0      1            0.0.0.0:5001      0.0.0.0:*    users:(("nc.traditional",pid=405,fd=3))
```

Ketiga node MAGI menampilkan hasil `dpkg -l` yang sama.

#### 2. Pengiriman dari `Lilith`

```
192.234.4.58:5000 exit=0
192.234.4.59:5000 exit=0
192.234.4.59:5001 exit=0
192.234.4.60:5000 exit=0
```

#### 3. Pesan yang diterima di tiap node

**Magi-Casper** (`/root/nc_5000.log`):

```
listening on [any] 5000 ...
connect to [192.234.4.58] from (UNKNOWN) [192.234.4.74] 37812
Halo Casper dari Lilith (port 5000)
listening on [any] 5000 ...
```

**Magi-Balthasar** (`/root/nc_5000.log` dan `/root/nc_5001.log`):

```
listening on [any] 5000 ...
connect to [192.234.4.59] from (UNKNOWN) [192.234.4.74] 58582
Halo Balthasar dari Lilith (port 5000)
listening on [any] 5000 ...
```

```
listening on [any] 5001 ...
connect to [192.234.4.59] from (UNKNOWN) [192.234.4.74] 41966
Halo Balthasar dari Lilith (port 5001)
listening on [any] 5001 ...
```

**Magi-Melchior** (`/root/nc_5000.log`):

```
listening on [any] 5000 ...
connect to [192.234.4.60] from (UNKNOWN) [192.234.4.74] 54662
Halo Melchior dari Lilith (port 5000)
listening on [any] 5000 ...
```

Setiap pesan tercatat dari `192.234.4.74` (Lilith). Baris `listening on` kedua menunjukkan listener langsung siap menerima koneksi berikutnya.

<!-- TODO: tambahkan screenshot pengiriman dari Lilith dan log di tiap MAGI -->

## Soal 8
**Mengenali kondisi normal:** Pen-Pen dan Tokyo3-Core sudah ditandai sebagai calon sasaran pertama SEELE. Sebelum dilindungi, keduanya harus melayani dulu agar kamu tahu kondisi normalnya. Koneksi ke port 80 dijawab `Welcome to {hostname}`. Koneksi ke port 8080 di Tokyo3-Core dijawab `syifa imutz`. Tunjukkan nc dari Lilith ke ketiga port itu. Tunjukkan juga bahwa port yang tidak dilayani, misalnya 22, langsung gagal, bukan menggantung.

### Jawaban dan Penjelasan

| Node | IP | Port TCP | Balasan |
|---|---|---|---|
| Pen-Pen | `192.234.3.195` | 80 | `Welcome to Pen-Pen` |
| Tokyo3-Core | `192.234.4.106` | 80 | `Welcome to Tokyo3-Core` |
| Tokyo3-Core | `192.234.4.106` | 8080 | `syifa imutz` |

#### 1. Layanan di `Pen-Pen` dan `Tokyo3-Core`

Kedua node memakai Alpine dengan `nc` versi OpenBSD.

```bash
serve() {
    port=$1; reply=$2
    pkill -f "nc-service-$port" 2>/dev/null
    pkill -f "nc -v -n -l -N $port" 2>/dev/null
    : > /root/nc_$port.log
    setsid sh -c "while true; do echo \"$reply\" | nc -v -n -l -N $port >> /root/nc_$port.log 2>&1; done # nc-service-$port" \
        < /dev/null > /dev/null 2>&1 &
}
serve 80 "Welcome to $(hostname)"
serve 8080 "syifa imutz"   # hanya di Tokyo3-Core
```

* **`echo ... | nc -l <port>`** mengirim balasan ke setiap klien yang terhubung.
* **`$(hostname)`** diisi saat script dijalankan, sehingga balasannya `Welcome to Pen-Pen` atau `Welcome to Tokyo3-Core`.
* **`-N`** menutup koneksi setelah balasan terkirim, sehingga klien tidak menggantung menunggu data lain.
* **`while true`**: `nc` berhenti setelah satu koneksi, jadi listener dijalankan ulang dalam loop.
* **`setsid ... &`** melepas loop dari sesi console, dan **`pkill`** di awal membuat script aman dijalankan berulang.
* **`-v -n`** mencatat IP klien di `/root/nc_<port>.log`.

#### 2. Port yang tidak dilayani

Port 22 tidak perlu dikonfigurasi. Tidak ada proses yang listen di port itu dan belum ada firewall di kedua node. Kernel langsung membalas SYN dengan TCP RST, sehingga klien langsung mendapat `Connection refused`.

#### 3. Pengujian dari `Lilith`

```bash
probe() {
    start=$(date +%s%N)
    out=$(nc -v -n -w 5 $1 $2 < /dev/null 2>&1)
    rc=$?
    ms=$(( ($(date +%s%N) - start) / 1000000 ))
    echo "== $1:$2 exit=$rc durasi=${ms}ms"
    echo "$out"
}
```

`-w 5` membatasi waktu tunggu 5 detik. Jika port menggantung, durasinya akan mendekati 5000 ms. Exit code dan durasi menjadi bukti apakah koneksi berhasil, ditolak, atau menggantung.

Script lengkap ada di `perquest-scripts/soal_8/` dan dijalankan di node sebagai `/root/soal_8.sh`.

### Verifikasi

#### 1. `nc` dari `Lilith`

```
== 192.234.3.195:80 exit=0 durasi=5ms
Connection to 192.234.3.195 80 port [tcp/*] succeeded!
Welcome to Pen-Pen
== 192.234.4.106:80 exit=0 durasi=5ms
Connection to 192.234.4.106 80 port [tcp/*] succeeded!
Welcome to Tokyo3-Core
== 192.234.4.106:8080 exit=0 durasi=6ms
Connection to 192.234.4.106 8080 port [tcp/*] succeeded!
syifa imutz
== 192.234.3.195:22 exit=1 durasi=3ms
nc: connect to 192.234.3.195 port 22 (tcp) failed: Connection refused
== 192.234.4.106:22 exit=1 durasi=4ms
nc: connect to 192.234.4.106 port 22 (tcp) failed: Connection refused
```

| Tujuan | Exit code | Durasi | Hasil |
|---|---|---|---|
| Pen-Pen:80 | 0 | 5 ms | `Welcome to Pen-Pen` |
| Tokyo3-Core:80 | 0 | 5 ms | `Welcome to Tokyo3-Core` |
| Tokyo3-Core:8080 | 0 | 6 ms | `syifa imutz` |
| Pen-Pen:22 | 1 | 3 ms | `Connection refused`, langsung gagal |
| Tokyo3-Core:22 | 1 | 4 ms | `Connection refused`, langsung gagal |

Port 22 gagal dalam 3 sampai 4 ms, jauh di bawah batas 5000 ms, jadi koneksi langsung ditolak dan tidak menggantung.

#### 2. Log di server

**Pen-Pen** (`/root/nc_80.log`):

```
Listening on 0.0.0.0 80
Connection received on 192.234.4.74 56364
Listening on 0.0.0.0 80
```

**Tokyo3-Core** (`/root/nc_80.log` dan `/root/nc_8080.log`):

```
Listening on 0.0.0.0 80
Connection received on 192.234.4.74 42384
Listening on 0.0.0.0 80
```

```
Listening on 0.0.0.0 8080
Connection received on 192.234.4.74 49108
Listening on 0.0.0.0 8080
```

Setiap koneksi tercatat dari `192.234.4.74` (Lilith), dan listener langsung siap lagi untuk koneksi berikutnya.

<!-- TODO: tambahkan screenshot nc dari Lilith ke port 80, 8080, dan 22 -->

## Soal 15
**Banjir ping di pusat komando:** Instrumentality makin dekat, dan semua orang berebut mem-ping Tokyo3-Core. Banjir ping bisa melumpuhkannya. Batasi Tokyo3-Core agar hanya menjawab maksimal 5 ping per detik, dan buang kelebihannya. Aturan ini tidak boleh mengganggu ping di bawah batas. Aturan ini juga tidak boleh membatasi ping yang dikirim Tokyo3-Core sendiri. Pastikan rule benar-benar mengenai paket yang dituju. Periksa urutan rule dan jenis paketnya. Buktikan ping rapat dari Lilith, misalnya `ping -i 0.1 -c50`, sebagian hilang, dan tunjukkan counter rule pembuangan naik. Buktikan ping biasa semuanya berhasil, dengan jeda minimal 3 detik di antaranya.

### Jawaban dan Penjelasan

#### 1. Rule di `Tokyo3-Core`

```bash
# Chain khusus agar aman dijalankan berulang
iptables -N PING_LIMIT 2>/dev/null
iptables -F PING_LIMIT
iptables -A PING_LIMIT -m limit --limit 5/second --limit-burst 5 -j ACCEPT
iptables -A PING_LIMIT -j DROP

iptables -D INPUT -p icmp --icmp-type echo-request -j PING_LIMIT 2>/dev/null
iptables -I INPUT 1 -p icmp --icmp-type echo-request -j PING_LIMIT
```

* **Jenis paket.** Hanya `echo-request` (ICMP type 8) yang masuk ke chain `PING_LIMIT`. Saat Tokyo3-Core mengirim ping, paket yang kembali kepadanya adalah `echo-reply` (type 0). Paket itu tidak cocok dengan rule, sehingga ping keluar tidak ikut terbatasi.
* **Batas.** Modul `limit` memakai token bucket. `--limit 5/second` mengisi 5 token per detik, dan `--limit-burst 5` menampung paling banyak 5 token. Setiap ping memakai satu token. Ping yang datang saat token habis jatuh ke rule `DROP`.
* **Urutan.** Rule dipasang di posisi 1 INPUT (`-I INPUT 1`). Conntrack menganggap ping kedua dan seterusnya dengan id yang sama sebagai `ESTABLISHED`. Jika nanti ada rule `ACCEPT ESTABLISHED,RELATED` di atasnya, banjir ping akan lolos tanpa melewati batas.
* **Ping di bawah batas.** Ping dengan jeda 3 detik selalu mendapat token, karena bucket sudah terisi penuh lagi dalam 1 detik.
* **Aman dijalankan berulang.** Chain dibersihkan dengan `-F`, dan rule lompat ke chain dihapus dulu dengan `-D` sebelum dipasang lagi.

#### 2. Memasang Ulang Rule

Rule iptables hilang setiap kali node Tokyo3-Core di-restart, karena disimpan di memori kernel. Rule dipasang ulang dengan menjalankan script:

```bash
sh /root/soal_15.sh
```

Script ini aman dijalankan berulang. Script juga menyimpan salinan rule ke `/etc/iptables.rules` dan menambahkan baris `up iptables-restore` pada `eth0`, tetapi pemulihan otomatis ini tidak dapat diandalkan karena alasan yang sama dengan soal 5.

#### 3. Pengujian dari `Lilith`

```bash
ping -i 0.1 -c 50 192.234.4.106   # 10 ping per detik
sleep 3                           # tunggu token terisi kembali
ping -i 3 -c 5 192.234.4.106      # jeda 3 detik
```

`sleep 3` memastikan ping biasa tidak berangkat saat bucket masih kosong sisa ping rapat.

Script lengkap ada di `perquest-scripts/soal_15/` dan dijalankan di node sebagai `/root/soal_15.sh`.

### Verifikasi

#### 1. Rule di `Tokyo3-Core`

```
$ iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-N PING_LIMIT
-A INPUT -p icmp -m icmp --icmp-type 8 -j PING_LIMIT
-A PING_LIMIT -m limit --limit 5/sec -j ACCEPT
-A PING_LIMIT -j DROP
```

#### 2. Ping dari `Lilith`

Counter direset dengan `iptables -Z` sebelum pengujian.

```
== ping rapat: 10 ping/detik, sebagian harus hilang
50 packets transmitted, 30 received, 40% packet loss, time 5650ms
rtt min/avg/max/mdev = 0.491/0.872/1.381/0.233 ms
== ping biasa: jeda 3 detik, semua harus berhasil
5 packets transmitted, 5 received, 0% packet loss, time 13369ms
rtt min/avg/max/mdev = 0.416/0.692/1.240/0.283 ms
```

Ping rapat berlangsung sekitar 5,6 detik. Yang dijawab hanya 30 ping, yaitu 5 dari burst awal ditambah kira-kira 5 per detik. 20 ping lainnya dibuang.

#### 3. Counter rule

```
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num      pkts      bytes target     prot opt in     out     source               destination
1          55     4620 PING_LIMIT  icmp --  *      *       0.0.0.0/0            0.0.0.0/0            icmptype 8
Chain PING_LIMIT (1 references)
num      pkts      bytes target     prot opt in     out     source               destination
1          35     2940 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            limit: avg 5/sec burst 5
2          20     1680 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0
```

| Rule | Sebelum | Sesudah | Keterangan |
|---|---|---|---|
| `ACCEPT` (limit) | 0 | 35 | 30 ping rapat + 5 ping biasa |
| `DROP` | 0 | 20 | 20 ping rapat yang hilang |

Counter `DROP` naik tepat sebanyak ping rapat yang hilang (50 - 30 = 20), dan tidak ada ping biasa yang terbuang.

#### 4. Ping dari `Tokyo3-Core` tidak terbatasi

```
$ ping -c 3 192.234.4.74
3 packets transmitted, 3 received, 0% packet loss, time 2269ms
```

Counter `INPUT` tetap 55 (50 + 5 dari Lilith) setelah ping ini. Balasan `echo-reply` dari Lilith tidak masuk ke `PING_LIMIT`, sehingga ping keluar Tokyo3-Core tidak terkena batas.

<!-- TODO: tambahkan screenshot ping rapat dari Lilith dan counter iptables di Tokyo3-Core -->

## Soal 16
**Pencuri yang mencoba setiap pintu:** dari Switch-Lab, Dummy-Plug mengetuk port sensitif Tokyo3-Core satu per satu seperti pencuri. Ritsuko ingin tahu setiap percobaannya, dan pintunya harus dibanting. Setiap koneksi TCP dari Dummy-Plug ke port 22, 23, dan 3306 di Tokyo3-Core harus dicatat di log dengan prefix huruf besar `SCAN-NERV:`, lalu ditolak seketika. Port 80 dan 8080 tetap bisa diakses, dan klien lain tidak boleh terganggu. Buktikan `nc -w` dari Dummy-Plug ke port 22, 23, dan 3306 langsung ditolak, dan ke port 80 dan 8080 berhasil. Tunjukkan counter rule pencatatan, karena log kernel sering tidak terlihat di container.

### Jawaban dan Penjelasan

#### 1. Rule di `Tokyo3-Core`

```bash
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
```

* **Pencocokan.** Rule hanya mengenai paket TCP dari Dummy-Plug (`192.234.4.51`) ke port 22, 23, dan 3306. Port 80 dan 8080, serta klien selain Dummy-Plug, tidak cocok dengan rule ini sehingga tidak terganggu.
* **`--ctstate NEW`** mencatat setiap percobaan koneksi baru satu kali, bukan setiap paketnya.
* **`LOG --log-prefix "SCAN-NERV: "`** menulis percobaan ke log kernel. `LOG` tidak menghentikan pemrosesan, sehingga paket diteruskan ke rule berikutnya di chain.
* **`REJECT --reject-with tcp-reset`** membalas dengan TCP RST. Klien langsung mendapat `Connection refused`, tidak menunggu sampai timeout seperti pada `DROP`. Inilah "pintu dibanting".
* **Urutan.** Rule dipasang di posisi 1 INPUT, sebelum `PING_LIMIT` dari soal 15, agar tidak didahului rule lain. Urutan `LOG` lalu `REJECT` di dalam chain memastikan setiap paket dicatat sebelum ditolak.

Rule dipasang ulang dengan menjalankan script, sama seperti soal 15.

#### 2. Pengujian

Dummy-Plug dan Lilith (sebagai klien lain) menjalankan `nc` ke kelima port:

```bash
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
```

Listener port 80 dan 8080 dari soal 8 dijalankan ulang dulu dengan `sh /root/soal_8.sh` di Tokyo3-Core.

Script lengkap ada di `perquest-scripts/soal_16/` dan dijalankan di node sebagai `/root/soal_16.sh`.

### Verifikasi

#### 1. `nc` dari `Dummy-Plug`

```
== 192.234.4.106:22 exit=1 durasi=3ms
nc: connect to 192.234.4.106 port 22 (tcp) failed: Connection refused
== 192.234.4.106:23 exit=1 durasi=2ms
nc: connect to 192.234.4.106 port 23 (tcp) failed: Connection refused
== 192.234.4.106:3306 exit=1 durasi=3ms
nc: connect to 192.234.4.106 port 3306 (tcp) failed: Connection refused
== 192.234.4.106:80 exit=0 durasi=3ms
Connection to 192.234.4.106 80 port [tcp/*] succeeded!
Welcome to Tokyo3-Core
== 192.234.4.106:8080 exit=0 durasi=3ms
Connection to 192.234.4.106 8080 port [tcp/*] succeeded!
syifa imutz
```

Port 22, 23, dan 3306 ditolak dalam 2 sampai 3 ms, jauh di bawah batas `-w 5`. Port 80 dan 8080 tetap menjawab.

#### 2. Counter rule pencatatan

Counter direset dengan `iptables -Z` sebelum pengujian. Setelah Dummy-Plug mengetuk:

```
Chain SCAN_NERV (1 references)
num      pkts      bytes target     prot opt in     out     source               destination
1           3      180 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0            LOG flags 0 level 4 prefix "SCAN-NERV: "
2           3      180 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with tcp-reset
```

Rule `LOG` naik 3, satu untuk setiap port 22, 23, dan 3306. Rule `REJECT` juga naik 3, sehingga setiap percobaan dicatat lalu ditolak. Seperti yang disebut soal, baris log `SCAN-NERV:` tidak muncul di `dmesg` container, sehingga counter inilah buktinya.

#### 3. Klien lain tidak terganggu

`Lilith` menjalankan pengujian yang sama:

```
== 192.234.4.106:22 exit=1 durasi=5ms
nc: connect to 192.234.4.106 port 22 (tcp) failed: Connection refused
== 192.234.4.106:23 exit=1 durasi=4ms
nc: connect to 192.234.4.106 port 23 (tcp) failed: Connection refused
== 192.234.4.106:3306 exit=1 durasi=3ms
nc: connect to 192.234.4.106 port 3306 (tcp) failed: Connection refused
== 192.234.4.106:80 exit=0 durasi=3ms
Connection to 192.234.4.106 80 port [tcp/*] succeeded!
Welcome to Tokyo3-Core
== 192.234.4.106:8080 exit=0 durasi=3ms
Connection to 192.234.4.106 8080 port [tcp/*] succeeded!
syifa imutz
```

```
Chain INPUT (policy ACCEPT 19 packets, 1044 bytes)
num      pkts      bytes target     prot opt in     out     source               destination
1           3      180 SCAN_NERV  tcp  --  *      *       192.234.4.51         0.0.0.0/0            multiport dports 22,23,3306 ctstate NEW
```

Counter tetap 3 setelah Lilith mengetuk, sehingga Lilith tidak tercatat. Port 22, 23, dan 3306 tetap gagal untuk Lilith karena memang tidak ada layanan di port itu, dan kernel membalas RST. Port 80 dan 8080 tetap berhasil.

<!-- TODO: tambahkan screenshot nc dari Dummy-Plug dan counter SCAN_NERV di Tokyo3-Core -->

## Soal 17
**Sihir hitam di jalur paket:** Ritsuko meninggalkan memo di meja Gendo. Paket dari Casper ke Zeruel tidak pernah sampai ke Zeruel, karena ada router yang diam-diam mengalihkannya ke tempat lain. "Cari saja router yang menjadi gateway Switch-Terminal." Gendo menyuruhmu meniru router yang diam-diam itu untuk menjebak siapa pun. Di Fuyutsuki, alihkan setiap koneksi TCP dari Magi-Casper ke Zeruel supaya sampai di Pen-Pen. Casper tidak boleh sadar. Balasan yang ia terima harus tetap terlihat datang dari Zeruel. Ping tidak dialihkan. Nyalakan listener port 9000 di Pen-Pen dan Zeruel. Dari Casper, kirim pesan ke IP Zeruel port 9000. Buktikan pesan itu muncul di Pen-Pen, bukan di Zeruel. Tunjukkan juga tabel conntrack di Fuyutsuki.

### Jawaban dan Penjelasan

| Peran | Node | IP |
|---|---|---|
| Pengirim | Magi-Casper (Switch-Terminal) | `192.234.4.58` |
| Tujuan asli | Zeruel (Switch-Monolith) | `192.234.4.82` |
| Tujuan pengalihan | Pen-Pen (Switch-Medic) | `192.234.3.195` |
| Router pengalih | Fuyutsuki (gateway Switch-Terminal, `eth1`) | `192.234.4.57` |

#### 1. DNAT di `Fuyutsuki`

```bash
RULE="PREROUTING -i eth1 -s 192.234.4.58 -d 192.234.4.82 -p tcp -j DNAT --to-destination 192.234.3.195"

command -v conntrack >/dev/null || apk add -q conntrack-tools

iptables -t nat -D $RULE 2>/dev/null
iptables -t nat -A $RULE
```

* **`PREROUTING` + `DNAT`** mengubah alamat tujuan paket sebelum keputusan routing. Paket yang semula menuju Zeruel langsung dirutekan ke Pen-Pen lewat `eth2` (Maya).
* **`-i eth1 -s 192.234.4.58 -d 192.234.4.82`** membatasi pengalihan hanya untuk paket dari Casper yang masuk dari Switch-Terminal dan menuju Zeruel.
* **`-p tcp`** membuat hanya TCP yang dialihkan. Ping (ICMP) tidak cocok dengan rule, sehingga tetap sampai ke Zeruel.
* **`--to-destination 192.234.3.195`** tanpa port, sehingga port tujuan tetap 9000.
* **Casper tidak sadar.** Rule DNAT hanya diperiksa untuk paket pertama sebuah koneksi. Conntrack mencatat terjemahannya, lalu balasan dari Pen-Pen yang lewat Fuyutsuki dikembalikan sumbernya menjadi `192.234.4.82`. Fuyutsuki berada di jalur pergi dan pulang, karena Fuyutsuki adalah gateway Switch-Terminal sekaligus induk Maya.
* **`conntrack-tools`** dipasang untuk menampilkan tabel conntrack.

#### 2. Listener port 9000 di `Pen-Pen` dan `Zeruel`

```bash
pkill -f "nc-listener-9000" 2>/dev/null
pkill -f "nc -d -v -n -l 9000" 2>/dev/null
: > /root/nc_9000.log
setsid sh -c "while true; do nc -d -v -n -l 9000 >> /root/nc_9000.log 2>&1; done # nc-listener-9000" \
    < /dev/null > /dev/null 2>&1 &
```

Polanya sama dengan soal 8. `-d` membuat `nc` hanya menerima tanpa membaca stdin, dan `-v` mencatat IP pengirim.

#### 3. Pengirim di `Magi-Casper`

```bash
echo "Pesan rahasia Casper untuk Zeruel" | nc -v -n -N -w 3 192.234.4.82 9000
echo "exit=$?"
ping -c 3 192.234.4.82
```

Script lengkap ada di `perquest-scripts/soal_17/` dan dijalankan di node sebagai `/root/soal_17.sh`. Tabel conntrack dan counter dikosongkan dulu (`conntrack -F`, `iptables -t nat -Z PREROUTING`) sebelum pengujian.

### Verifikasi

#### 1. Yang dilihat `Magi-Casper`

```
Connection to 192.234.4.82 9000 port [tcp/*] succeeded!
exit=0
3 packets transmitted, 3 received, 0% packet loss, time 2237ms
```

Casper melihat koneksinya berhasil ke `192.234.4.82` (Zeruel), dan ping ke Zeruel tetap dijawab.

#### 2. Pesan muncul di `Pen-Pen`, bukan di `Zeruel`

**Pen-Pen** (`/root/nc_9000.log`):

```
Listening on 0.0.0.0 9000
Connection received on 192.234.4.58 51360
Pesan rahasia Casper untuk Zeruel
Listening on 0.0.0.0 9000
```

**Zeruel** (`/root/nc_9000.log`):

```
Listening on 0.0.0.0 9000
```

Pesan dari Casper (`192.234.4.58`) diterima Pen-Pen, sedangkan Zeruel tidak menerima koneksi apa pun.

#### 3. Tabel conntrack di `Fuyutsuki`

```
$ conntrack -L -p tcp
tcp      6 117 TIME_WAIT src=192.234.4.58 dst=192.234.4.82 sport=51360 dport=9000 src=192.234.3.195 dst=192.234.4.58 sport=9000 dport=51360 [ASSURED] mark=0 use=1

$ conntrack -L -p icmp
icmp     1 29 src=192.234.4.58 dst=192.234.4.82 type=8 code=0 id=389 src=192.234.4.82 dst=192.234.4.58 type=0 code=0 id=389 mark=0 use=1
```

Setiap entri conntrack berisi dua arah, yaitu arah asli lalu arah balasan yang diharapkan:

| Entri | Arah asli | Arah balasan | Arti |
|---|---|---|---|
| TCP 9000 | `src=192.234.4.58 dst=192.234.4.82` | `src=192.234.3.195 dst=192.234.4.58` | Casper mengirim ke Zeruel, tetapi balasan datang dari Pen-Pen. Ini bukti DNAT. Fuyutsuki mengganti sumber balasan menjadi Zeruel sebelum diteruskan ke Casper. |
| ICMP | `src=192.234.4.58 dst=192.234.4.82` | `src=192.234.4.82 dst=192.234.4.58` | Ping dijawab oleh Zeruel sendiri, sehingga tidak dialihkan. |

```
Chain PREROUTING (policy ACCEPT 1 packets, 84 bytes)
num      pkts      bytes target     prot opt in     out     source               destination
1           1       60 DNAT       tcp  --  eth1   *       192.234.4.58         192.234.4.82         to:192.234.3.195
```

Counter DNAT hanya bertambah 1, yaitu paket SYN pembuka koneksi TCP. Paket berikutnya ditangani conntrack. Paket ping pertama (84 byte) tercatat di policy `ACCEPT`, bukan di rule DNAT.

<!-- TODO: tambahkan screenshot log Pen-Pen dan Zeruel serta conntrack -L di Fuyutsuki -->

## Soal 18
**Gerbang Monolith dan Radar:** Monolith dan Radar menyimpan rahasia terbesar NERV, dan Shigeru menjaganya tanpa kompromi. Pasang aturan di Shigeru. Node di dalam zona boleh memulai koneksi ke mana saja, dan balasannya tetap sampai. Node di luar zona tidak boleh memulai koneksi ke dalam zona. Satu pengecualian: ping dari subnet Terminal boleh masuk. Tolak berdasarkan arah datangnya, yaitu semua yang datang dari sisi Shigeru yang menghadap Gendo. Jangan menulis subnet luar satu per satu, supaya subnet baru langsung ikut terblokir. Buktikan ping Casper ke Zeruel berhasil, sedangkan ping Lilith ke Zeruel gagal.

### Jawaban dan Penjelasan

Interface Shigeru:

| Interface | Arah | Subnet |
|---|---|---|
| `eth0` | Ke Gendou (luar zona) | L15 `192.234.4.164/30` |
| `eth1` | Switch-Monolith (zona) | `192.234.4.80/29` |
| `eth2` | Ke Makoto, Switch-Radar (zona) | L11 `192.234.4.148/30`, Radar `192.234.4.88/29` |

#### 1. Rule di `Shigeru`

```bash
TERMINAL=192.234.4.56/29

iptables -N ZONA_GATE 2>/dev/null
iptables -F ZONA_GATE
iptables -A ZONA_GATE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A ZONA_GATE -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A ZONA_GATE -j DROP

iptables -D FORWARD -i eth0 -j ZONA_GATE 2>/dev/null
iptables -I FORWARD 1 -i eth0 -j ZONA_GATE
```

* **Berdasarkan arah datang.** Semua paket yang diteruskan dan masuk dari `eth0` (sisi Gendou) diperiksa di chain `ZONA_GATE`. Subnet luar tidak ditulis satu per satu, sehingga subnet baru di balik Gendou langsung ikut tertolak.
* **`ESTABLISHED,RELATED`** meloloskan balasan untuk koneksi yang dimulai dari dalam zona, termasuk balasan dari internet.
* **Pengecualian Terminal.** Hanya `echo-request` dari `192.234.4.56/29` (Magi-Casper, Balthasar, Melchior) yang boleh membuka koneksi baru. Balasan dan request ping berikutnya sudah tertangani rule `ESTABLISHED`.
* **`DROP`** membuang koneksi baru lain dari luar zona.
* **Dari dalam zona tidak terkena.** Paket dari Monolith atau Radar yang keluar ke `eth0`, serta antara Monolith dan Radar (`eth1` ke `eth2`), tidak masuk lewat `eth0`. Jadi paket-paket itu tidak melewati `ZONA_GATE`.
* Rule dipasang di posisi 1 FORWARD. Chain khusus membuat script aman dijalankan berulang.

#### 2. Pengujian

* **Magi-Casper** (Terminal): ping Zeruel dan Radar-Array, seharusnya berhasil.
* **Lilith** (luar zona): ping Zeruel dan Radar-Array, serta `nc` ke Zeruel port 9000, seharusnya gagal.
* **Zeruel** (dalam zona): ping 8.8.8.8, ping Lilith, `nc` ke Tokyo3-Core port 80, dan ping Radar-Array, seharusnya semua berhasil.

Script lengkap ada di `perquest-scripts/soal_18/` dan dijalankan di node sebagai `/root/soal_18.sh`.

### Verifikasi

#### 1. Sebelum rule dipasang

Lilith masih bisa menjangkau zona:

```
== ping Zeruel (Monolith)
3 packets transmitted, 3 received, 0% packet loss, time 2224ms
== ping Radar-Array (Radar)
3 packets transmitted, 3 received, 0% packet loss, time 2278ms
== nc Zeruel port 9000
Connection to 192.234.4.82 9000 port [tcp/*] succeeded!
```

#### 2. Setelah rule dipasang

**Magi-Casper** (subnet Terminal):

```
== ping Zeruel (Monolith)
3 packets transmitted, 3 received, 0% packet loss, time 2233ms
== ping Radar-Array (Radar)
3 packets transmitted, 3 received, 0% packet loss, time 2223ms
```

**Lilith** (luar zona):

```
== ping Zeruel (Monolith)
3 packets transmitted, 0 received, 100% packet loss, time 2279ms
== ping Radar-Array (Radar)
3 packets transmitted, 0 received, 100% packet loss, time 2253ms
== nc Zeruel port 9000
nc: connect to 192.234.4.82 port 9000 (tcp) timed out: Operation in progress
exit=1
```

**Zeruel** (dalam zona):

```
== ping 8.8.8.8 (internet)
3 packets transmitted, 3 received, 0% packet loss, time 2220ms
== ping Lilith
3 packets transmitted, 3 received, 0% packet loss, time 2278ms
== nc Tokyo3-Core port 80
Connection to 192.234.4.106 80 port [tcp/*] succeeded!
Welcome to Tokyo3-Core
exit=0
== ping Radar-Array (sesama zona)
3 packets transmitted, 3 received, 0% packet loss, time 2223ms
```

Ping Casper ke Zeruel berhasil, sedangkan ping Lilith ke Zeruel gagal. Zeruel tetap bisa memulai koneksi ke luar dan menerima balasannya. Lilith gagal membalas ke zona hanya untuk koneksi yang ia mulai sendiri. Saat Zeruel yang memulai ping ke Lilith, balasan Lilith lolos sebagai `ESTABLISHED`.

#### 3. Counter `ZONA_GATE`

```
Chain ZONA_GATE (1 references)
num      pkts      bytes target     prot opt in     out     source               destination
1          14     1079 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
2           2      168 ACCEPT     icmp --  *      *       192.234.4.56/29      0.0.0.0/0            icmptype 8
3           9      684 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0
```

| Rule | Counter | Asal |
|---|---|---|
| `ESTABLISHED,RELATED` | 14 | Request lanjutan ping Casper, dan balasan untuk koneksi yang dimulai Zeruel |
| Ping Terminal | 2 | Request pertama dari dua ping Casper (ke Zeruel dan Radar-Array) |
| `DROP` | 9 | 6 ping Lilith dan 3 percobaan SYN dari `nc` Lilith |

<!-- TODO: tambahkan screenshot ping Casper dan Lilith ke Zeruel serta counter ZONA_GATE -->

## Soal 19
**Hukuman untuk sang pengkhianat:** hitung mundur tinggal beberapa menit. Armisael tidak boleh lagi bicara dengan siapa pun, tapi Zeruel di sebelahnya tidak boleh ikut terhukum. Blokir semua lalu lintas masuk dan keluar Armisael, termasuk ke gateway dan tetangga satu switch. Isolasi tidak boleh dikerjakan di dalam Armisael, karena pengkhianat tidak bisa dipercaya. Untuk uji nc, nyalakan listener TCP 9000 di Armisael, Zeruel, dan Lilith. Ke Seele pakai TCP 53. Buktikan ping dan nc dari Armisael ke Seele, Zeruel, dan Lilith gagal. Buktikan ping dan nc dari Zeruel ke Seele dan Lilith berhasil.

### Jawaban dan Penjelasan

Armisael (`192.234.4.83`, MAC `02:42:9e:4d:4b:00`) dan Zeruel (`192.234.4.82`) berada di Switch-Monolith dengan gateway Shigeru (`192.234.4.81`).

Lalu lintas Armisael terbagi menjadi dua jalur:

| Tujuan | Jalur | Tempat blokir |
|---|---|---|
| Gateway Shigeru, Lilith, Seele, dan semua di luar switch | Lewat Shigeru | Shigeru (INPUT, OUTPUT, FORWARD) |
| Zeruel (satu switch) | Langsung lewat switch, tidak melewati router | Zeruel (INPUT, OUTPUT) |

Switch GNS3 tidak bisa memfilter, dan isolasi tidak boleh dikerjakan di Armisael. Karena itu, blokir untuk tetangga satu switch dipasang di Zeruel sendiri. Zeruel hanya membuang lalu lintas dari dan ke Armisael, sehingga Zeruel tidak ikut terhukum.

#### 1. Rule di `Shigeru`

```bash
ARMISAEL_IP=192.234.4.83
ARMISAEL_MAC=02:42:9e:4d:4b:00

# Paket dari Armisael (MAC dan IP), dipakai di INPUT dan FORWARD
iptables -N ISOLASI_MASUK 2>/dev/null
iptables -F ISOLASI_MASUK
iptables -A ISOLASI_MASUK -m mac --mac-source $ARMISAEL_MAC -j DROP
iptables -A ISOLASI_MASUK -s $ARMISAEL_IP -j DROP

# Paket menuju Armisael, dipakai di OUTPUT dan FORWARD
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
```

* **MAC dan IP.** Paket dari Armisael dikenali dari MAC sumbernya, sehingga pengkhianat tidak bisa lolos hanya dengan mengganti IP. Rule IP sumber menjadi lapis tambahan.
* **Dua chain.** Match `mac` hanya berlaku untuk paket yang masuk dari interface (INPUT, FORWARD, PREROUTING). Jika dipakai di OUTPUT, iptables menolak dengan `RULE_INSERT failed (Invalid argument)`. Karena itu, paket menuju Armisael dicocokkan dengan IP tujuan di chain terpisah.
* **INPUT dan OUTPUT** memutus Armisael dari Shigeru sebagai gateway. **FORWARD** memutus Armisael dari semua tujuan di luar switch, ke dua arah.
* **Urutan.** Kedua chain dipasang di posisi 1, sebelum `ZONA_GATE` dari soal 18, sehingga tidak ada rule ACCEPT yang mendahuluinya.

#### 2. Rule di `Zeruel`

```bash
iptables -N ISOLASI_MASUK 2>/dev/null
iptables -F ISOLASI_MASUK
iptables -A ISOLASI_MASUK -m mac --mac-source $ARMISAEL_MAC -j DROP
iptables -A ISOLASI_MASUK -s $ARMISAEL_IP -j DROP
iptables -D INPUT -j ISOLASI_MASUK 2>/dev/null
iptables -I INPUT 1 -j ISOLASI_MASUK

iptables -N ISOLASI_KELUAR 2>/dev/null
iptables -F ISOLASI_KELUAR
iptables -A ISOLASI_KELUAR -d $ARMISAEL_IP -j DROP
iptables -D OUTPUT -j ISOLASI_KELUAR 2>/dev/null
iptables -I OUTPUT 1 -j ISOLASI_KELUAR
```

Polanya sama dengan Shigeru, tetapi tanpa FORWARD karena Zeruel bukan router.

#### 3. Listener dan uji

Listener TCP 9000 di Armisael, Zeruel, dan Lilith memakai pola soal 17 (`nc -d -v -n -l 9000` dalam loop, dicatat di `/root/nc_9000.log`). Di Armisael hanya dijalankan listener dan perintah uji, tanpa rule apa pun (`iptables -S` Armisael kosong).

```bash
ping -c 3 -W 2 8.8.8.8
nc -v -n -z -w 3 8.8.8.8 53
ping -c 3 -W 2 <Zeruel / Lilith>
echo "Halo dari ..." | nc -v -n -N -w 3 <Zeruel / Lilith> 9000
```

Script lengkap ada di `perquest-scripts/soal_19/` dan dijalankan di node sebagai `/root/soal_19.sh`.

### Verifikasi

#### 1. Dari `Armisael`: semua gagal

```
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
== ping Seele 8.8.8.8
3 packets transmitted, 0 received, 100% packet loss, time 2281ms
== nc Seele 8.8.8.8:53
nc: connect to 8.8.8.8 port 53 (tcp) timed out: Operation in progress
exit=1
== ping Zeruel
3 packets transmitted, 0 received, 100% packet loss, time 2258ms
== nc Zeruel:9000
nc: connect to 192.234.4.82 port 9000 (tcp) timed out: Operation in progress
exit=1
== ping Lilith
3 packets transmitted, 0 received, 100% packet loss, time 2259ms
== nc Lilith:9000
nc: connect to 192.234.4.74 port 9000 (tcp) timed out: Operation in progress
exit=1
== ping gateway Shigeru
3 packets transmitted, 0 received, 100% packet loss, time 2258ms
```

Tiga baris pertama menunjukkan Armisael sendiri tidak punya rule iptables, jadi isolasi tidak dikerjakan di dalam Armisael.

#### 2. Dari `Zeruel`: Seele dan Lilith berhasil

```
== ping Seele 8.8.8.8
3 packets transmitted, 3 received, 0% packet loss, time 2219ms
== nc Seele 8.8.8.8:53
Connection to 8.8.8.8 53 port [tcp/*] succeeded!
exit=0
== ping Lilith
3 packets transmitted, 3 received, 0% packet loss, time 2249ms
== nc Lilith:9000
Connection to 192.234.4.74 9000 port [tcp/*] succeeded!
exit=0
```

Zeruel juga tidak bisa menjangkau Armisael, karena hubungan dengan Armisael diputus dari dua arah:

```
$ ping -c 2 -W 2 192.234.4.83
2 packets transmitted, 0 received, 100% packet loss, time 1135ms
$ echo x | nc -v -n -N -w 3 192.234.4.83 9000
nc: connect to 192.234.4.83 port 9000 (tcp) timed out: Operation in progress
exit=1
```

#### 3. Log listener

| Node | Isi `/root/nc_9000.log` |
|---|---|
| Lilith | `Connection received on 192.234.4.82` lalu `Halo dari Zeruel` (pesan Armisael tidak ada) |
| Zeruel | Hanya `Listening on 0.0.0.0 9000` (pesan Armisael tidak sampai) |
| Armisael | Hanya `Listening on 0.0.0.0 9000` (pesan Zeruel tidak sampai) |

#### 4. Counter

**Shigeru:**

```
Chain ISOLASI_MASUK (2 references)
    pkts      bytes target     prot opt in     out     source               destination
      15     1116 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            MAC 02:42:9e:4d:4b:00
       0        0 DROP       all  --  *      *       192.234.4.83         0.0.0.0/0
```

15 paket dari Armisael dibuang berdasarkan MAC: ping Seele (3), SYN ke port 53 (3), ping Lilith (3), SYN ke Lilith (3), dan ping gateway (3).

**Zeruel:**

```
Chain ISOLASI_MASUK (1 references)
    pkts      bytes target     prot opt in     out     source               destination
       6      432 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            MAC 02:42:9e:4d:4b:00
       0        0 DROP       all  --  *      *       192.234.4.83         0.0.0.0/0
Chain ISOLASI_KELUAR (1 references)
    pkts      bytes target     prot opt in     out     source               destination
       5      348 DROP       all  --  *      *       0.0.0.0/0            192.234.4.83
```

Zeruel membuang 6 paket dari Armisael (ping 3 dan SYN 3), serta 5 paket miliknya sendiri menuju Armisael (ping 2 dan SYN 3).

<!-- TODO: tambahkan screenshot uji dari Armisael dan Zeruel serta counter isolasi -->

## Soal 20
**Uji kebakaran Geofront:** NERV harus bisa dibangun ulang dengan cepat. Pilih tiga node sendiri, minimal satu router. Di tiap node, simpan dulu rule dengan `iptables-save` ke `/root/<nama>.rules`. Lalu hapus semua rule iptables termasuk tabel nat, dan hapus rute yang kamu tambahkan sendiri. Pulihkan rule dengan `iptables-restore`, dan pulihkan rute dengan `/root/<nama>.sh`. Lakukan pemulihan itu dua kali berturut-turut. Hasilnya harus sama: rule dan rute tidak dobel, dan node berfungsi seperti semula. Buktikan jumlah baris `iptables -S` dan `iptables -t nat -S` sama setelah pemulihan pertama dan kedua. Buktikan juga node itu berfungsi lagi.

### Jawaban dan Penjelasan

Tiga router dipilih karena masing-masing punya rule dan rute buatan sendiri:

| Node | Rule | Rute sendiri | Uji fungsi |
|---|---|---|---|
| Gendou | MASQUERADE (soal 4) dan firewall `DROP` (soal 5) | 20 rute statis (soal 3) | Lilith ke internet |
| Fuyutsuki | DNAT Casper ke Pen-Pen (soal 17) | default dan 2 rute (soal 3) | Pesan Casper ke Zeruel sampai di Pen-Pen |
| Shigeru | `ZONA_GATE` (soal 18) dan isolasi Armisael (soal 19) | default dan 1 rute (soal 3) | Casper bisa, Lilith dan Armisael tidak |

#### 1. Script pemulihan rute `/root/<nama>.sh`

Isinya baris `ip route replace` dari soal 3. Contoh `/root/shigeru.sh`:

```bash
ip route replace default via 192.234.4.165   # Gendou
ip route replace 192.234.4.88/29 via 192.234.4.150   # Radar (Makoto)
```

`ip route replace` membuat rute baru jika belum ada, dan menimpanya jika sudah ada. Script ini aman dijalankan berulang tanpa membuat rute dobel. Script ini hanya berisi rute, dan tidak mengubah IP atau rule.

#### 2. Script uji `/root/soal_20.sh`

```bash
NAMA=$(hostname | tr 'A-Z' 'a-z')
RULES=/root/$NAMA.rules
RUTE=/root/$NAMA.sh

# 1. Simpan
iptables-save > $RULES

# 2. Hapus semua rule (filter dan nat) dan rute sendiri
for T in filter nat; do
    iptables -t $T -F
    iptables -t $T -X
done
for CH in INPUT FORWARD OUTPUT; do iptables -P $CH ACCEPT; done
grep '^ip route replace' $RUTE | sed 's/#.*//; s/replace/del/' | while read CMD; do $CMD; done

# 3. Pemulihan pertama, 4. pemulihan kedua
iptables-restore < $RULES
sh $RUTE > /dev/null
```

* **`-F`** menghapus semua rule, **`-X`** menghapus chain buatan sendiri (misalnya `ZONA_GATE`), dan policy dikembalikan ke `ACCEPT`, termasuk policy `DROP` di Gendou.
* **Rute yang dihapus** hanya rute yang tercantum di `/root/<nama>.sh`. Baris `replace` diubah menjadi `del`. Rute connected dan default Gendou dari DHCP NAT1 bukan buatan sendiri, sehingga tidak dihapus.
* **`iptables-restore` tidak membuat rule dobel.** Perintah ini mengganti seluruh isi tabel dengan isi file, bukan menambahkannya.
* Setiap tahap mencatat jumlah baris `iptables -S`, `iptables -t nat -S`, dan `ip route`. Isi lengkap setelah pemulihan pertama, kedua, dan kondisi awal juga dibandingkan dengan `cmp`.

Script lengkap ada di `perquest-scripts/soal_20/`. `uji.sh` dijalankan di node sebagai `/root/soal_20.sh`, dan `<nama>.sh` dikirim sebagai `/root/<nama>.sh`.

### Verifikasi

#### 1. Jumlah baris di setiap tahap

**Gendou:**

```
== 1. Simpan rule ke /root/gendou.rules
-- awal: iptables -S=10 baris, iptables -t nat -S=5 baris, ip route=30 baris
== 2. Hapus semua rule (filter dan nat) dan rute sendiri
-- setelah dihapus: iptables -S=3 baris, iptables -t nat -S=4 baris, ip route=10 baris
== 3. Pemulihan pertama
-- pemulihan 1: iptables -S=10 baris, iptables -t nat -S=5 baris, ip route=30 baris
== 4. Pemulihan kedua
-- pemulihan 2: iptables -S=10 baris, iptables -t nat -S=5 baris, ip route=30 baris
== 5. Perbandingan isi
pemulihan 1 == pemulihan 2
awal == pemulihan 2
```

**Fuyutsuki:**

```
== 1. Simpan rule ke /root/fuyutsuki.rules
-- awal: iptables -S=3 baris, iptables -t nat -S=5 baris, ip route=7 baris
== 2. Hapus semua rule (filter dan nat) dan rute sendiri
-- setelah dihapus: iptables -S=3 baris, iptables -t nat -S=4 baris, ip route=4 baris
== 3. Pemulihan pertama
-- pemulihan 1: iptables -S=3 baris, iptables -t nat -S=5 baris, ip route=7 baris
== 4. Pemulihan kedua
-- pemulihan 2: iptables -S=3 baris, iptables -t nat -S=5 baris, ip route=7 baris
== 5. Perbandingan isi
pemulihan 1 == pemulihan 2
awal == pemulihan 2
```

**Shigeru:**

```
== 1. Simpan rule ke /root/shigeru.rules
-- awal: iptables -S=17 baris, iptables -t nat -S=4 baris, ip route=5 baris
== 2. Hapus semua rule (filter dan nat) dan rute sendiri
-- setelah dihapus: iptables -S=3 baris, iptables -t nat -S=4 baris, ip route=3 baris
== 3. Pemulihan pertama
-- pemulihan 1: iptables -S=17 baris, iptables -t nat -S=4 baris, ip route=5 baris
== 4. Pemulihan kedua
-- pemulihan 2: iptables -S=17 baris, iptables -t nat -S=4 baris, ip route=5 baris
== 5. Perbandingan isi
pemulihan 1 == pemulihan 2
awal == pemulihan 2
```

| Node | `iptables -S` (awal / hapus / pulih 1 / pulih 2) | `iptables -t nat -S` | `ip route` |
|---|---|---|---|
| Gendou | 10 / 3 / 10 / 10 | 5 / 4 / 5 / 5 | 30 / 10 / 30 / 30 |
| Fuyutsuki | 3 / 3 / 3 / 3 | 5 / 4 / 5 / 5 | 7 / 4 / 7 / 7 |
| Shigeru | 17 / 3 / 17 / 17 | 4 / 4 / 4 / 4 | 5 / 3 / 5 / 5 |

Setelah dihapus, `iptables -S` tinggal 3 baris (tiga policy `ACCEPT`) dan `iptables -t nat -S` tinggal 4 baris (empat policy). Jumlah baris setelah pemulihan pertama dan kedua sama, dan isinya identik dengan kondisi awal. Jadi rule dan rute tidak dobel.

#### 2. Node berfungsi lagi

```
== Gendou: Lilith ke internet
3 packets transmitted, 3 received, 0% packet loss, time 2219ms
Connection to 8.8.8.8 53 port [tcp/*] succeeded!
exit=0
== Shigeru: Lilith ke Zeruel
3 packets transmitted, 0 received, 100% packet loss, time 2251ms
== Shigeru: Casper ke Zeruel
3 packets transmitted, 3 received, 0% packet loss, time 2222ms
== Fuyutsuki: Casper ke Zeruel:9000
Connection to 192.234.4.82 9000 port [tcp/*] succeeded!
exit=0
== Shigeru: Armisael ke internet
3 packets transmitted, 0 received, 100% packet loss, time 2286ms
```

Log `/root/nc_9000.log` di Pen-Pen:

```
Connection received on 192.234.4.58 48638
Pesan Casper setelah pemulihan
Listening on 0.0.0.0 9000
```

Log Zeruel tetap hanya berisi `Listening on 0.0.0.0 9000`.

| Node | Fungsi | Hasil |
|---|---|---|
| Gendou | NAT dan rute: Lilith ke 8.8.8.8 | Berhasil |
| Fuyutsuki | DNAT: pesan Casper ke Zeruel sampai di Pen-Pen | Berhasil |
| Shigeru | `ZONA_GATE`: Casper bisa ping Zeruel, Lilith tidak | Sesuai |
| Shigeru | Isolasi Armisael: Armisael tidak bisa ke internet | Sesuai |

<!-- TODO: tambahkan screenshot output soal_20.sh di ketiga router dan uji fungsi -->
