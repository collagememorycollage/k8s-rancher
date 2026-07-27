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

	#Download package for Virtual Box
	apt install -y libvulkan1 libgl1i \
	       	liblzf1 libpng16-16t64 libqt6core6t64 \
	       	libqt6dbus6 libqt6gui6 libqt6help6 \
	       	libqt6printsupport6 libqt6statemachine6 \
	       	libqt6widgets6 libqt6xml6 libtpms0 libvpx9 libxt6t64

		
	#Download and install virtualbox
	wget https://download.virtualbox.org/virtualbox/7.2.14/virtualbox-7.2_7.2.14-174565~Ubuntu~plucky_amd64.deb
	dpkg -i virtualbox*
	sudo mkdir -p /etc/vbox && echo "* 0.0.0.0/0" | sudo tee -a /etc/vbox/networks.conf
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
