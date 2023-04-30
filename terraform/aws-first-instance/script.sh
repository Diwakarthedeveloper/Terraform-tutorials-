#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo echo "Hii Diwakar" >/var/www/html/index.nginx-debian.html


# this is configuration management(configuration in the infra created by terraform) 
#and terraform is not built for this , best  to use Ansible or somettimes we can use  terraform provisners  