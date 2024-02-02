resource "aws_instance" "test_instance" {
  ami           = "ami-0f3a440bbcff3d043"
  instance_type = "t2.micro"
  key_name      = "sjh_key"
  subnet_id     = aws_subnet.PUB-test_subnet.id
  vpc_security_group_ids = [aws_security_group.pub_sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
  #!/bin/bash
  apt-get install -y apache2
  systemctl enable apache2
  apt update
  apt upgrade -y
  echo "hello world" > /var/www/html/index.html
  EOF

  tags = {
    Name = "sjh_test_instance"
  }
}

