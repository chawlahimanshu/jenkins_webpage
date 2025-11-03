# --- Terraform Provider Setup ---
provider "aws" {
  region = "us-east-1"
}

# --- Create EC2 Instance ---
resource "aws_instance" "web_server" {
  ami           = "ami-0c7217cdde317cfec"   # Amazon Linux 2023 (use default AWS region)
  instance_type = "t2.micro"
  key_name      = "jenkins-key"             # replace with your existing key pair name

  # Security Group for web access
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>Hello World from Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Web-Server"
  }
}

# --- Security Group ---
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH inbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
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

# --- Output public IP ---
output "public_ip" {
  value = aws_instance.web_server.public_ip
  description = "The public IP address of the web server"
}
