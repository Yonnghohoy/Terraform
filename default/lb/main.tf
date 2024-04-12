############ Configure ALB ############
resource "aws_lb" "web_lb" {
  name			= format("%s-web-lb",var.name)
  load_balancer_type 	= "application"
  subnets 		= var.public_subnet_ids
  security_groups 	= [var.security_group_id_web_sg]

  tags = {
    Name = "${var.name}-web-lb"
  }
}

############ ALB Listener ############
resource "aws_lb_listener" "http_web" {
  load_balancer_arn 	= aws_lb.web_lb.arn
  port 			= "80"
  protocol		= "HTTP"
  default_action {
    type		= "forward"
    target_group_arn	= aws_lb_target_group.alb-tg.arn
    }
  }


############ ALB target Group  ############
resource "aws_lb_target_group" "alb-tg" {
  name                  = format("%s-web-lb-tg",var.name)
  port			= 80
  protocol		= "HTTP"
  vpc_id		= var.vpc_id 
  target_type		= "instance"

  health_check {
    path		 = "/"
    protocol		 = "HTTP"
    matcher		 = "200"
    interval		 = 15
    timeout		 = 3
    healthy_threshold	 = 2
    unhealthy_threshold  = 2
  } 
  stickiness {
    type 		= "lb_cookie"
    cookie_duration	= 600
  }
}


