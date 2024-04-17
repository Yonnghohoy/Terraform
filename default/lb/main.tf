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
resource "aws_lb_listener" "https_redirect" {
  load_balancer_arn 	= aws_lb.web_lb.arn
  port 			= "80"
  protocol		= "HTTP"
  default_action {
    type		= "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "HTTPS_listener" {
  load_balancer_arn     = aws_lb.web_lb.arn
  port			= "443"
  protocol		= "HTTPS"
  ssl_policy		= "ELBSecurityPolicy-2016-08"
  certificate_arn	= var.acm_arn

  default_action {
    type = "forward"
    target_group_arn	= aws_lb_target_group.alb-tg.arn
  }
  
  depends_on = [var.acm_arn, var.acm_validation]
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

############ ALB attachment EC2 ############

resource "aws_lb_target_group_attachment" "web_attach" {
  count            = length(var.web_ids)
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = var.web_ids[count.index]
  port             = 80
}
