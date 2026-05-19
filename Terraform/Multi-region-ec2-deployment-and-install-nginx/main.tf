terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# -----------------------------------------
# Provider - Mumbai
# -----------------------------------------
provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

# -----------------------------------------
# Provider - Virginia
# -----------------------------------------
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

# -----------------------------------------
# Security Group - Mumbai
# -----------------------------------------
resource "aws_security_group" "mumbai_sg" {
  provider = aws.mumbai

  name = "mumbai-nginx-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------------------
# Security Group - Virginia
# -----------------------------------------
resource "aws_security_group" "virginia_sg" {
  provider = aws.virginia

  name = "virginia-nginx-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------------------
# EC2 - Mumbai
# -----------------------------------------
resource "aws_instance" "mumbai_server" {
  provider = aws.mumbai

  ami                    = "ami-09ed39e30153c3bf9"
  instance_type          = "t3.micro"
  key_name               = "ragoo-new-aws"
  vpc_security_group_ids = [aws_security_group.mumbai_sg.id]

  tags = {
    Name = "Mumbai-Nginx-Server"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/ec2-user/ragoo-new-aws.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}

# -----------------------------------------
# EC2 - Virginia
# -----------------------------------------
resource "aws_instance" "virginia_server" {
  provider = aws.virginia

  ami                    = "ami-0236922087fa98b6e"
  instance_type          = "t3.micro"
  key_name               = "ragoo-virg-keypair"
  vpc_security_group_ids = [aws_security_group.virginia_sg.id]

  tags = {
    Name = "Virginia-Nginx-Server"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/ec2-user/ragoo-virg-keypair.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}
