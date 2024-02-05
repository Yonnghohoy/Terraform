resource "aws_route_table" "sjh_test_pub_rtb" {
 vpc_id = aws_vpc.sjh_testvpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.sjh_test_IGW.id
  }
  tags = {
   Name = "sjh_test_pub_rtb"
  }
}

resource "aws_route_table" "sjh_test_pri_rtb" {
 vpc_id = aws_vpc.sjh_testvpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
 
 tags = {
  Name = "sjh_test_pri_rtb"
  }
}

