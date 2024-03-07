output "vpc_id" {
  value	= aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

