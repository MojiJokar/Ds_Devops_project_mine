variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_enable_ssh_https" {}
variable "user_data_install_apache" {}
variable "ec2_sg_name_for_python_api" {}
variable "enable_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

output "ssh_connection_string_for_ec2" {
  value = format(
    "ssh -i /home/moji/keys/ds_devops_project_keypair.pem ubuntu@%s",
    aws_instance.nginx.public_ip
  )
}



output "dev_proj_1_ec2_instance_id" {
  value = aws_instance.dev_proj_1_ec2.id
}

resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "aws_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_apache

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "dev_proj_1_public_key" {
  key_name   = "aws_key"
  public_key = var.public_key
}