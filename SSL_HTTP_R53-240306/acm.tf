resource "aws_route53_record" "acm" {
 zone_id = aws_route53_zone.hollyjunho.zone_id
 name = "_9fb79b2418350ccad1e3b8a7db3f3603.hollyjunho.store."
 type = "CNAME"
 ttl = "300"
 records = ["_a9ed269f4c62812e3023f07bf9745b9e.mhbtsbpdnt.acm-validations.aws."]
}
