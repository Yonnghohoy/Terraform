resource "aws_instance" "pub1"{
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws.subnet.pub-a.id
 vpc_security_group_ids = [aws_security_group.pub1-sg.id]
 associate_public_ip_address = true
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 EOF
 tags = {
  Name = "sjh-test-pub1"
  }
 }
