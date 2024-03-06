output "vpc_id" {
  value	= aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.sjh-public.id
}

output "private_subnet_id" {
  value = aws_subnet.sjh-private.id
}

