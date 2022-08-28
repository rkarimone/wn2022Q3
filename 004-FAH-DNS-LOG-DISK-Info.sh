


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

