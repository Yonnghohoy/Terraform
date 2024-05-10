resource "aws_instance" "public" {
  count = 4
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id_bastion]
  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = format("%s-test-${count.index}",lower(var.name))
  }
}

