resource "aws_nat_gateway" "ngw1" {
 allocation_id = aws_eip.eip1.id
 subnet_id = aws_subnet.pub2-sub.id
 tags = {
  Name = "sjh-test-ngw"
  }
}

