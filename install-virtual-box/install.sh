#!/bin/bash

ubuntu_version=$(lsb_release -cs)

set -e 

if [ -f .env ]; then
	export $(cat .env | xargs)
else
	echo ".env file not found, you need to create .env file"
	exit 1
fi

country_code=$(curl -s https://ipwho.is | grep "country_code" | cut -d'"' -f4)

if [ $(id -u) == "0" ] && [ $country_code != "RU" ]; then	
	#Update system
	apt update -y && apt upgrade -y
		
	#Download and install virtualbox
	wget https://download.virtualbox.org/virtualbox/7.2.14/virtualbox-7.2_7.2.14-174565~Ubuntu~${ubuntu_version}_amd64.deb
	apt install -y ./virtualbox* 
	sudo mkdir -p /etc/vbox && echo "* 0.0.0.0/0" | sudo tee -a /etc/vbox/networks.conf
	rm virtualbox*

	#Download and install vagrant
	apt install unzip -y 
	wget https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_linux_amd64.zip
	unzip vagrant*
	mv ./vagrant /usr/bin
	rm  LICENSE.txt 
else
	echo "You need login root or set up proxy server"
	exit 1
fi
