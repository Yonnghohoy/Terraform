resource "aws_key_pair" "sjh_key" {
 key_name = "sjh_key"
 public_key = "ssh -rsa ca:a8:fe:62:d3:12:e9:f9:4c:42:49:83:ab:8f:12:a5:fd:64:90:d3"
}


resource "aws_instance" "pub_instance1" {
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.PUB-test_subnet.id
 vpc_security_group_ids = [aws_security_group.pub_sg.id]
 
 tags = {
  Name = "sjh_test"
 }
}

