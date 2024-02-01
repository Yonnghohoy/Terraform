resource "aws_instance" "pub_instance1" {
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.PUB-test_subnet.id
 vpc_security_group_ids = [aws_security_group.pub_sg.id]
 associate_public_ip_address = true
 
 tags = {
  Name = "sjh_test"
 }
}

