resource "aws_key_pair" "jenkins_key" {
  key_name   = "ec2_key"
  public_key = file("~/.ssh/${var.ssh_key_file}")
}
