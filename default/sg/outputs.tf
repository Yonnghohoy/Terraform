output "security_group_id_bastion"{
  value = aws_security_group.bastion.id
}

output "security_group_id_private"{
  value = aws_security_group.private.id
}

