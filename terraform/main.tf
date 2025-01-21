terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "your_aws_region" # e.g., us-east-1
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c94855ba95c574c8" # Example Ubuntu 22.04 AMI, adjust as needed
  instance_type = "t2.micro"
  key_name      = "your_ec2_key_pair" # Your EC2 Key Pair
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt update -y
              sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
              sudo usermod -aG docker ubuntu
              newgrp docker
              EOF
  tags = {
    Name = "Simple-Web-Deployment-EC2"
  }
  vpc_security_group_ids = [aws_security_group.allow_web.id]
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web traffic"
  vpc_id      = "your_vpc_id" # Replace with your VPC ID

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
