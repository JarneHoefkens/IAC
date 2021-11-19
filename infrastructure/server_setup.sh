#!/bin/bash

# script to install all necessary components on the webserver

# get nessacary files from GitHub, files are used later in the setup script
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/JarneHoefkens/IAC/main/application/config.php -O application.conf
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/JarneHoefkens/IAC/main/infrastructure/hosting.sql -O hosting.sql

# update and upgrade of the server
sudo apt-get update
sudo apt-get upgrade -y

# "noninteractive" never interacts with you and makes the default answers be used for all questions.
export DEBIAN_FRONTEND="noninteractive"

# set values for installation of mysql
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password admin"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password admin"

# install apache2 and mysql
sudo apt-get install apache2 -y
sudo apt-get install mysql-server -y

# initialize the secure installation for mysql and answer the questions
sudo mysql_secure_installation --password=admin <<EOF
n
admin
admin
y
y
y
y
y
EOF

# install nessacary php modules
sudo apt-get install php libapache2-mod-php php-mysql php-cli -y

# search for specific line in file and replace it with another (watch the tabs)
sudo sed -i 's/ DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/   DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

# restart apache2, update and upgrade the server
sudo systemctl restart apache2
sudo apt-get update
sudo apt-get upgrade -y

# install more php modules
sudo apt install php-mbstring php-zip php-gd php-json php-curl -y

# if component_validate_password is installed, uninstall it, when error is thrown, ignore it an continue the script
sudo mysql -u root --password=admin -e \ 'UNINSTALL COMPONENT "file://component_validate_password";' || :

# set values for phpmyadmin installation, this will answer the wizard automatically
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password admin"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password admin"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password admin"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

# install phpmyadmin
sudo apt-get install phpmyadmin -y

# enable php module mbstring and restart apache2
sudo phpenmod mbstring
sudo systemctl restart apache2

# set root@localhost password with caching_sha2_password (needed for phpmyadmin)
sudo mysql -u root --password=admin -e \ "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'admin';" || :

# permissions for WinSCP
sudo chmod -R a+rwx /var/www/html

# make application directory and give permissions to folder
# sudo mkdir -p /var/www/html/application
# sudo chmod -R a+rwx /var/www/html/application

# copy the (downloaded for GitHub) application.conf file and copy it to the right directory
sudo cp application.conf /etc/apache2/sites-available/application.conf

# set variable for the ip address of eth0 and add it to the application.conf file
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
sudo sed -i "s/<ip-address webserver>/$ip4/" /etc/apache2/sites-available/application.conf

# disable default apache2 config file and enable application.conf, restart apache2
sudo a2dissite 000-default.conf
sudo a2ensite application.conf
sudo systemctl restart apache2

# create database hosting if it doesn't exist already
sudo mysql -u root --password=admin -e \ "CREATE DATABASE IF NOT EXISTS hosting;" || :

# use content of (downloaded for GitHub) hosting.sql file to add tables to hosting database
sudo cat hosting.sql | sudo mysql -u root -p hosting --password=admin