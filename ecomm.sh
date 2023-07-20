#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y git
sudo git clone https://github.com/ravi2krishna/ecomm.git /var/www/html
