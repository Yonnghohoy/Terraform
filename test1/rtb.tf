resource "aws_route_table" "pub-rtb" {
 vpc_id = aws_vpc.vpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  }
 tags = {
  Name = "sjh-pub-rtb"
 }
}

resource "aws_route_table" "pri-rtb" {
 vpc_id = aws_vpc.vpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.ngw1.id
  }
 tags = {
  Name = "sjh-pri-rtb"
 }
}



resource "aws_route_table_association" "bastion-association" {
 subnet_id = aws_subnet.pub1-sub.id
 route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "alb-association" {
 subnet_id = aws_subnet.pub2-sub.id
 route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "pri1-association" {
 subnet_id = aws_subnet.pri1-sub.id
 route_table_id = aws_route_table.pri-rtb.id
}
