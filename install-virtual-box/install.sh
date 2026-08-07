#!/bin/bash
#apt update && apt upgarde -y

curl -sfL https://get.rke2.io | sh -

systemctl enable rke2-server.service

mkdir -p /etc/rancher/rke2/

touch /etc/rancher/rke2/config.yaml

echo "bind-address: 192.168.41.101
advertise-address: 192.168.41.101
node-ip: 192.168.41.101
tls-san:
  - 192.168.41.101" > /etc/rancher/rke2/config.yaml

systemctl start rke2-server.service

sleep 10 

cp /var/lib/rancher/rke2/bin/kubectl /usr/bin

mkdir -p /home/vagrant/.kube

ln -s /etc/rancher/rke2/rke2.yaml /home/vagrant/.kube/config

chown vagrant:vagrant -R /etc/rancher/rke2
chown vagrant:vagrant /home/vagrant/.kube/config

systemctl restart rke2-server.service

echo "nameserver 192.168.41.102" >> /etc/resolv.conf

while [ ! -f /var/lib/rancher/rke2/server/node-token ]; do
  sleep 2
done

# Ждем, пока файл токена физически появится
while [ ! -f /var/lib/rancher/rke2/server/node-token ]; do
  sleep 2
done

cp /var/lib/rancher/rke2/server/node-token /vagrant/rke2_token
chmod 644 /vagrant/rke2_token


