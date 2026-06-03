#!/bin/bash

apt update
apt install -y curl wget apt-transport-https docker.io

systemctl enable --now docker
usermod -aG docker ubuntu


curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

install minikube-linux-amd64 /usr/local/bin/minikube

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x kubectl

mv kubectl /usr/local/bin/


cat <<EOF > /etc/systemd/system/minikube.service
[Unit]
Description=Minikube Cluster
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/your_username
User=your_username
Group=docker
Environment=HOME=/home/your_username
ExecStart=/usr/local/bin/minikube start --driver=docker --cpus=2 --memory=4096
ExecStop=/usr/local/bin/minikube stop

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now minikube.service

sleep 60

kubectl create namespace icanio
