resource "aws_security_group" "lb-1-sg"{
 vpc_id = aws_vpc.vpc.id
 name = "alb-sg"
 description = "alb-sg"
 tags = {
  Name = "sjh-test-alb-sg"
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
