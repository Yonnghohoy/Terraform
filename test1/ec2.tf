resource "aws_instance" "bastion" {
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.pub1-sub.id
 vpc_security_group_ids = [aws_security_group.bastion-sg.id]
 associate_public_ip_address = true
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 EOF
 tags = {
  Name = "sjh-bastion"
 }
}
