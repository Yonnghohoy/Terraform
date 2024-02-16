resource "aws_alb" "alb" {
 internal = false
 load_balancer_type = "application"
 security_groups = [aws_security_group.alb-sg.id]
 subnets = [aws_subnet.pub1-sub.id, aws_subnet.pub2-sub.id]
 enable_cross_zone_load_balancing = true
 tags = {
  Name = "sjh-test-alb"
  }
}

resource "aws_alb_target_group" "alb-tg" {
 name = "alb-tg"
 port = 80
 protocol = "HTTP"
 vpc_id = aws_vpc.vpc.id

 health_check {
  interval = 15
  path = "/"
  port = 80
  healthy_threshold = 3
  unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "http-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 80
  protocol = "HTTP"

 default_action {
  type = "forward"
  target_group_arn = aws_alb_target_group.alb-tg.arn
 }
}


resource "aws_alb_target_group_attachment" "attache-web1" {
 target_group_arn = aws_alb_target_group.alb-tg.arn
 target_id = aws_instance.web1.id
}

resource "aws_alb_target_group_attachment" "attache-web2" {
 target_group_arn = aws_alb_target_group.alb-tg.arn
 target_id = aws_instance.web2.id
}
