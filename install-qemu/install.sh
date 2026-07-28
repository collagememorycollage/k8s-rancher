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
	
	apt update && sudo apt install -y ruby-dev build-essential libvirt-dev
    apt install ruby-rubygems -y
	gem install vagrant-libvirt
	
	agrant plugin install ./vagrant-libvirt-0.12.2.gem --plugin-clean-sources --plugin-source https://rubygems.org
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
