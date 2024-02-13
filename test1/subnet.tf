resource "aws_subnet" "pub1-sub" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.1.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh-pub1"
 }
}

resource "aws_subnet" "pub2-sub" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.2.0/24"
 availability_zone = "ap-northeast-2c"
 tags = {
  Name = "sjh-pub2"
 }
}

resource "aws_subnet" "pri1-sub" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.3.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh-pri1"
 }
}

resource "aws_subnet" "pri2-sub" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "10.10.4.0/24"
 availability_zone = "ap-northeast-2c"
 tags = {
  Name = "sjh-pri2"
 }
}
