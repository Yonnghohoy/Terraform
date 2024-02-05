resource "aws_eip" "eip_1" {
  vpc = true
  lifecycle {
   create_before_destroy = treu
  }
}


resource "aws_nat_gateway" "nat_gateway_1"{
  allocation_id = aws_eip.eip_1.id
  subnet_id = aws_subnet.PUB-test_subnet.id
  tags = {
   Name = "sjh-nat-gateway-1"
  }
}


resource "aws_route_table_association" "pri_rtb_association1" {
  subnet_id = aws_subnet.PRI1-test_subnet.id
  route_table_id = aws_route_table.sjh_test_pri_rtb.id
  }

resource "aws_route_table_association" "pri_rtb_association2" {
  subnet_id = aws_subnet.PRI2-test_subnet.id
  route_table_id = aws_route_table.sjh_test_pri_rtb.id
  }

resource "aws_route" "pri_rtb_route" {
  route_table_id = aws_route_table.sjh_test_pri_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }

