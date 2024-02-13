resource "aws_eip" "eip1" {
 vpc = true
 tags = {
  Name = "sjh-test-eip"
 }
}
