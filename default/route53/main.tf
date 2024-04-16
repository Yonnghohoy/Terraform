############# Make Route53 Zone #############
resource "aws_route53_zone" "zone" {
  name = "hollyjunho.store"
}

############# Foward LB DNS #################
resource "aws_route53_record" "record" {
  name		 = aws_route53_zone.zone.name
  type		 = "A"
  zone_id	 = aws_route53_zone.zone.id

  alias {
    evaluate_target_health = true
    name 	 = var.lb_dns_name
    zone_id	 = var.lb_zone_id
  }
}

############### Configure ACM ###############
############### Cloudfront ACM ################
##provider "aws" {
##  alias		 = "virginia"
##  region	 = "us-east-1"
##}
#
#
################ Create CF ACM # ################
#resource "aws_acm_certificate" "hollyjunho_cf_acm" {
#  provider		 = aws.virginia
#  domain_name		 = "*.hollyjunho.store"
#  validation_method	 = "DNS"
#  lifecycle {
#    create_before_destroy = true
#  }
#  tags = {
#    Name = format("%s-cf-acm", var.name)
#  }
#}
#
############### attach CF ACM CNAME #############
#resource "aws_route53_record" "cf-cert_record" {
#  for_each = {
#    for dvo in aws_acm_certificate.hollyjunho_cf_acm.domain_validation_options : dvo.domain_name => {
#      name	= dvo.resource_record_name
#      record	= dvo.resource_record_value
#      type	= dvo.resource_record_type
#    }
#  }
#  name			 = each.value.name
#  allow_overwrite	 = true
#  records		 = [each.value.record]
#  ttl			 = 60
#  type			 = each.value.type
#  zone_id		 = aws_route53_zone.zone.zone_id
#}
#
#resource "aws_acm_certificate_validation" "cf_acm_validation" {
#  certificate_arn		= aws_acm_certificate.hollyjunho_cf_acm.arn
#  validation_record_fqdns	= [for record in aws_route53_record.cf_cert_record : record.fqdn]
#}
#

######## Seoul (ap-northeast-2) ACM ########
resource "aws_acm_certificate" "hollyjunho_acm" {
  domain_name           = "*.hollyjunho.store"
  validation_method     = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  subject_alternative_names = [ "*.hollyjunho.store" ]

  tags = {
    Name = format("%s-cf-acm", var.name)
  }
}

resource "aws_route53_record" "cert_record" {
  for_each = {
    for dvo in aws_acm_certificate.hollyjunho_acm.domain_validation_options : dvo.domain_name => {
      name	= dvo.resource_record_name
      record	= dvo.resource_record_value
      type	= dvo.resource_record_type
    }
  }

  name			 = each.value.name
  allow_overwrite	 = true
  records		 = [each.value.record]
  ttl			 = 60
  type			 = each.value.type
  zone_id		 = aws_route53_zone.zone.zone_id
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn		= aws_acm_certificate.hollyjunho_acm.arn
  validation_record_fqdns	= [for record in aws_route53_record.cert_record : record.fqdn]
}
