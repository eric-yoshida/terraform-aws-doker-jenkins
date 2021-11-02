#!/bin/bash
sudo yum update -y
sudo yum install yum-utils -y 

sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# # start services
sudo systemctl enable docker
sudo systemctl start docker

# # configurando o Jenkins

mkdir /home/ec2-user/jenkins-data
cd /home/ec2-user/jenkins-data
mkdir jenkins_home
sudo chown ec2-user: /home/ec2-user/* -R 

docker pull jenkins/jenkins

cat <<EOF > docker-compose.yml
version: '3'
services:
  jenkins:
    container_name: jenkins
    image: jenkins/jenkins
    ports:
      - "80:8080"
    volumes:
      - $PWD/jenkins_home:/var/jenkins_home
    networks:
      - net
networks:
  net:
EOF

docker-compose up -d
