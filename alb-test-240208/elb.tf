resource "aws_alb" "alb1"{
 internal = false
 load_balancer_type = "application"
 security_groups = [aws_security_group.alb1-sg.id]
 subnets = [aws_subnet.pub-a.id,aws_subnet.pub-c.id]
 enable_cross_zone_load_balancing = true
 tags = {
  Name = "alb_ex"
 }
}

resource "aws_alb_target_group" "alb1-tg" {
 name = "alb1-tg"
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

resource "aws_alb_listener" "alb-listener" {
 load_balancer_arn = aws_alb.alb1.arn
 port = 80
 protocol = "HTTP"
 
 default_action {
  type = "forward"
  target_group_arn = aws_alb_target_group.alb1-tg.arn
  }
}

resource "aws_alb_target_group_attachment" "attach-web1" {
 target_group_arn = aws_alb_target_group.alb1-tg.arn
 target_id = aws_instance.pub1.id
}

resource "aws_alb_target_group_attachment" "attach-web2" {
 target_group_arn = aws_alb_target_group.alb1-tg.arn
 target_id = aws_instance.pub2.id
}
