#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo '<center><h1>This is Mashood instance that is successfully running the Apache Webserver!</h1></center>' | sudo tee /var/www/html/index.html > /dev/null
