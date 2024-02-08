resource "aws_subnet" "pub-a" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.1.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh-pub-a"
  }
}


resource "aws_subnet" "pub-c" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.2.0/24"
 availability_zone = "ap-northeast-2c"
 tags = {
  Name = "sjh-pub-c"
  }
}

resource "aws_route_table_association" "pub-a-association"{
 subnet_id = aws_subnet.pub-a.id
 route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "pub-c-association"{
 subnet_id = aws_subnet.pub-c.id
 route_table_id = aws_route_table.pub-rtb.id
}

