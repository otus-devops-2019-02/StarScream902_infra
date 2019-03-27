#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod.service
sudo systemctl enable mongod.service
sudo systemctl status mongod.service

exit 0
