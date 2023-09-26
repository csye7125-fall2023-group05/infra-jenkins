
data "aws_route53_zone" "jenkins" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.jenkins.zone_id
  name    = "jenkins.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.jenkins_server_eip_public_ip]
}
