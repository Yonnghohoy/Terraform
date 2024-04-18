output "lb_arn" {
  value = aws_lb.web_lb.arn
}

output "zone_id" {
  value = aws_lb.web_lb.zone_id
}

output "lb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "alb_tg_arn" {
  value = aws_lb_target_group.alb-tg.arn
}

