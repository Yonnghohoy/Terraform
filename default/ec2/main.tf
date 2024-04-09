resource "aws_instance" "public" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id_bastion]
  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${var.name}-pub-bastion"
  }
}

resource "aws_instance" "private" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id_private]
  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${var.name}-pri-${count.index+1}"
  }
}
