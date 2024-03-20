resource "aws_instance" "public" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-web1"
  }
}


