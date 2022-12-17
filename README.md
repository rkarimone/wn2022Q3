# wn2022Q3
Work Notes From July 2022


172.16.198.7 --- home linux
172.16.168.19  --- home winvm

gsettings set org.gnome.desktop.screensaver lock-delay 604800
mysqldump -uUser -pPass -hHost --single-transaction database > backup.bak
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.screensaver lock-enabled false
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

Machine:   Type: Desktop Mobo: Gigabyte model: B560M DS3H V2 v: x.x serial: <filter> 
           UEFI: American Megatrends LLC. v: F2 date: 06/18/2021 

CPU:       Topology: 6-Core model: 11th Gen Intel Core i5-11400 bits: 64 type: MT MCP arch: N/A 
           L2 cache: 12.0 MiB 
           flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx bogomips: 62208 
           Speed: 4067 MHz min/max: 800/4400 MHz Core speeds (MHz): 1: 4067 2: 4118 3: 4034 
           4: 4086 5: 4074 6: 4105 7: 4041 8: 4098 9: 4099 10: 4116 11: 4110 12: 4147 


   dmidecode --type 17
  
  Handle 0x0044, DMI type 17, 92 bytes

  `Memory Device`
```	
	Array Handle: 0x003B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16384 MB
	Form Factor: DIMM
	Set: None
	Locator: Controller0-ChannelB-DIMM1
	Bank Locator: BANK 1
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2133 MT/s
	Manufacturer: G Skill Intl
	Serial Number: 00000000
	Asset Tag: 9876543210
	Part Number: F4-3200C16-16GVK    
	Rank: 2
	Configured Memory Speed: 2133 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 5, Hex 0xCD
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None
```

	
	rclone -v sync --modify-window 15s --skip-links --ignore-errors /home/rkarim/ P300H/SSD250/
