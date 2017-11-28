sleep 120;
apt-get update; 
apt-get install -y docker; 
docker run -dit --name my-apache-app -p 80:80 httpd
