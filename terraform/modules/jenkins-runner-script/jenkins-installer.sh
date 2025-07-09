#!/bin/bash
sudo apt-get update

# Install Java 17 (required for recent Jenkins versions)
yes | sudo apt install openjdk-17-jdk

# Optionally, set JAVA_HOME for Jenkins
echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" | sudo tee -a /etc/default/jenkins

echo "Waiting for 30 seconds before installing the Jenkins package..."
sleep 30

# Add Jenkins repository and key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
yes | sudo apt-get install jenkins

sleep 30

# Install Terraform (optional, as in your original script)
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip
yes | sudo apt-get install unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/
