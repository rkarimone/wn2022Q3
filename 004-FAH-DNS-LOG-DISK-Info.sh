


https://askubuntu.com/questions/1379320/problem-installing-hp-proliant-utilities-on-ubuntu-server-20





   83  sudo echo "deb http://downloads.linux.hpe.com/SDR/repo/mcp bionic/current non-free" > /etc/apt/sources.list.d/mcp.list
   85  vim /etc/apt/sources.list.d/mcp.list   // change bionic -to- focal
   93  sudo curl http://downloads.linux.hpe.com/SDR/hpPublicKey1024.pub | sudo apt-key add -
   94  sudo curl http://downloads.linux.hpe.com/SDR/hpPublicKey2048.pub | sudo apt-key add -
   95  sudo curl http://downloads.linux.hpe.com/SDR/hpPublicKey2048_key1.pub | sudo apt-key add -
   96  sudo curl http://downloads.linux.hpe.com/SDR/hpePublicKey2048_key1.pub | sudo apt-key add -
   89  apt update
  100  sudo apt install hponcfg amsd ams ssacli ssaducli ssa

wget -c http://downloads.linux.hpe.com/SDR/repo/mcp/pool/non-free/hp-health_10.80-1874.10_amd64.deb
apt install gdebi-core
gdebi hp-health_10.80-1874.10_amd64.deb


https://gist.github.com/mrpeardotnet/a9ce41da99936c0175600f484fa20d03

  119  ssacli ctrl slot=0 pd all show
  120  ssacli ctrl slot=0 pd all show detail
  121  ssacli ctrl slot=0 pd all show detail |grep Serial





Smart Array P410i in Slot 0 (Embedded)

   Array A

      physicaldrive 2I:1:5
         Port: 2I
         Box: 1
         Bay: 5
         Status: OK
         Drive Type: Data Drive
         Interface Type: Solid State SATA
         Size: 240 GB
         Drive exposed to OS: False
         Logical/Physical Block Size: 512/512
         Firmware Revision: HPG2
         Serial Number: S44HNA0M809074
         WWID: 30123456789ABCD4
         Model: ATA     VK000240GWSRQ
         SATA NCQ Capable: True
         SATA NCQ Enabled: True
         SSD Smart Trip Wearout: Not Supported
         PHY Count: 1
         PHY Transfer Rate: 3.0Gbps
         PHY Physical Link Rate: Unknown
         PHY Maximum Link Rate: Unknown
         Sanitize Erase Supported: False
         Shingled Magnetic Recording Support: None


   Array B

      physicaldrive 2I:1:6
         Port: 2I
         Box: 1
         Bay: 6
         Status: OK
         Drive Type: Data Drive
         Interface Type: Solid State SATA
         Size: 240 GB
         Drive exposed to OS: False
         Logical/Physical Block Size: 512/512
         Firmware Revision: HPG2
         Serial Number: S44HNA0M808637
         WWID: 30123456789ABCD5
         Model: ATA     VK000240GWSRQ
         SATA NCQ Capable: True
         SATA NCQ Enabled: True
         SSD Smart Trip Wearout: Not Supported
         PHY Count: 1
         PHY Transfer Rate: 3.0Gbps
         PHY Physical Link Rate: Unknown
         PHY Maximum Link Rate: Unknown
         Sanitize Erase Supported: False
         Shingled Magnetic Recording Support: None


root@cyclone-dns1:~# ssacli ctrl slot=0 pd all show detail |grep Serial
         Serial Number: S44HNA0M809074
         Serial Number: S44HNA0M808637



# ll /dev/disk/by-id/ |grep scsi
lrwxrwxrwx 1 root root   9 Aug 28 16:38 scsi-0HP_LOGICAL_VOLUME_00000000 -> ../../sda
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-0HP_LOGICAL_VOLUME_00000000-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-0HP_LOGICAL_VOLUME_00000000-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-0HP_LOGICAL_VOLUME_00000000-part3 -> ../../sda3
lrwxrwxrwx 1 root root   9 Aug 28 16:30 scsi-0HP_LOGICAL_VOLUME_01000000 -> ../../sdb
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-0HP_LOGICAL_VOLUME_01000000-part1 -> ../../sdb1
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-0HP_LOGICAL_VOLUME_01000000-part2 -> ../../sdb2
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-0HP_LOGICAL_VOLUME_01000000-part3 -> ../../sdb3
lrwxrwxrwx 1 root root   9 Aug 28 16:38 scsi-3600508b1001037383941424344451a00 -> ../../sda
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-3600508b1001037383941424344451a00-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-3600508b1001037383941424344451a00-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-3600508b1001037383941424344451a00-part3 -> ../../sda3
lrwxrwxrwx 1 root root   9 Aug 28 16:30 scsi-3600508b1001037383941424344451b00 -> ../../sdb
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-3600508b1001037383941424344451b00-part1 -> ../../sdb1
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-3600508b1001037383941424344451b00-part2 -> ../../sdb2
lrwxrwxrwx 1 root root  10 Aug 28 16:30 scsi-3600508b1001037383941424344451b00-part3 -> ../../sdb3
lrwxrwxrwx 1 root root   9 Aug 28 16:38 scsi-SHP_LOGICAL_VOLUME_50123456789ABCDE -> ../../sda
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-SHP_LOGICAL_VOLUME_50123456789ABCDE-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-SHP_LOGICAL_VOLUME_50123456789ABCDE-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 Aug 28 16:38 scsi-SHP_LOGICAL_VOLUME_50123456789ABCDE-part3 -> ../../sda3









scsi-3600508b1001037383941424344451a00-part3
scsi-3600508b1001037383941424344451b00-part3


sudo zpool create -o ashift=12 -f zdata mirror \
scsi-3600508b1001037383941424344451a00-part3 \
scsi-3600508b1001037383941424344451b00-part3


zpool list
zpool status
zfs list

sudo zfs set sync=disabled zdata
sudo zfs set compress=lz4 zdata
sudo zfs set atime=off zdata
sudo zfs set xattr=sa zdata
sudo zfs set relatime=off zdata
sudo zfs set acltype=posixacl zdata
zpool set autoexpand=on zdata



sudo zfs create zdata/iso
sudo zfs create zdata/lxc
sudo zfs create zdata/vms


// Set ZFS RAM Cache...
## 1073741824 = 1GB
echo "options zfs zfs_arc_max=2147483648" > /etc/modprobe.d/zfs.conf


echo 2147483648 >> /sys/module/zfs/parameters/zfs_arc_max


sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic
sudo apt-mark hold libzfs4linux zfs-zed zfsutils-linux 



rm -fr /etc/update-motd.d/*



sudo apt autoremove -y --purge lxd lxd-client
sudo apt install lxc lxc-templates openvswitch-switch



sudo vim /usr/bin/lxc-list
#!/bin/bash
lxc-ls --fancy

// "Save+Exit"

sudo chmod +x /usr/bin/lxc-list
sudo lxc-list

sudo lxc-create -t download -n ubuntu2004d -- -a amd64 -d ubuntu -r focal
sudo lxc-create -n rocky8 -t download -- -a amd64 -d rockylinux -r 8
sudo lxc-create -n centos8 -t download -- -a amd64 -d centos -r 8
sudo lxc-create -n centos7 -t download -- -a amd64 -d centos -r 7


cd /var/lib/lxc
vim ubuntu2004/config

# Network configuration // Interface1
lxc.net.0.type = macvlan
lxc.net.0.macvlan.mode = bridge
lxc.net.0.flags = up
lxc.net.0.link = enp3s0f0
lxc.net.0.name = eth0
#lxc.net.0.hwaddr = 00:16:3e:40:9e:4d
#

# Network configuration // Interface1
#lxc.net.1.type = macvlan
#lxc.net.1.macvlan.mode = bridge
#lxc.net.1.flags = up
#lxc.net.1.link = enp3s0f1
#lxc.net.1.name = eth1
#lxc.net.1.hwaddr = 00:16:3e:40:9e:4d
#



lxc-start -n ubuntu2004
lxc-attach -n ubuntu2004

userdel -r ubuntu   // do it fist before enabling ssh ... 
passwd root  // set root password



sudo vim /usr/bin/lxc-zfs-copy

#!/bin/bash
echo -e "\nStarting the cloning process... it may take 1-4 minutes please wait... ";
lxc-copy -n $1 -N $2

echo -e "\nConverting the container to zfs container... ";
zfs create zdata/lxc/$2

sleep 3
rsync -av /var/lib/lxc/$2/ /zdata/lxc/$2
rm -fr /var/lib/lxc/$2

ln -sf /zdata/lxc/$2 /var/lib/lxc/

echo "$2" > /var/lib/lxc/$2/rootfs/etc/hostname
lxc-ls --fancy

sleep 2
echo -e "\nALL DONE... ";


chmod +x /usr/bin/lxc-zfs-copy

lxc-list

lxc-zfs-copy $source-container $new-container


lxc.start.auto = 1   // inside config file







##### Install ReverseProxy with Docker




apt-get remove docker docker.io containerd runc
apt-get install  apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo docker version
sudo docker run docker/whalesay cowsay Hello-World!

#https://github.com/docker/compose/releases
sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo docker-compose --version



sudo zfs create zdata/dockerstore

mkdir /zdata/dockerstore/wproxy
mkdir /zdata/dockerstore/wproxy/data
mkdir /zdata/dockerstore/wproxy/letsencrypt
mkdir /zdata/dockerstore/wproxy/data/mysql

cd /zdata/dockerstore/wproxy
sudo vim  docker-compose.yaml 

version: '3'
services:
  wproxyapp:
    image: 'jc21/nginx-proxy-manager:latest'
    container_name: wproxyapp
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_MYSQL_HOST: "wproxydb"
      DB_MYSQL_PORT: 3306
      DB_MYSQL_USER: "umysqldb"
      DB_MYSQL_PASSWORD: "PwJonnoJalage"
      DB_MYSQL_NAME: "nmysqldb"
    volumes:
      - /zdata/dockerstore/wproxy/data:/data
      - /zdata/dockerstore/wproxy/letsencrypt:/etc/letsencrypt
    depends_on:
      - wproxydb
  wproxydb:
    image: 'jc21/mariadb-aria:latest'
    container_name: wproxydb
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: 'PwJonnoJalage'
      MYSQL_DATABASE: 'nmysqldb'
      MYSQL_USER: 'umysqldb'
      MYSQL_PASSWORD: 'PwJonnoJalage'
    volumes:
      - /zdata/dockerstore/wproxy/data/mysql:/var/lib/mysql



sudo docker-compose up -d
sudo docker-compose up --detach

sudo docker-compose start
sudo docker-compose stop


Default Administrator User
Email:    admin@example.com
Password: changeme





### Docker Management Gui

sudo docker stop portainer && sudo docker rm portainer
sudo docker pull portainer/portainer-ce:latest
sudo docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest





























