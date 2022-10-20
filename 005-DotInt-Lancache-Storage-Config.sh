
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


