resource "aws_instance" "pub1"{
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.pub-a.id
 vpc_security_group_ids = [aws_security_group.web-sg.id]
 associate_public_ip_address = true
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 apt-get install -y apache2
 systemctl enable apache2
 echo "hello world1" > /var/www/html/index.html
 EOF
 tags = {
  Name = "sjh-test-pub1"
  }
 }

resource "aws_instance" "pub2"{
 ami = "ami-0f3a440bbcff3d043"
 instance_type = "t2.micro"
 key_name = "sjh_key"
 subnet_id = aws_subnet.pub-c.id
 vpc_security_group_ids = [aws_security_group.web-sg.id]
 associate_public_ip_address = true
 user_data = <<-EOF
 #!/bin/bash
 apt update
 apt upgrade -y
 apt-get install -y apache2
 systemctl enable apache2
 echo "hello world2" > /var/www/html/index.html
 EOF
 tags = {
  Name = "sjh-test-pub2"
  }
 }
