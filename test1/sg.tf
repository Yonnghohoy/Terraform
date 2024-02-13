resource "aws_security_group" "bastion-sg" {
 vpc_id = aws_vpc.vpc.id
 name = "bastion-sg"
 description = "bastion-ssg"
 tags = {
  Name = "sjh-bastion-sg"
 }
 ingress {
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = ["211.115.223.215/32"]
  }
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "web-sg" {
 vpc_id = aws_vpc.vpc.id
 name = "web-sg"
 description = "web-sg"
 tags = {
  Name = "sjh-web-sg"
 }
 ingress {
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = ["211.115.223.215/32"]
  }
 ingress {
  from_port = 22
  to_port = 22
  protocol = "TCP"
  security_groups = [aws_security_group.bastion-sg.id]
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


