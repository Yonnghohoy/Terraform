resource "aws_internet_gateway" "sjh_test_IGW" {
 vpc_id = aws_vpc.sjh_testvpc.id
 tags = {
  Name = "sjh_test_IGW"
  }
}
