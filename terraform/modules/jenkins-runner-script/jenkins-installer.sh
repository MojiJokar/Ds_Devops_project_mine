#!/bin/bash

set -e  # Exit on any error

# Update package index
sudo apt-get update

# Install Java 17 (required for recent Jenkins versions)
sudo apt-get install -y openjdk-17-jdk

echo "Waiting for 30 seconds after Jenkins install..."
sleep 30

sudo systemctl start jenkins
sudo systemctl enable jenkins


# Optionally, set JAVA_HOME for Jenkins
echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" | sudo tee -a /etc/default/jenkins

echo "Waiting for 30 seconds before installing the Jenkins package..."
sleep 30

# Add Jenkins repository and key
sudo mkdir -p /usr/share/keyrings
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install -y jenkins

echo "Waiting for 30 seconds after Jenkins install..."
sleep 30

# Install Terraform (optional)
TERRAFORM_VERSION="1.6.5"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo apt-get install -y unzip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "Installation complete!"
