output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}
output "private_subnet_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "rds_subnet_ids" {
  value = values(aws_subnet.rds_subnets)[*].id
}
