data "aws_ami" "jenkins_ami" {
  most_recent = true
  owners      = var.root_account_ids

  filter {
    name   = "name"
    values = [var.ami_prefix]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "JenkinsServerSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "JenkinsServerSG"
  }
}

resource "aws_network_interface" "jenkins_server_nic" {
  subnet_id       = var.public_subnets[0]
  security_groups = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "jenkins_server_network_interface"
  }
}

resource "aws_eip" "jenkins_server_eip" {
  domain = "vpc"

  # instance   = aws_instance.jenkins_server.id
  network_interface = aws_network_interface.jenkins_server_nic.id
  depends_on        = [var.igw_id]

  # TODO: tags
}

resource "aws_instance" "jenkins_server" {
  ami           = data.aws_ami.jenkins_ami.id
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.jenkins_server_nic.id
    device_index         = 0
  }

  user_data = base64encode("${templatefile("../modules/ec2/userdata.sh", {
    DOMAIN_NAME = "jenkins.${var.domain_name}"
  })}")

  tags = {
    Name = "Jenkins Server"
  }
}

