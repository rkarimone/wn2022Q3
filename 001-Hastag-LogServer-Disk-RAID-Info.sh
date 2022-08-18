# Previous Records

root@logserver:~# zpool status
  pool: volume1
 state: ONLINE
  scan: resilvered 73.7G in 01:22:14 with 0 errors on Tue Mar 15 21:32:44 2022
config:

	NAME                                        STATE     READ WRITE CKSUM
	volume1                                     ONLINE       0     0     0
	  raidz3-0                                  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16d5c0d673cf4  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16d9410bcd155  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16db512b734c1  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16dc913f23591  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16df41680d5da  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e061795cd46  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c3399f06e53e56  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c339b40823f96d  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e3b1ab9a467  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e541c3adcff  ONLINE       0     0     0

errors: No known data errors


######## Disk Failed and Disk Replace Procedure


apt-get install lsscsi hdparm smartmontools lshw inxi


smartctl -d megaraid,0 -a /dev/sda |grep Serial
smartctl -d megaraid,1 -a /dev/sda |grep Serial
smartctl -d megaraid,2 -a /dev/sda |grep Serial
smartctl -d megaraid,3 -a /dev/sda |grep Serial
smartctl -d megaraid,4 -a /dev/sda |grep Serial
smartctl -d megaraid,5 -a /dev/sda |grep Serial
smartctl -d megaraid,6 -a /dev/sda |grep Serial
smartctl -d megaraid,7 -a /dev/sda |grep Serial
smartctl -d megaraid,8 -a /dev/sda |grep Serial
smartctl -d megaraid,9 -a /dev/sda |grep Serial




root@logserver:/dev/disk/by-id# lsscsi -s
[0:2:0:0]    disk    DELL     PERC H710        3.13  /dev/sda   4.00TB [Serial number:        Z1Z6AX1V]
[0:2:1:0]    disk    DELL     PERC H710        3.13  /dev/sdb   4.00TB [Serial number:        Z1Z6AX91]
[0:2:2:0]    disk    DELL     PERC H710        3.13  /dev/sdc   4.00TB [Serial number:        Z1Z6D9V7]
[0:2:3:0]    disk    DELL     PERC H710        3.13  /dev/sdd   4.00TB [Serial number:        Z1Z6BWMA]
[0:2:4:0]    disk    DELL     PERC H710        3.13  /dev/sde   4.00TB [Serial number:        Z1Z51GZ4]
[0:2:5:0]    disk    DELL     PERC H710        3.13  /dev/sdf   4.00TB [Serial number:        Z1Z6AWWB]
[0:2:6:0]    disk    DELL     PERC H710        3.13  /dev/sdg   4.00TB [Serial number:        X670A077FVNC]
[0:2:7:0]    disk    DELL     PERC H710        3.13  /dev/sdh   4.00TB [Serial number:        6630A013FVNC]
[0:2:8:0]    disk    DELL     PERC H710        3.13  /dev/sdi   4.00TB [Serial number:        86A0A0SCFVNC]
[0:2:9:0]    disk    DELL     PERC H710        3.13  /dev/sdj   4.00TB [Serial number:        Z1Z5WTA1]


[0:2:10:0]   disk    DELL     PERC H710        3.13  /dev/sdk    119GB [Serial Number:    LCD120R007782]	




root@logserver:~# zpool status
  pool: volume1
 state: DEGRADED
status: One or more devices could not be used because the label is missing or
	invalid.  Sufficient replicas exist for the pool to continue
	functioning in a degraded state.
action: Replace the device using 'zpool replace'.
   see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-4J
  scan: scrub repaired 0B in 02:11:24 with 0 errors on Sun Jun 12 02:35:26 2022
config:

	NAME                                        STATE     READ WRITE CKSUM
	volume1                                     DEGRADED     0     0     0
	  raidz3-0                                  DEGRADED     0     0     0
	    scsi-36c81f660d1b45f0028e16d5c0d673cf4  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16d9410bcd155  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16db512b734c1  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16dc913f23591  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16df41680d5da  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e061795cd46  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c3399f06e53e56  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c339b40823f96d  ONLINE       0     0     0
	    6831077187809035419                     UNAVAIL      0     0     0  was /dev/disk/by-id/scsi-36c81f660d1b45f0028e16e3b1ab9a467-part1
	    scsi-36c81f660d1b45f0028e16e541c3adcff  ONLINE       0     0     0

errors: No known data errors


|||||||||| Initialize New Disk  

sudo sgdisk --zap-all /dev/sdi



zpool replace volume1 6831077187809035419 scsi-36c81f660d1b45f002a8f9099236098f2
watch zpool status
zpool clear volume1
zpool status





root@logserver:~# zpool status
  pool: volume1
 state: ONLINE
  scan: resilvered 218G in 03:46:43 with 0 errors on Thu Aug 18 13:44:29 2022
config:

	NAME                                        STATE     READ WRITE CKSUM
	volume1                                     ONLINE       0     0     0
	  raidz3-0                                  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16d5c0d673cf4  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16d9410bcd155  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16db512b734c1  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16dc913f23591  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16df41680d5da  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e061795cd46  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c3399f06e53e56  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0029c339b40823f96d  ONLINE       0     0     0
	    scsi-36c81f660d1b45f002a8f9099236098f2  ONLINE       0     0     0
	    scsi-36c81f660d1b45f0028e16e541c3adcff  ONLINE       0     0     0

errors: No known data errors





