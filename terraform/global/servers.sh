#!/bin/bash
hostnamectl set-hostname buzser
yum install epel-release -y
yum install nginx -y

sed -i 's/80/8080/' /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx
