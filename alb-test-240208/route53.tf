resource "aws_route53_zone" "hollyjunho" {
 name = "hollyjunho.store"
}

resource "aws_route53_record" "test" {
 zone_id = aws_route53_zone.hollyjunho.zone_id
 name = "www"
 type= "A"
 
 alias {
  name = aws_alb.alb1.dns_name
  zone_id = aws_alb.alb1.zone_id
  evaluate_target_health = true
 }
}

output "name_servers" {
  value = aws_route53_zone.hollyjunho.name_servers
}
