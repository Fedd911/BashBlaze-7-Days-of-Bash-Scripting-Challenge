#!/bin/bash

function installDocker {

echo "AYO INSTALLING DOCKER..."

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

}

function buildAndDeploy {

echo "BUILDING THE IMAGE...."

docker build -t static-server-image:v2 .

echo "RUNNING THE DOCKER CONTAINER...."

docker run -d -p 8080:80 static-server-image:v2

}

installDocker
buildAndDeploy
