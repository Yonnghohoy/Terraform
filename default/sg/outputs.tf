output "security_group_id_bastion"{
  value = aws_security_group.bastion.id
}

output "security_group_id_private"{
  value = aws_security_group.private.id
}

output "security_group_id_web_sg"{
  value = aws_security_group.web_lb_sg.id
}

output "security_group_id_rds" {
  value = aws_security_group.rds.id
}

