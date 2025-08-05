#!/bin/bash

#Ensure the script runs in non-interactive mode
export DEBIAN_FRONTEND=noninteractive

#Update the package list
sudo apt-get update -y

#Install Docker 
sudo apt-get install -y docker.io

#Start and enable docker 
sudo systemctl start docker
sudo systemctl enable docker

#Install necessary dependencies
sudo apt-get install -y unzip curl

#Download and install AWS cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/home/ubuntu/awscliv2.zip"
unzip -o /home/ubuntu/awscliv2.zip -d /home/ubuntu
sudo /home/ubuntu/aws/install

#Add ubuntu user to the docker group to run Docker commands without 'sudo'
sudo usermod -aG docker ubuntu

#Clean up the AWS CLI installation files
rm -rf /home/ubuntu/awscliv2.zip /home/ubuntu/aws
