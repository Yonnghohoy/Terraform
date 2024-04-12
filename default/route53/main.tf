resource "aws_route53_zone" "zone" {
  name = "hollyjunho.store"
}

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

