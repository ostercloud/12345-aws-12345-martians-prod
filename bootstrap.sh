#!/bin/bash
sleep 120;
apt-get update -y; 
apt-get install -y docker.io; 
ufw disable;
docker run -dit --name my-apache-app -p 80:80 httpd
