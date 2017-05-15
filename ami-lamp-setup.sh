#!/usr/bin/env bash
## Update yum
sudo yum update -y

# Install apache, php, mysql
#sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd


## Install apache
sudo yum install -y httpd24


## Install php
# Remove php if available
sudo yum remove php5*

# Install PHP 7.0
# automatically includes php70-cli php70-common php70-json php70-process php70-xml
sudo yum install -y php70

# Install additional commonly used php packages
sudo yum install -y php70-gd
sudo yum install -y php70-imap
sudo yum install -y php70-mbstring
sudo yum install -y php70-mysqlnd
sudo yum install -y php70-opcache
sudo yum install -y php70-pecl-apcu
sudo yum install -y php70-zip
sudo yum install -y php70-intl
sudo yum install -y php70-fpm
sudo yum install -y php70-pdo
sudo yum install -y php70-mcrypt

# Start server
sudo service httpd start

# Start apache on system boot
sudo chkconfig httpd on

# Verify httpd is running on system boot
chkconfig --list httpd



## Set File Permissions
# Add wwww group to instance
sudo groupadd apache

# Add user to the group
sudo usermod -a -G apache ec2-user

# Logout
#exit


## Reconnect
# Verify membersihip
groups

# Change the group ownership
sudo chown -R ec2-user:apache /var/www

# Change directory, subdirectory and file permissions
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# Create a simple php file to test
echo "<?php phpinfo(); ?>" > /var/www/html/info.php



## MySQL Installation
# Install mysql server
sudo yum install -y mysql56-server

# Statrt mysql server
sudo service mysqld start

# Secure mysql installation
sudo mysql_secure_installation

# Restart mysql
sudo service mysqld restart

# Add mysql on system boot
sudo chkconfig mysqld on



## Install phpMyAdmin
# Enable extra packages for enterprise linux (EPEL)
#sudo yum-config-manager --enable epel

# Install phpMyAdmin package
#sudo yum install -y phpMyAdmin

# Config phpMyAdmin [Use your ip address here]
#sudo sed -i -e 's/127.0.0.1/114.164.154.23/g' /etc/httpd/conf.d/phpMyAdmin.conf

# Restart all services
sudo service httpd restart
sudo service mysqld restart


## Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer