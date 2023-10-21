variable "region" {
  description = "VPC region"
  default     = "us-east-1"
  type        = string
}

variable "env" {
  description = "Infra Environment"
  default     = "dev"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
  type        = string
}

variable "public_route_table_cidr_block" {
  description = "Public route table CIDR block"
  default     = "0.0.0.0/0"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks and availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks and availability zones"
  type        = list(string)
}

variable "root_account_ids" {
  description = "Karan, Sid, Rishab ROOT Account ids"
  type        = list(string)
  default     = ["835431937788", "547416033541", "078164504089"]
}

variable "ami_prefix" {
  description = "AMI name prefix"
  type        = string
  default     = "CSYE7125-jenkins-*"
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "domain_name" {
  description = "hosted zone name"
  type        = string
  default     = "domain.tld"
}

variable "ssh_key_file" {
  description = "ssh-keygen generated public RSA key to SSH into an EC2 instance"
  type        = string
  default     = "ec2_ssh_key.pub"
}

# variable "profile" {
#   description = "AWS profile"
#   type        = string
# }

# variable "public_key" {
#   description = "SSH public key"
#   type        = string
# }

# variable "domain_name" {
#   description = "domain name for A record"
#   type        = string
# }
