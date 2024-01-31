resource "aws_security_group" "pub_sg" {
 vpc_id = aws_vpc.sjh_testvpc.id
 name = "pub_SG"
 description = "pub_SG"
 tags = {
  Name = "sjh_pub_SG"
 }
}

resource "aws_security_group_rule" "pub_sg_http_ingress" {
 type = "ingress"
 from_port = 80
 to_port = 80
 protocol = "TCP"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = aws_security_group.pub_sg.id
 lifecycle{
  create_before_destroy = true
 }
}

resource "aws_security_group_rule" "pub_sg_ssh_ingress" {
 type = "ingress"
 from_port = 22
 to_port = 22
 protocol = "TCP"
 cidr_blocks = ["211.115.223.215/32"]
 security_group_id = aws_security_group.pub_sg.id
 lifecycle{
  create_before_destroy = true
 }
}

