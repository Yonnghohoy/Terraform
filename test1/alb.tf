resource "aws_alb" "alb" {
  internal                        = false
  load_balancer_type              = "application"
  security_groups                 = [aws_security_group.alb-sg.id]
  subnets                         = [aws_subnet.pub1-sub.id, aws_subnet.pub2-sub.id]
  enable_cross_zone_load_balancing = true
  tags = {
    Name = "sjh-test-alb"
  }
}

resource "aws_alb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    interval            = 15
    path                = "/"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "http-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-2016-08"

  default_action {
    target_group_arn = aws_alb_target_group.alb-tg.arn
    type             = "forward"
  }

  certificate_arn = "arn:aws:acm:ap-northeast-2:057845469470:certificate/a8081e40-15a1-4d3d-a665-b3fb18ad4aa2"
}

resource "aws_alb_target_group_attachment" "attach-web1" {
  target_group_arn = aws_alb_target_group.alb-tg.arn
  target_id        = aws_instance.web1.id
}

resource "aws_alb_target_group_attachment" "attach-web2" {
  target_group_arn = aws_alb_target_group.alb-tg.arn
  target_id        = aws_instance.web2.id
}

