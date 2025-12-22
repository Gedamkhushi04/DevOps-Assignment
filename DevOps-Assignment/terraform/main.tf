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

  ingress {
    description = "SSH access restricted to trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"]   # restricted IP range
  }

  egress {
    description = "Allow outbound HTTPS only"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
