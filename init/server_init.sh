#!/bin/bash

# script to setup the server

# get files needed for server setup
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/JarneHoefkens/IAC/main/infrastructure/server_setup.sh -O server_setup.sh
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/JarneHoefkens/IAC/main/infrastructure/application.conf -O application.conf
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/JarneHoefkens/IAC/main/infrastructure/hosting.sql -O hosting.sql

# give execution permissions to server_setup.sh script
sudo chmod +x server_setup.sh

# convert windows-style line endings to unix-style
sudo sed -i -e 's/\r$//' server_setup.sh

# execute server_setup.sh script
sudo ./server_setup.sh

# remove the files downloaded before
sudo rm application.conf
sudo rm hosting.sql
sudo rm server_setup.sh