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
  user_data = <<-EOF
    #!/bin/bash
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    useradd sjh
    echo "sjh:sjaksahffk." | sudo chpasswd
    usermod -aG sudo sjh
    systemctl restart sshd
    apt update -y
    apt upgrade -y
  EOF

  root_block_device {
    volume_size		= 8
    volume_type		= "gp3"
    delete_on_termination = true
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
  user_data = <<-EOF
    #!/bin/bash
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    useradd sjh
    echo "sjh:sjaksahffk." | sudo chpasswd
    usermod -aG sudo sjh
    systemctl restart sshd
    # nginx
    apt update -y
    apt upgrade -y
    apt install -y nginx
    systemctl enable nginx --now
    systemctl status nginx --no-pager
    echo "<h1>Instance IP: $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</h1>" > /var/www/html/index.html
    echo "Nginx installation completed."
    apt install -y mysql
  EOF
}
