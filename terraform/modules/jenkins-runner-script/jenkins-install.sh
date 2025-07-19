#!/bin/bash
set -e

# Update package index
apt-get update

# Install Java 17 (recommended for Jenkins)
apt-get install -y openjdk-17-jdk

# Add Jenkins repository and key
mkdir -p /usr/share/keyrings
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

# Update and install Jenkins
apt-get update
apt-get install -y jenkins

# Set JAVA_HOME for Jenkins (optional)
echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/default/jenkins

# Enable and start Jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins

# --- Install Terraform ---
apt-get install -y gnupg software-properties-common curl unzip
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
apt-get update && apt-get install -y terraform

echo "Installation complete!"


#finally install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin