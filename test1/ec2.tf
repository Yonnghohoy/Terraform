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

resource "aws_instance" "web1" {
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.pri1-sub.id
 vpc_security_group_ids = [aws_security_group.web-sg.id]
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 apt-get install apache2 -y
 systemctl enable apache2
 echo "test-page1" > /var/www/html/index.html
 EOF
 tags = {
  Name = "sjh-web1"
 }
}
resource "aws_instance" "web2" {
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.pri2-sub.id
 vpc_security_group_ids = [aws_security_group.web-sg.id]
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 apt-get install apache2 -y
 systemctl enable apache2
 echo "test-page2" > /var/www/html/index.html
 EOF
 tags = {
  Name = "sjh-web2"
 }
}
