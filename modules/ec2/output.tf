output "jenkins_server_eip_public_ip" {
  value = aws_eip.jenkins_server_eip.public_ip
}
