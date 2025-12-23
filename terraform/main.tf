terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
}

# SECURE SECURITY GROUP (AI-REMEDIATED)
resource "aws_security_group" "secure_sg" {
  name        = "secure-sg"
  description = "Restricted security group with least privilege access"

  # SSH access restricted to trusted IP [cite: 8, 47]
  ingress {
    description = "SSH access restricted to trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"] # AI-remediated restricted range [cite: 65]
  }

  # Application port for your web app [cite: 21]
  ingress {
    description = "Allow web traffic on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic rule [cite: 21]
  egress {
    description = "Allow outbound HTTPS only"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# PROVISION THE VIRTUAL MACHINE [cite: 20]
resource "aws_instance" "web_app_instance" {
  ami                         = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS
  instance_type               = "t2.micro"             # Free-tier eligible
  vpc_security_group_ids      = [aws_security_group.secure_sg.id]
  associate_public_ip_address = true                   # Required for "Live IP" [cite: 81]

  tags = {
    Name = "DevOps-Assignment-Server"
  }
}

# OUTPUT FOR LIVE IP SCREENSHOT [cite: 76, 81]
output "public_ip" {
  value       = aws_instance.web_app_instance.public_ip
  description = "Use this IP for your 'Application running on cloud' screenshot"
}
