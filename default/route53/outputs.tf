output "acm_arn" {
  value = aws_acm_certificate.hollyjunho_acm.arn
}

output "acm_validation" {
  value = aws_acm_certificate_validation.acm_validation
}

