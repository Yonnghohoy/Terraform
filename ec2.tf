resource "aws_instance" "test_instance1" {
  ami           = "ami-0f3a440bbcff3d043"
  instance_type = "t2.micro"
  key_name      = "sjh_key"
  subnet_id     = aws_subnet.PUB-test_subnet.id
  vpc_security_group_ids = [aws_security_group.pub_sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
  #!/bin/bash
  apt update
  apt upgrade -y
  EOF
  tags = {
    Name = "sjh_test_bastion"
  }
}

resource "aws_instance" "test_instance2" {
  ami           = "ami-0f3a440bbcff3d043"
  instance_type = "t2.micro"
  key_name      = "sjh_key"
  subnet_id     = aws_subnet.PRI1-test_subnet.id
  vpc_security_group_ids = [aws_security_group.pri_sg.id]
  user_data = <<-EOF
  #!/bin/bash
  apt update
  apt upgrade -y
  apt-get install apache2 -y
  apt update
  apt upgrade -y
  EOF
  tags = {
    Name = "sjh_test_web1"
  }
}

#resource "aws_instance" "test_instance3" {
#  ami           = "ami-0f3a440bbcff3d043"
#  instance_type = "t2.micro"
#  key_name      = "sjh_key"
#  subnet_id     = aws_subnet.PRI2-test_subnet.id
#  vpc_security_group_ids = [aws_security_group.pri_sg.id]
#  tags ={
#    Name = "sjh_test_web2"
#  }
#}
