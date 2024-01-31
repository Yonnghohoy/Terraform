resource "aws_subnet" "PUB-test_subnet" {
 vpc_id = aws_vpc.sjh_testvpc.id
 cidr_block = "10.10.1.0/24"
 availability_zone = "ap-northeast-2a"
 tags = {
  Name = "sjh_test_PUB1"
  }
}
