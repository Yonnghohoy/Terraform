resource "aws_route_table" "pub-rtb" {
 vpc_id = aws_vpc.vpc.id
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
   Name = "sjh-vpc"
  }
}

