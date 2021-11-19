#!/bin/bash

# fill the tables in the database with sample data

# get sample_data.sql file from GitHub repo
sudo wget --header='Authorization: token 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' https://raw.githubusercontent.com/LienHoudenaert/IAC7/main/data/sample_data.sql -O sample_data.sql

# insert data from sample_data.sql file into tables in hosting database
sudo cat sample_data.sql | sudo mysql -u root -p hosting --password=admin || :

# remove the sample_data.sql files from server
sudo rm sample_data.sql