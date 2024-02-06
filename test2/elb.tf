resource "aws_lb" "alb_1"{
 internal = false
 load_balancer_type = "application"
 security_groups = [aws_security_group.lb-1-sg.id]
 subnets = [aws_subnet.pub-a.id,aws_subnet.pub-c.id]
 tags = {
  name = "alb_ex"
 }
}
