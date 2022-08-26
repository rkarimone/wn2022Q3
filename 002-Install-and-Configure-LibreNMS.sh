  
Step-(01)
  - Install Ubuntu 20.04 VM  Or Lxc Container
  - Configure Static IP Address & DNS
  - Set Hostname  and Configre /etc/hosts & /etc/hostname
reboot
  
Step-(02)
  - After reboot make sure vm/container getting the Internet properly.
  - Fix /etc/resolv.conf  (if require)
     rm -fr /etc/resolv.conf 
     echo "nameserver 8.8.8.8" >  /etc/resolv.conf 
 
Step-(03)
  - Test Internet Connection
    ping google.com
  
  - Set Ubuntu Repository Mirror to 'mirror.0x.sg' from  /etc/apt/sources.list
   
Step-(04)
    - Update packages and install some basic packages
  
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install net-tools ifupdown -y
    sudo apt install --install-recommends linux-generic-hwe-20.04       // Only for VM not require for Lxc Container - Installing of new kernel
    sudo apt install iftop htop vim iperf3 mtr mc bwm-ng snmpd openssh-server arping rsync rclone pv telnet gdebi-core build-essential
    
    - Set Timezone
    sudo dpkg-reconfigure tzdata         // Select Asia-> Dhaka

    - Set  Locale 
    sudo apt -y install locales-all 
    sudo localectl set-locale LANG=en_GB.UTF-8 LANGUAGE="en_GB:en"
    sudo export LANG=en_GB.UTF-8
    echo "export LANG=en_GB.UTF-8" >> /root/.profile
    echo "export LANG=en_GB.UTF-8" >> /root/.bashrc
    source /root/.profile
    source /root/.bashrc 
reboot



Step-(05)
    - Install nginx, php, MySQL/MariaDB

    sudo apt install software-properties-common
    sudo add-apt-repository universe
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update

    sudo apt install curl composer acl python3-pip fping git graphviz imagemagick mariadb-client mariadb-server mtr-tiny nginx-full nmap python3-memcache python3-mysqldb rrdtool snmp snmpd whois
    sudo apt install php8.1-cli php8.1-common php8.1-curl php8.1-fpm php8.1-gd php8.1-gmp php8.1-intl php8.1-mbstring php8.1-mysql php8.1-opcache php8.1-readline php8.1-snmp php8.1-xml php8.1-xmlrpc php8.1-zip 


Step-(06)  
    - Configure nginx, php, MariaDB

    vim /etc/mysql/mariadb.conf.d/50-server.cnf     // add the following two lines
    innodb_file_per_table = 1
    lower_case_table_names = 0
    
    - There are some other DB related tuning which is not covered in this Install-Guide.
    sudo systemctl restart mariadb


    - Configure MySQL root passowrd.
    sudo mysql_secure_installation      // Default root pw is blank, Set root pw and allow remote-login.
    exit;
    sudo systemctl restart mariadb
    
    sudo mysql -u root -p
        CREATE USER 'librenmsuser'@'localhost' IDENTIFIED BY 'wP_JoyBangla007';
        CREATE DATABASE librenms;
        GRANT ALL ON librenms.* TO 'librenmsuser'@'localhost' IDENTIFIED BY 'wP_JoyBangla007' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
        EXIT;


    - Configure php8 & nginx
    vim /etc/php/8.1/fpm/php.ini    
        Set/Modify-
            file_uploads = On
            allow_url_fopen = On
            short_open_tag = On
            memory_limit = 512M
            upload_max_filesize = 128M
            max_execution_time = 360
            date.timezone = Asia/Dhaka
    Save+Exit
    
    cp -r /etc/php/8.1/fpm/php.ini /etc/php/8.1/cli/php.ini
    systemctl restart php8.1-fpm
    systemctl restart nginx
    systemctl status mysql nginx --lines=0


Step-(07)
    - Install & Configure LibreNMS
  
    sudo useradd librenms -d /opt/librenms -M -r
    sudo usermod -a -G librenms www-data
    cd /opt
    git clone https://github.com/librenms/librenms.git
    chown -R librenms:librenms /opt/librenms
    chmod -R 771 /opt/librenms
    setfacl -d -m g::rwx /opt/librenms/rrd /opt/librenms/logs /opt/librenms/bootstrap/cache/ /opt/librenms/storage/
    setfacl -R -m g::rwx /opt/librenms/rrd /opt/librenms/logs /opt/librenms/bootstrap/cache/ /opt/librenms/storage/

    - Confirm Correct Version of php-configured
    rm /etc/nginx/sites-enabled/default
    vim /etc/nginx/conf.d/librenms.conf

    #################Begin--
    server {
        listen 80;
        server_name 192.168.166.195;

        access_log    /opt/librenms/logs/librenms.log;
        root        /opt/librenms/html;
        index       index.php;

        charset utf-8;
        gzip on;
        gzip_types text/css application/javascript text/javascript application/x-javascript image/svg+xml text/plain text/xsd text/xsl text/xml image/x-icon;
        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }
        location /api/v0 {
            try_files $uri $uri/ /api_v0.php?$query_string;
        }
        location ~ \.php {
            include fastcgi.conf;
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:/run/php/php8.1-fpm.sock;
        }
        location ~ /\.ht {
            deny all;
        }
     }
    #################End--
    
    vim /opt/librenms/html/info.php
        <?php phpinfo(); ?>
    Save+Exit

    sudo nginx -t       // check for error/warning
    sudo systemctl restart nginx
    
    - Browse http://server-ip-address/info.php      // fix if there is any error


    - Install Compoer
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
    cd /opt/librenms/
    sudo ./scripts/composer_wrapper.php install --no-dev
    cd ..
    chown -R librenms:librenms librenms
   
   
    systemctl restart php8.1-fpm
    systemctl restart nginx
    systemctl status mysql nginx --lines=0
      
    

    - Browse to http://server-ip-address/       -- follow instrunctions -- complete the setup
    
    
    
        cd /opt/librenms  -- set correct env
    
    sudo vim .env     // delete old text and paste new
 Save+Exit



reboot




    
