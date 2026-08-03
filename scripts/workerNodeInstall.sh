#!/bin/bash


rke_token=$(cat /vagrant/rke2_token)


curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -

systemctl enable rke2-agent.service

mkdir -p /etc/rancher/rke2/

cat <<EOF > /etc/rancher/rke2/config.yaml
server: https://192.168.41.101:9345
token: ${rke_token} 
EOF

systemctl start rke2-agent.service

echo "nameserver 192.168.41.102" >> /etc/resolv.conf
