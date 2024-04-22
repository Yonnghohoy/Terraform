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

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id
  name = local.private_sg
  description = "private sg for ${var.name}"
 # ingress {
 #   from_port = 80
 #   to_port = 80
 #   protocol = "tcp"
 #   cidr_blocks = ["0.0.0.0/0"]
 # }
 # ingress {
 #   from_port = 443
 #   to_port = 443
 #   protocol = "tcp"
 #   cidr_blocks = ["0.0.0.0/0"]
 # }
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

resource "aws_security_group_rule" "allow_alb_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.web_lb_sg.id
  security_group_id = aws_security_group.private.id
}
resource "aws_security_group_rule" "allow_alb_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = aws_security_group.web_lb_sg.id
  security_group_id = aws_security_group.private.id
}

################ LB SG ##################
resource "aws_security_group" "web_lb_sg" {
  name		= local.web_lb_sg
  description	= "${var.name} external LB SG"
  vpc_id 	= var.vpc_id

  ingress {
	from_port	= 80
	to_port		= 80
	protocol	= "tcp"
	cidr_blocks	= ["0.0.0.0/0"]
  }

  ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
  }

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

######### RDS SG ############
resource "aws_security_group" "rds" {
  name		= format("%s-rds-sg",var.name)
  description	= "rds security group for ${var.name}"
  vpc_id	= var.vpc_id

  egress {
    from_port 	= 0
    to_port	= 0
    protocol	= "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = format("%s-rds-sg",var.name)
  }
}

resource "aws_security_group_rule" "rds_bastion_ssh_ingress" {
  type				= "ingress"
  from_port			= "22"
  to_port			= "22"
  protocol			= "TCP"
  security_group_id		= "${aws_security_group.rds.id}"
  source_security_group_id 	= "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "rds_bastion_mysql_ingress" {
  type				= "ingress"
  from_port			= "3306"
  to_port			= "3306"
  protocol			= "TCP"
  security_group_id		= "${aws_security_group.rds.id}"
  source_security_group_id 	= "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "rds_web_mysql_ingress" {
  type				= "ingress"
  from_port			= "3306"
  to_port			= "3306"
  protocol			= "TCP"
  security_group_id		= "${aws_security_group.rds.id}"
  source_security_group_id 	= "${aws_security_group.private.id}"
}
