resource "aws_security_group" "alb1-sg" {
 name = alb1-sg
 description = "allow 80,443 anywhere"
 vpc_id = aws_vpc.vpc.id
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  description = "HTTP"
  from_port = 80
  to_port = 80
  protocol = "tcp"
 }
 tags = {
  Name = "alb1-sg"
 }
}


resource "aws_security_group" "web-sg" {
 name = "web-sg"
 vpc_id = aws_vpc.vpc.id
 egress = {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
  Name = "web-sg"
 }
}

resource "aws_security_group_rule" "web-sg-http"{
 type = "ingress"
 from_port = 80
 to_port = 80
 protocol = "tcp"
 security_group_id = aws_security_group.web-sg.id
 source_security_group_id = aws_security_group.alb1-sg.id
}
