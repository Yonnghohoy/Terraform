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


#################################
## Auto Scaling Group Setting ##

# Configuration
resource "aws_launch_configuration" "config" {
  name_prefix		= "sjh-launchconfig"
  image_id		= data.aws_ami.ubuntu.id
  instance_type		= var.instance_type
  security_groups	= [var.security_group_id_private]
  key_name		= aws_key_pair.key_pair.key_name

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
    echo "test-page" > /var/www/html/index.html
    echo "Nginx installation completed."
    apt install -y mysql
  EOF

  root_block_device {
    volume_size		= 30
    volume_type		= "gp3"
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy	= true
  }
}

# ASG setting
resource "aws_autoscaling_group" "sjh_asg" {
  name			= format("%s-asg", var.name)
  launch_configuration	= aws_launch_configuration.config.name
  vpc_zone_identifier	= [var.private_subnet_ids[0], var.private_subnet_ids[1]]

  health_check_type	= "ELB"
  health_check_grace_period	= 1800
  target_group_arns	= [var.alb_tg_arn]

  min_size 		= 2
  max_size		= 4
  desired_capacity	= 2

  tag {
    key			= "Name"
    value		= format("%s-asg-web", var.name)
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "target_tracking-policy" {
  name 			= format("%s-asg-policy", var.name)
  policy_type		= "TargetTrackingScaling"
  estimated_instance_warmup = 60
  autoscaling_group_name = aws_autoscaling_group.sjh_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}


#resource "aws_instance" "private" {
#  ami = data.aws_ami.ubuntu.id
#  instance_type = var.instance_type
#  count = length(var.private_subnet_ids)
#  subnet_id = var.private_subnet_ids[count.index]
#  vpc_security_group_ids = [var.security_group_id_private]
#  key_name = aws_key_pair.key_pair.key_name
#
#  tags = {
#    Name = "${var.name}-pri-${count.index+1}"
#  }
#  user_data = <<-EOF
#    #!/bin/bash
#    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
#    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
#    useradd sjh
#    echo "sjh:sjaksahffk." | sudo chpasswd
#    usermod -aG sudo sjh
#    systemctl restart sshd
#    # nginx
#    apt update -y
#    apt upgrade -y
#    apt install -y nginx
#    systemctl enable nginx --now
#    systemctl status nginx --no-pager
#    echo "test-page" > /var/www/html/index.html
#    echo "Nginx installation completed."
#    apt install -y mysql
#  EOF
#}
