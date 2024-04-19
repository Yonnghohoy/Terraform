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
resource "aws_lb_listener" "http" {
  load_balancer_arn	= aws_lb.web_lb.arn
  port 			= var.web_lb_listener_port_http
  protocol		= var.web_lb_listener_protocol_http
  
  default_action {
    type		= "redirect"
    redirect {
      port 		= var.web_lb_listener_port_https
      protocol		= var.web_lb_listener_protocol_https
      status_code	= "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn	= aws_lb.web_lb.arn
  port			= var.web_lb_listener_port_https
  protocol		= var.web_lb_listener_protocol_https
  certificate_arn 	= var.acm_arn
  
  default_action {
    type		= "forward"
    target_group_arn	= aws_lb_target_group.alb-tg.arn
  }
  
  depends_on 		= [var.acm_arn, var.acm_validation]
}


############ ALB target Group  ############
resource "aws_lb_target_group" "alb-tg" {
  name                  = format("%s-web-lb-tg",var.name)
  port			= var.web_lb_tg_port
  protocol		= var.web_lb_tg_protocol
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

