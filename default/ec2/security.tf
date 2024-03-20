resource "aws_security_group" "web_sg" {
  name = "${var.name}-web-sg"
  description = "web-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = -1
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
