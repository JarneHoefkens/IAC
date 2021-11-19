#!/bin/bash

# script to get the application from GitHub running on server

# clone GitHub repo, move application folder to /var/www/html/
sudo git clone https://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@github.com/LienHoudenaert/IAC7.git
sudo mv IAC7/application /var/www/html/application

# give permissions to application folder
sudo chmod -R a+rwx /var/www/html/application

# remove IAC7 folder cloned from GitHub
sudo rm -r IAC7/