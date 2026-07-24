#!/bin/bash

set -e 

if [ $(id -u) == "0" ]; then	
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
	echo "You need login root"
fi
