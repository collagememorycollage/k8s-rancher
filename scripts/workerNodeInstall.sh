#!/bin/bash

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -

systemctl enable rke2-agent.service

mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml

echo """
server: https://192.168.41.101:9345
token: <token from server node>
""" > /etc/rancher/rke2/config.yaml 

systemctl start rke2-agent.service
