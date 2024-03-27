resource "aws_instance" "public" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count = length(var.public_subnet_ids)
  subnet_id = var.public_subnet_ids[count.index]
  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-pub-${count.index+1}"
  }
}

resource "aws_instance" "private" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]

  tags = {
    Name = "${var.name}-pri-${count.index+1}"
  }
}
