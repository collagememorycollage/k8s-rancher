#!/bin/bash
apt update && apt upgarde -y

echo "nameserver 192.168.41.102" > /etc/resolv.conf

curl -sfL https://get.rke2.io | sh -

systemctl enable rke2-server.service

systemctl start rke2-server.service

cp /var/lib/rancher/rke2/bin /usr/bin

mkdir -p ~/.kube

ln -s /etc/rancher/rke2/rke2.yaml ~/.kube/config

systemctl restart rke2-server.service
