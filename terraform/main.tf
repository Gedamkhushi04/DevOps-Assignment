provider "aws" {
  region = "ap-south-1" 
}

resource "aws_security_group" "secure_sg" {
  name        = "secure-sg"
  description = "Restricted security group with least privilege access"

  # FIX: Restricting SSH access to a specific trusted IP instead of 0.0.0.0/0
  ingress {
    description = "SSH access restricted to trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24"] # Example of a restricted range
  }

  ingress {
    description = "Allow web traffic on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound HTTPS only"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.secure_sg.id]

  tags = {
    Name = "DevOps-Assignment-Server"
  }
}
