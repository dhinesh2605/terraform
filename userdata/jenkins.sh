#!/bin/bash

apt update
apt install -y curl wget apt-transport-https docker.io git

systemctl enable --now docker
usermod -aG docker ubuntu


mkdir /opt/jenkins
cd /opt/jenkins

cat > /opt/jenkins/Dockerfile <<EOF
FROM jenkins/jenkins:lts

# Enable root user to install plugins and other dependencies.
USER root

# Update packages and clean up cache to keep the image slim
RUN apt-get update && \
    apt-get install -y docker.io curl git python3 python3-pip 

# Install Jenkin plugins
RUN jenkins-plugin-cli --plugins role-strategy

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.71.0

# Switch back to the Jenkins user
USER jenkins
EOF

cd /opt/jenkins

docker build -t jenkins:v1 .

docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --restart=unless-stopped -v jenkins-home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins:v1


chmod 666 /var/run/docker.sock