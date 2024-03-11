resource "aws_instance" "public" {
  key_name 	= "sjh_key"
  ami		= var.ami_id
  instance_type = var.instance_type
  subnet_id 	= module.vpc.public_subnet_ids
  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}

