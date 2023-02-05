
resource "aws_lb_target_group" "web_tg" {
  name     = "webtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = local.common_tags

}

# create a load balancer

resource "aws_lb" "my_alb" {
  name               = "myAlb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_alb_sg.id]
  subnets            = aws_subnet.subnets[*].id

  enable_deletion_protection = false

  tags = local.common_tags
}


# create a listener

resource "aws_lb_listener" "listener_tg" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# attach the target group to the instances

resource "aws_lb_target_group_attachment" "web_tg" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web-servers[count.index].id
  port             = 80

}

