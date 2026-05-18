# 1. Fetch the latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 2. Create the Security Group
resource "aws_security_group" "jenkins_sg" {
  name        = "sentinel-${var.environment}-jenkins-sg"
  description = "Allow SSH and Jenkins UI traffic"
  vpc_id      = module.vpc.vpc_id # This uses the output we just created!

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to the world for practice
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sentinel-${var.environment}-jenkins-sg"
  }
}

# 3. Deploy the EC2 Instance
resource "aws_instance" "jenkins_master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  # IMPORTANT: If you have an SSH Key Pair in AWS, uncomment the line below and add the name.
  key_name = "sentinel-jenkins-key"

  # Grab the profile name from the module output
  iam_instance_profile = module.jenkins_iam_role.instance_profile_name

  tags = {
    Name = "sentinel-${var.environment}-jenkins-master"
  }
  # NEW: The Bootstrapping Script
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              # Install Java (Jenkins requires Java)
              sudo apt-get install fontconfig openjdk-17-jre -y
              # Download and Install Jenkins
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install jenkins -y
              # Start the service
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF
}

# NEW: Output the Public IP so we don't have to log into the AWS Console

output "jenkins_public_ip" {
  description = "The public IP address of the Jenkins server"
  value       = aws_instance.jenkins_master.public_ip
}


module "jenkins_iam_role" {
  source = "../modules/iam"

  role_name    = "sentinel-${var.environment}-jenkins-role"
  profile_name = "sentinel-${var.environment}-jenkins-instance-profile"

  # You can add as many policies to this list as you want in the future
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
