resource "aws_security_group" "pub_sg" {
 vpc_id = aws_vpc.sjh_testvpc.id
 name = "pub_SG"
 description = "pub_SG"
 tags = {
  Name = "sjh_pub_SG"
 }
 ingress {
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = ["211.115.223.215/32"]
  }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "pri_sg" {
 vpc_id = aws_vpc.sjh_testvpc.id
 name = "pri_SG"
 description = "pri_SG"
 tags = {
  Name = "sjh_pri_SG"
 }
 ingress {
  from_port = 22
  to_port = 22
  protocol = "TCP"
  security_groups = [aws_security_group.pub_sg.id]
  }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "TCP"
  security_groups = [aws_security_group.pub_sg.id]
  }
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}


