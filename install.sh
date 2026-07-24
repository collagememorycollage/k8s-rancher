#!/bin/bash

set -e 

if [ -f .env ]; then
	export $(cat .env | xargs)
else
	echo ".env file not found, you need to create .env file"
	exit 1
fi

export VAGRANT_HTTP_PROXY=${https_proxy}
export VAGRANT_NO_PROXY="127.0.0.1"

country_code=$(curl -s https://ipwho.is | grep "country_code" | cut -d'"' -f4)

if [ $(id -u) == "0" ] && [ $country_code != "RU" ]; then	
	#Update system
	apt update -y && apt upgrade -y
	
	#Download and install virtualbox
	wget https://download.virtualbox.org/virtualbox/7.2.14/virtualbox-7.2_7.2.14-174565~Ubuntu~plucky_amd64.deb
	dpkg -i virtualbox*
	rm virtualbox*

	#Download and install vagrant
	wget https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_linux_amd64.zip
	unzip vagrant*
	mv ./vagrant /usr/bin
	rm  LICENSE.txt 
else
	echo "You need login root or set up proxy server"
	exit 1
fi
