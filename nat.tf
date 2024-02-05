resource "aws_eip" "eip_1" {
  vpc = true
  lifecycle {
   create_before_destroy = true
  }
}


resource "aws_nat_gateway" "nat_gateway_1"{
  allocation_id = aws_eip.eip_1.id
  subnet_id = aws_subnet.PUB-test_subnet.id
  tags = {
   Name = "sjh-nat-gateway-1"
  }
}
