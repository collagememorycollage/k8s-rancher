#!/bin/bash
#apt update && apt upgarde -y

#echo "nameserver 192.168.41.102" > /etc/resolv.conf

curl -sfL https://get.rke2.io | sh -

systemctl enable rke2-server.service

systemctl start rke2-server.service

sleep 10 

cp /var/lib/rancher/rke2/bin/kubectl /usr/bin

mkdir -p /home/vagrant/.kube

ln -s /etc/rancher/rke2/rke2.yaml /home/vagrant/.kube/config

chown vagrant:vagrant -R /etc/rancher/rke2
chown vagrant:vagrant /home/vagrant/.kube/config

systemctl restart rke2-server.service
