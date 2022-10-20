
### DOTint LANCACHE---



Disk /dev/sda: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdb: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdc: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdd: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sde: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdf: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdg: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors
Disk /dev/sdh: 1.76 TiB, 1920383410176 bytes, 3750748848 sectors



sgdisk --zap-all /dev/sda scsi-35001173100999a64 Serial Number:    A00295EA
sgdisk --zap-all /dev/sdb scsi-35002538c5037e01d Serial Number:    S37MNX0HC01671
sgdisk --zap-all /dev/sdc scsi-35002538c5037eb4d Serial Number:    S37MNX0HC01783
sgdisk --zap-all /dev/sdd scsi-35002538c5037f032 Serial Number:    S37MNX0HC01832
sgdisk --zap-all /dev/sde scsi-35001173100a56e24 Serial Number:    A006EA07
sgdisk --zap-all /dev/sdf scsi-35002538c5037d7b9 Serial Number:    S37MNX0HC01587
sgdisk --zap-all /dev/sdg scsi-35002538c5037df6a Serial Number:    S37MNX0HC01664
sgdisk --zap-all /dev/sdh scsi-35002538c5037de04 Serial Number:    S37MNX0HC01650



root@lancache:~# lsscsi -s
[0:0:0:0]    disk    ATA      SDLF1CRR-019T-1H RPA1  /dev/sda   1.92TB
[0:0:1:0]    disk    ATA      MZ7LM1T9HMJP0D3  GA38  /dev/sdb   1.92TB
[0:0:2:0]    disk    ATA      MZ7LM1T9HMJP0D3  GC5B  /dev/sdc   1.92TB
[0:0:3:0]    disk    ATA      MZ7LM1T9HMJP0D3  GC5B  /dev/sdd   1.92TB
[0:0:4:0]    disk    ATA      SDLF1CRR-019T-1H RPA1  /dev/sde   1.92TB
[0:0:5:0]    disk    ATA      MZ7LM1T9HMJP0D3  GC57  /dev/sdf   1.92TB
[0:0:6:0]    disk    ATA      MZ7LM1T9HMJP0D3  GC57  /dev/sdg   1.92TB
[0:0:7:0]    disk    ATA      MZ7LM1T9HMJP0D3  GC57  /dev/sdh   1.92TB


[0:0:32:0]   enclosu DP       BP13G+           2.23  -               -
[10:0:0:0]   disk    ATA      Samsung SSD 870  1B6Q  /dev/sdi    250GB ( Serial No: S6PDNZ0R911075X)




smartctl -d megaraid,0 -a /dev/sda |grep Serial
smartctl -d megaraid,1 -a /dev/sda |grep Serial
smartctl -d megaraid,2 -a /dev/sda |grep Serial
smartctl -d megaraid,3 -a /dev/sda |grep Serial
smartctl -d megaraid,4 -a /dev/sda |grep Serial
smartctl -d megaraid,5 -a /dev/sda |grep Serial
smartctl -d megaraid,6 -a /dev/sda |grep Serial
smartctl -d megaraid,7 -a /dev/sda |grep Serial



root@lancache:~# smartctl -d megaraid,0 -a /dev/sda |grep Serial
Serial Number:    A00295EA
root@lancache:~# smartctl -d megaraid,1 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01671
root@lancache:~# smartctl -d megaraid,2 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01783
root@lancache:~# smartctl -d megaraid,3 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01832
root@lancache:~# smartctl -d megaraid,4 -a /dev/sda |grep Serial
Serial Number:    A006EA07
root@lancache:~# smartctl -d megaraid,5 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01587
root@lancache:~# smartctl -d megaraid,6 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01664
root@lancache:~# smartctl -d megaraid,7 -a /dev/sda |grep Serial
Serial Number:    S37MNX0HC01650





sudo zpool create -o ashift=12 -f volume1 raidz \
scsi-35001173100999a64 \
scsi-35001173100a56e24 \
scsi-35002538c5037d7b9 \
scsi-35002538c5037de04 \
scsi-35002538c5037df6a \
scsi-35002538c5037e01d \
scsi-35002538c5037eb4d \
scsi-35002538c5037f032



sudo zfs set sync=disabled volume1
sudo zfs set compress=lz4 volume1
sudo zfs set atime=off volume1
sudo zfs set xattr=sa volume1
sudo zfs set relatime=off volume1
sudo zfs set acltype=posixacl volume1






1073741824*48
51539607552

echo "options zfs zfs_arc_max=51539607552" > /etc/modprobe.d/zfs.conf



sudo swapoff /swap.img
sudo rm -fr /swap.img
sudo fallocate -l 32G /swap.img
sudo chmod 0600 /swap.img
sudo mkswap /swap.img
sudo swapon /swap.img




### --dflix-server-disk-information


apt update
sudo lshw -class network -businfo
sudo vim /etc/apt/sources.list
apt update
apt upgrade -y
sudo apt install -y ifupdown vim net-tools
sudo apt autoremove -y --purge netplan.io resolvconf
rm -fr /etc/netplan

ifconfig -a
sudo vim /etc/default/grub
sudo update-grub
sudo vim /etc/network/interfaces
ip link set ens1 up
ethtool ens1
apt install --install-recommends linux-generic-hwe-18.04 
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved.service
rm -fr /etc/resolv.conf
touch /etc/resolv.conf
echo "nameserver 1.0.0.3" > /etc/resolv.conf
apt update
sudo apt autoremove --purge unattended-upgrades landscape-common -y
sudo apt install -y wget axel iftop htop vim iperf3 mtr mc bwm-ng snmpd openssh-server arping rclone sshfs rsync telnet pv build-essential
sudo vim /etc/security/limits.conf
vim /etc/sysctl.conf 
sysctl -p
apt install python3-pip
pip3 install bpytop --upgrade
bpytop 
dpkg-reconfigure dash
dpkg-reconfigure tzdata
rm -fr /etc/update-motd.d/*
sudo systemctl stop apparmor
sudo systemctl disable apparmor
sudo apt remove --assume-yes --purge apparmor
sudo apt remove --purge lxd lxd-client
sudo apt autoremove --purge unattended-upgrades
htop
sudo swapoff /swapfile
sudo fallocate -l 32G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
htop
sudo vim /etc/ssh/sshd_config
passwd root
cat /etc/network/interfaces
ifconfig ens1
reboot
exit
ifconfig 
ethtool ens1
sudo add-apt-repository ppa:jonathonf/zfs
sudo apt install zfsutils-linux gdisk
zpool list
zfs list
sudo fdisk -l |grep sd* |grep GiB
sudo fdisk -l |grep sd* |grep TiB
sudo fdisk -l |grep sd* |grep TiB | wc -l
ll /dev/disk/by-id/
ll /dev/disk/by-id/ 
ll /dev/disk/by-id/ |more
df -h
ll /dev/disk/by-id/ |more
sudo fdisk -l |grep sd* |grep TiB
sudo fdisk -l |grep sd* | more
cd /dev/disk/by-id/
ls
ll
ll |more
cd
sudo apt-get install hdparm
sudo apt-get install smartmontools
sudo apt-get install lshw
sgdisk --zap-all /dev/sda
sgdisk --zap-all /dev/sdb
sgdisk --zap-all /dev/sdc
sgdisk --zap-all /dev/sdd
sgdisk --zap-all /dev/sde
sgdisk --zap-all /dev/sdf
sgdisk --zap-all /dev/sdg
sgdisk --zap-all /dev/sdh
sgdisk --zap-all /dev/sdi
sgdisk --zap-all /dev/sdj
sgdisk --zap-all /dev/sdk
sgdisk --zap-all /dev/sdl
sgdisk --zap-all /dev/sdw
sgdisk --zap-all /dev/sdx
sgdisk --zap-all /dev/sdy
sgdisk --zap-all /dev/sdz
sgdisk --zap-all /dev/sdaa
sgdisk --zap-all /dev/sdab
sudo zpool create -o ashift=12 -f volume1 \ 
raidz scsi-35000cca26c176cf4 scsi-35000cca26c160054 scsi-35000cca26c19ebe0 scsi-35000cca26c1a2480 scsi-35000cca26c16005c scsi-35000cca26c19dff0 raidz scsi-35000cca26c19fcfc scsi-35000cca2663df500 scsi-35000cca26c19d04c scsi-35000cca26c18f0a0 scsi-35000cca26c182b98 scsi-35000cca2663cc258 raidz scsi-35000cca2663ace38 scsi-35000cca26c1620a8 scsi-35000cca266a9971c scsi-35000cca26c1827e4 scsi-35000cca26c18a994 \
sudo zpool create -o ashift=12 -f volume1 raidz scsi-35000cca26c176cf4 scsi-35000cca26c160054 scsi-35000cca26c19ebe0 scsi-35000cca26c1a2480 scsi-35000cca26c16005c scsi-35000cca26c19dff0 raidz scsi-35000cca26c19fcfc scsi-35000cca2663df500 scsi-35000cca26c19d04c scsi-35000cca26c18f0a0 scsi-35000cca26c182b98 scsi-35000cca2663cc258 raidz scsi-35000cca2663ace38 scsi-35000cca26c1620a8 scsi-35000cca266a9971c scsi-35000cca26c1827e4 scsi-35000cca26c18a994 scsi-35000cca26c1a0e28
zpool status
zfs list
sgdisk --zap-all /dev/sdm
sgdisk --zap-all /dev/sdn
sgdisk --zap-all /dev/sdo
sgdisk --zap-all /dev/sdq
sgdisk --zap-all /dev/sdr
sgdisk --zap-all /dev/sds
sgdisk --zap-all /dev/sdt
sgdisk --zap-all /dev/sdu
sgdisk --zap-all /dev/sdv
sudo zpool add -f volume1 cache scsi-3500143804074fa4c scsi-3500143804074fa4d scsi-3500143804074fa4e scsi-35001438040750cc0 scsi-35001438040750cc1 scsi-35001438040750cc2 scsi-35001438040750cc3 scsi-35001438040750cc4 scsi-35001438040750cc5
zpool status
zfs list
zfs set sync=disabled volume1
zfs set compress=lz4 volume1
zfs set atime=off volume1
zfs set xattr=sa volume1
zfs set relatime=off volume1
zfs set acltype=posixacl volume1
apt install nginx nginx-extras
htop
cd /etc/nginx/
ls
cp nginx.conf nginx.conf.orig
echo "" > nginx.conf
vim nginx.conf
zfs list
zfs create volume1/data
zfs list
vim nginx.conf
nginx -t
systemctl restart nginx

cd /volume1/
ls
cd data/
ls
mv dot-etc .etc
mv fancyetc.tar /opt/
ll
chmod +x .etc
touch kk zz
mkdir Movies
mkdir Games
cd /etc/nginx/sites-enabled/
ll
cd ..
ls
vim nginx.conf
systemctl rstart nginx
systemctl restart nginx
tail -f /var/log/ac
tail -f /var/log/nginx/access.log 
cd /volume1/data/

cp -r .etc /volume1/data/
cd /volume1/data/
ls
cd .etc/
ls
cd nf
cd nginx/
ls
cd fancyindex_theme/
ls
vim header.html 
vim index.html 
ls
vim fheader.html 
ls
cd assets/
sl
ls
cd css/
ls
vim style.css 
vim findex.css 
cd ..
ls
cd ..
ls
cd css/
ls
vim style.css 
cd
vim /etc/network/interfaces
cat /etc/network/interfaces
ifconfig ens1:0 172.16.172.150/30
zpool status
echo 'performance' > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
vim /usr/bin/cpu-freq.sh
chmod +x /usr/bin/cpu-freq.sh


##################################

  *-disk:0
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.1.0
       bus info: scsi@0:0.1.0
       logical name: /dev/sda
       version: A21D
       serial: 1DGGBPTZ
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=379d015c-3421-0d47-9c09-32b5fc1b9e89 logicalsectorsize=512 sectorsize=4096
  *-disk:1
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.a.0
       bus info: scsi@0:0.10.0
       logical name: /dev/sdj
       version: A21D
       serial: 7JH3299K
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=6feb7e26-01e4-6741-8b0a-d588f6e6f59a logicalsectorsize=512 sectorsize=4096
  *-disk:2
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.b.0
       bus info: scsi@0:0.11.0
       logical name: /dev/sdk
       version: A21D
       serial: 1DGG926Z
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=1cf0eeec-2b10-7f4d-ba61-34faa3784946 logicalsectorsize=512 sectorsize=4096
  *-disk:3
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.c.0
       bus info: scsi@0:0.12.0
       logical name: /dev/sdl
       version: A21D
       serial: 1DGER65Z
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=0834cbd7-f23e-314a-97d6-edef20867e89 logicalsectorsize=512 sectorsize=4096
  *-disk:4
       description: ATA Disk
       product: SDLF1DAR480G-1HH
       physical id: 0.d.0
       bus info: scsi@0:0.13.0
       logical name: /dev/sdm
       version: RP41
       serial: A019BDD6
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=7d130077-ec7f-1d42-8cad-0e38b8df8762 logicalsectorsize=512 sectorsize=4096
  *-disk:5
       description: ATA Disk
       product: SDLF1DAR480G-1HH
       physical id: 0.e.0
       bus info: scsi@0:0.14.0
       logical name: /dev/sdn
       version: RP41
       serial: A018FBC7
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=36a00785-e2be-924c-a3de-dbe7e0c95c41 logicalsectorsize=512 sectorsize=4096
  *-disk:6
       description: ATA Disk
       product: PNY CS900 480GB
       physical id: 0.f.0
       bus info: scsi@0:0.15.0
       logical name: /dev/sdo
       version: 06B3
       serial: PNY41200259350303941
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=084f7736-02a7-ce4d-a13c-4cd2d7c119be logicalsectorsize=512 sectorsize=512
  *-disk:7
       description: ATA Disk
       product: INTEL SSDSC2BB24
       physical id: 0.10.0
       bus info: scsi@0:0.16.0
       logical name: /dev/sdp
       version: 0370
       serial: PHWL441500GL240NGN
       size: 223GiB (240GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=e6505156-0fca-4d64-b5ed-7123e871afbb logicalsectorsize=512 sectorsize=4096
  *-disk:8
       description: ATA Disk
       product: PNY CS900 480GB
       physical id: 0.11.0
       bus info: scsi@0:0.17.0
       logical name: /dev/sdq
       version: 06B3
       serial: PNY412002593503037C2
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=dd71eb47-241d-9c4d-baed-a0961236afdd logicalsectorsize=512 sectorsize=512
  *-disk:9
       description: ATA Disk
       product: PNY CS900 480GB
       physical id: 0.12.0
       bus info: scsi@0:0.18.0
       logical name: /dev/sdr
       version: 06B3
       serial: PNY41200259350303937
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=3d2c8a0d-99e2-494a-8eca-2449cf0fdd22 logicalsectorsize=512 sectorsize=512
  *-disk:10
       description: ATA Disk
       product: PNY CS900 480GB
       physical id: 0.13.0
       bus info: scsi@0:0.19.0
       logical name: /dev/sds
       version: 06B3
       serial: PNY41200259350303946
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=06f5d1f5-ce87-3a46-85d6-472b0c7dda89 logicalsectorsize=512 sectorsize=512
  *-disk:11
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.2.0
       bus info: scsi@0:0.2.0
       logical name: /dev/sdb
       version: A21D
       serial: 1DGDWBUZ
       size: 9314GiB (10TB)
       capacity: 10TiB (11TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=cee10a41-f904-e94a-ac7b-38da091e2a3b logicalsectorsize=512 sectorsize=4096
  *-disk:12
       description: ATA Disk
       product: SDLF1DAR480G-1HH
       physical id: 0.14.0
       bus info: scsi@0:0.20.0
       logical name: /dev/sdt
       version: RP41
       serial: A032AA63
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=1cb7fee4-f5fb-4c49-a08a-f7c756a742d0 logicalsectorsize=512 sectorsize=4096
  *-disk:13
       description: ATA Disk
       product: SDLF1DAR480G-1HH
       physical id: 0.15.0
       bus info: scsi@0:0.21.0
       logical name: /dev/sdu
       version: RP41
       serial: A015EA99
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=e8342eab-a236-db45-b233-4860c0665700 logicalsectorsize=512 sectorsize=4096
  *-disk:14
       description: ATA Disk
       product: SDLF1DAR480G-1HH
       physical id: 0.16.0
       bus info: scsi@0:0.22.0
       logical name: /dev/sdv
       version: RP41
       serial: A018F015
       size: 447GiB (480GB)
       capabilities: gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=b591f9d0-fef6-514a-895f-8e821dd23c68 logicalsectorsize=512 sectorsize=4096
  *-disk:15
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.17.0
       bus info: scsi@0:0.23.0
       logical name: /dev/sdw
       version: A21D
       serial: 1DGD57TZ
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=afce944b-a8fd-5544-b415-3cda2c491a7e logicalsectorsize=512 sectorsize=4096
  *-disk:16
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.18.0
       bus info: scsi@0:0.24.0
       logical name: /dev/sdx
       version: A21D
       serial: 7JH1AKPG
       size: 9314GiB (10TB)
       capacity: 11TiB (13TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=cd438e2b-ac31-0c4b-8551-869f7f428ba7 logicalsectorsize=512 sectorsize=4096
  *-disk:17
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.19.0
       bus info: scsi@0:0.25.0
       logical name: /dev/sdy
       version: A21D
       serial: 1DGGA6NZ
       size: 9314GiB (10TB)
       capacity: 12TiB (13TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=bd53f573-8300-9947-a449-c89abe2a1974 logicalsectorsize=512 sectorsize=4096
  *-disk:18
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.1a.0
       bus info: scsi@0:0.26.0
       logical name: /dev/sdz
       version: A21D
       serial: 1DGE8USZ
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=a3c3a8e6-0812-1746-8325-49fc554152b9 logicalsectorsize=512 sectorsize=4096
  *-disk:19
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.1b.0
       bus info: scsi@0:0.27.0
       logical name: /dev/sdaa
       version: A21D
       serial: 1DGEKGHZ
       size: 9314GiB (10TB)
       capacity: 13TiB (14TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=6697c6ba-864c-2043-b01a-ad6d9f39d5a3 logicalsectorsize=512 sectorsize=4096
  *-disk:20
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.1c.0
       bus info: scsi@0:0.28.0
       logical name: /dev/sdab
       version: A21D
       serial: 7JK08A6C
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=ab7fd6e0-9daa-f441-a4a3-5dad5b38b7d0 logicalsectorsize=512 sectorsize=4096
  *-disk:21
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.3.0
       bus info: scsi@0:0.3.0
       logical name: /dev/sdc
       version: A21D
       serial: 1DGG747Z
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=0df58c09-c2dc-cb47-b0b5-0f7551ca2c98 logicalsectorsize=512 sectorsize=4096
  *-disk:22
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.4.0
       bus info: scsi@0:0.4.0
       logical name: /dev/sdd
       version: A21D
       serial: 1DGD333Z
       size: 9314GiB (10TB)
       capacity: 10TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=b8eaaaa1-823c-0b42-a9ca-6aa25c7caceb logicalsectorsize=512 sectorsize=4096
  *-disk:23
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.5.0
       bus info: scsi@0:0.5.0
       logical name: /dev/sde
       version: A21D
       serial: 1DGD331Z
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=a3b29ad1-2635-9b4c-bb3d-584f4ded9ec9 logicalsectorsize=512 sectorsize=4096
  *-disk:24
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.6.0
       bus info: scsi@0:0.6.0
       logical name: /dev/sdf
       version: A21D
       serial: 1DGG7XWZ
       size: 9314GiB (10TB)
       capacity: 12TiB (13TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=e9ead8e1-e745-e542-9d74-119c0eabeef3 logicalsectorsize=512 sectorsize=4096
  *-disk:25
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.7.0
       bus info: scsi@0:0.7.0
       logical name: /dev/sdg
       version: A21D
       serial: 7JH2DW6G
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=40451b3c-6a3b-c944-8659-6829b887a080 logicalsectorsize=512 sectorsize=4096
  *-disk:26
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.8.0
       bus info: scsi@0:0.8.0
       logical name: /dev/sdh
       version: A21D
       serial: 1DGE92DZ
       size: 9314GiB (10TB)
       capacity: 11TiB (12TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=45ec6389-34ff-0b40-9af7-8afe0552a314 logicalsectorsize=512 sectorsize=4096
  *-disk:27
       description: SCSI Disk
       product: HUH721010AL4200
       vendor: HGST
       physical id: 0.9.0
       bus info: scsi@0:0.9.0
       logical name: /dev/sdi
       version: A21D
       serial: 1DGG62YZ
       size: 9314GiB (10TB)
       capacity: 11TiB (13TB)
       capabilities: 7200rpm gpt-1.00 partitioned partitioned:gpt
       configuration: ansiversion=6 guid=d9853c8a-2cae-7f43-8029-645ee3d93af8 logicalsectorsize=512 sectorsize=4096
total 0
drwxr-xr-x 2 root root 3400 Dec  3 21:45 ./
drwxr-xr-x 8 root root  160 Dec  3 21:45 ../
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca2663ace38 -> ../../sdx
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663ace38-part1 -> ../../sdx1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663ace38-part9 -> ../../sdx9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca2663cc258 -> ../../sdg
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663cc258-part1 -> ../../sdg1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663cc258-part9 -> ../../sdg9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca2663df500 -> ../../sdj
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663df500-part1 -> ../../sdj1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca2663df500-part9 -> ../../sdj9
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca266a9971c -> ../../sdab
lrwxrwxrwx 1 root root   11 Dec  3 21:45 scsi-35000cca266a9971c-part1 -> ../../sdab1
lrwxrwxrwx 1 root root   11 Dec  3 21:45 scsi-35000cca266a9971c-part9 -> ../../sdab9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c160054 -> ../../sde
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c160054-part1 -> ../../sde1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c160054-part9 -> ../../sde9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c16005c -> ../../sdd
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c16005c-part1 -> ../../sdd1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c16005c-part9 -> ../../sdd9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c1620a8 -> ../../sdw
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1620a8-part1 -> ../../sdw1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1620a8-part9 -> ../../sdw9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c176cf4 -> ../../sdb
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c176cf4-part1 -> ../../sdb1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c176cf4-part9 -> ../../sdb9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c1827e4 -> ../../sdz
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1827e4-part1 -> ../../sdz1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1827e4-part9 -> ../../sdz9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c182b98 -> ../../sdh
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c182b98-part1 -> ../../sdh1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c182b98-part9 -> ../../sdh9
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c18a994 -> ../../sdaa
lrwxrwxrwx 1 root root   11 Dec  3 21:45 scsi-35000cca26c18a994-part1 -> ../../sdaa1
lrwxrwxrwx 1 root root   11 Dec  3 21:45 scsi-35000cca26c18a994-part9 -> ../../sdaa9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c18f0a0 -> ../../sdl
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c18f0a0-part1 -> ../../sdl1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c18f0a0-part9 -> ../../sdl9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c19d04c -> ../../sdi
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19d04c-part1 -> ../../sdi1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19d04c-part9 -> ../../sdi9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c19dff0 -> ../../sdc
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19dff0-part1 -> ../../sdc1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19dff0-part9 -> ../../sdc9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c19ebe0 -> ../../sdf
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19ebe0-part1 -> ../../sdf1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19ebe0-part9 -> ../../sdf9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c19fcfc -> ../../sdk
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19fcfc-part1 -> ../../sdk1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c19fcfc-part9 -> ../../sdk9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c1a0e28 -> ../../sdy
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1a0e28-part1 -> ../../sdy1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1a0e28-part9 -> ../../sdy9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35000cca26c1a2480 -> ../../sda
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1a2480-part1 -> ../../sda1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35000cca26c1a2480-part9 -> ../../sda9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-3500143804074fa4c -> ../../sdm
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4c-part1 -> ../../sdm1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4c-part9 -> ../../sdm9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-3500143804074fa4d -> ../../sdn
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4d-part1 -> ../../sdn1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4d-part9 -> ../../sdn9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-3500143804074fa4e -> ../../sdo
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4e-part1 -> ../../sdo1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4e-part9 -> ../../sdo9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-3500143804074fa4f -> ../../sdp
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4f-part1 -> ../../sdp1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-3500143804074fa4f-part2 -> ../../sdp2
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc0 -> ../../sdq
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc0-part1 -> ../../sdq1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc0-part9 -> ../../sdq9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc1 -> ../../sdr
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc1-part1 -> ../../sdr1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc1-part9 -> ../../sdr9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc2 -> ../../sds
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc2-part1 -> ../../sds1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc2-part9 -> ../../sds9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc3 -> ../../sdt
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc3-part1 -> ../../sdt1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc3-part9 -> ../../sdt9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc4 -> ../../sdu
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc4-part1 -> ../../sdu1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc4-part9 -> ../../sdu9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 scsi-35001438040750cc5 -> ../../sdv
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc5-part1 -> ../../sdv1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 scsi-35001438040750cc5-part9 -> ../../sdv9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca2663ace38 -> ../../sdx
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663ace38-part1 -> ../../sdx1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663ace38-part9 -> ../../sdx9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca2663cc258 -> ../../sdg
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663cc258-part1 -> ../../sdg1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663cc258-part9 -> ../../sdg9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca2663df500 -> ../../sdj
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663df500-part1 -> ../../sdj1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca2663df500-part9 -> ../../sdj9
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca266a9971c -> ../../sdab
lrwxrwxrwx 1 root root   11 Dec  3 21:45 wwn-0x5000cca266a9971c-part1 -> ../../sdab1
lrwxrwxrwx 1 root root   11 Dec  3 21:45 wwn-0x5000cca266a9971c-part9 -> ../../sdab9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c160054 -> ../../sde
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c160054-part1 -> ../../sde1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c160054-part9 -> ../../sde9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c16005c -> ../../sdd
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c16005c-part1 -> ../../sdd1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c16005c-part9 -> ../../sdd9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c1620a8 -> ../../sdw
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1620a8-part1 -> ../../sdw1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1620a8-part9 -> ../../sdw9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c176cf4 -> ../../sdb
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c176cf4-part1 -> ../../sdb1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c176cf4-part9 -> ../../sdb9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c1827e4 -> ../../sdz
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1827e4-part1 -> ../../sdz1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1827e4-part9 -> ../../sdz9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c182b98 -> ../../sdh
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c182b98-part1 -> ../../sdh1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c182b98-part9 -> ../../sdh9
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c18a994 -> ../../sdaa
lrwxrwxrwx 1 root root   11 Dec  3 21:45 wwn-0x5000cca26c18a994-part1 -> ../../sdaa1
lrwxrwxrwx 1 root root   11 Dec  3 21:45 wwn-0x5000cca26c18a994-part9 -> ../../sdaa9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c18f0a0 -> ../../sdl
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c18f0a0-part1 -> ../../sdl1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c18f0a0-part9 -> ../../sdl9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c19d04c -> ../../sdi
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19d04c-part1 -> ../../sdi1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19d04c-part9 -> ../../sdi9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c19dff0 -> ../../sdc
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19dff0-part1 -> ../../sdc1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19dff0-part9 -> ../../sdc9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c19ebe0 -> ../../sdf
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19ebe0-part1 -> ../../sdf1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19ebe0-part9 -> ../../sdf9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c19fcfc -> ../../sdk
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19fcfc-part1 -> ../../sdk1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c19fcfc-part9 -> ../../sdk9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c1a0e28 -> ../../sdy
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1a0e28-part1 -> ../../sdy1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1a0e28-part9 -> ../../sdy9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5000cca26c1a2480 -> ../../sda
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1a2480-part1 -> ../../sda1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5000cca26c1a2480-part9 -> ../../sda9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x500143804074fa4c -> ../../sdm
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4c-part1 -> ../../sdm1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4c-part9 -> ../../sdm9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x500143804074fa4d -> ../../sdn
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4d-part1 -> ../../sdn1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4d-part9 -> ../../sdn9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x500143804074fa4e -> ../../sdo
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4e-part1 -> ../../sdo1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4e-part9 -> ../../sdo9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x500143804074fa4f -> ../../sdp
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4f-part1 -> ../../sdp1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x500143804074fa4f-part2 -> ../../sdp2
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc0 -> ../../sdq
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc0-part1 -> ../../sdq1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc0-part9 -> ../../sdq9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc1 -> ../../sdr
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc1-part1 -> ../../sdr1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc1-part9 -> ../../sdr9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc2 -> ../../sds
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc2-part1 -> ../../sds1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc2-part9 -> ../../sds9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc3 -> ../../sdt
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc3-part1 -> ../../sdt1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc3-part9 -> ../../sdt9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc4 -> ../../sdu
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc4-part1 -> ../../sdu1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc4-part9 -> ../../sdu9
lrwxrwxrwx 1 root root    9 Dec  3 21:45 wwn-0x5001438040750cc5 -> ../../sdv
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc5-part1 -> ../../sdv1
lrwxrwxrwx 1 root root   10 Dec  3 21:45 wwn-0x5001438040750cc5-part9 -> ../../sdv9



