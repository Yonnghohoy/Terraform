locals {
  public_sg = format("%s-%s-sg", var.name, "bastion")
  private_sg = format("%s-%s-sg", var.name, "private")
  web_lb_sg = format("%s-%s-sg", var.name, "web-lb")
}



resource "aws_security_group" "bastion" {
  vpc_id = var.vpc_id
  name = local.public_sg
  description = "public sg for ${var.name}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["211.115.223.215/32"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
