locals {
  public_sg = format("%s-%s-sg", var.name, "bastion")
  private_sg = format("%s-%s-sg", var.name, "private")
}



resource "aws_security_group" "bastion" {
  vpc_id = var.vpc_id
  name = local.public_sg
  description = "public sg for ${var.name}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id
  name = local.private_sg
  description = "private sg for ${var.name}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_bastion_ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id = aws_security_group.private.id
}

