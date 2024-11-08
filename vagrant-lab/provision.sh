#!/usr/bin/env bash
echo "Installing Apache and setting setup..."
sudo apt update -y >/dev/null 2>&1
sudo apt install -y apache2 >/dev/null 2>&1
sudo cp -r /vagrant/html* /var/www/html/
sudo service apache2 start

