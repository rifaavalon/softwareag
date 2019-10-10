#!/bin/bash
hostname set-hostname buzser.localdomain
yum install epel-release -y
yum install nginx -y

sed -i 's/80/8080/' /etc/nginx/nginx.conf

systemctl enable nginx
systemctl start nginx

sed -i 's/localhost/buzser' /etc/nginx/nginx.conf 
