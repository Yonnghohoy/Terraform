resource "aws_subnet" "PUB-test_subnet" {
 vpc_id = aws_vpc.sjh_testvpc.id
 cidr_block = "10.10.1.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh_test_PUB1"
  }
}

resource "aws_subnet" "PRI1-test_subnet" {
 vpc_id = aws_vpc.sjh_testvpc.id
 cidr_block = "10.10.2.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh_test_PRI1"
  }
}

resource "aws_subnet" "PRI2-test_subnet" {
 vpc_id = aws_vpc.sjh_testvpc.id
 cidr_block = "10.10.3.0/24"
 availability_zone = "ap-northeast-2c"
 tags = {
  Name = "sjh_test_PRI2"
  }
}

resource "aws_route_table_association" "pub_rtb_association1" {
  subnet_id = aws_subnet.PUB-test_subnet.id
  route_table_id = aws_route_table.sjh_test_pub_rtb.id
  }


resource "aws_route_table_association" "pri_rtb_association1" {
  subnet_id = aws_subnet.PRI1-test_subnet.id
  route_table_id = aws_route_table.sjh_test_pri_rtb.id
  }

resource "aws_route_table_association" "pri_rtb_association2" {
  subnet_id = aws_subnet.PRI2-test_subnet.id
  route_table_id = aws_route_table.sjh_test_pri_rtb.id
  }
