variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_for_jenkins" {}
variable "enable_public_ip_address" {}
variable "user_data_install_jenkins" {}


output "ssh_connection_string_for_ec2" {
  value = format(
    "ssh -i /Users/mmb20/.ssh/ds_devops_keys ubuntu@%s",
    aws_instance.jenkins_ec2_instance_ip.public_ip
  )
}

output "jenkins_ec2_instance_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.id
}

output "jenkins_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.public_ip
}

# Only include these if you are calling the EKS module from this file
# output "eks_cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }
#
# output "eks_kubeconfig" {
#   value = module.eks.kubeconfig
# }

##############################
#         RESOURCES          #
##############################

resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = "ds_devops_keys"
  public_key = var.public_key
}

resource "aws_instance" "jenkins_ec2_instance_ip" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  #key_name                    = aws_key_pair.jenkins_ec2_instance_public_key.key_name
  key_name                    = "ds_devops_keys"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address
  user_data                   = var.user_data_install_jenkins

  tags = {
    Name = var.tag_name
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

