
resource "aws_lb" "prod_app_front_alb" {
  name               = "prod-app-front-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.front_lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "front_app_tg" {
  name        = "front-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.production.id
  target_type = "instance"
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.prod_app_front_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_app_tg.arn
  }
}

/*resource "aws_lb_target_group_attachment" "front_instance_attach" {
  count            = 1
  target_group_arn = aws_lb_target_group.front_app_tg.arn
  target_id        = aws_instance.prod-app-front.id
  port             = 80
}
*/
resource "aws_lb" "prod_app_back_alb" {
  name               = "prod-app-back-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.back_lb_sg.id]
  subnets            = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "back_app_tg" {
  name        = "back-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.production.id
  target_type = "instance"

  /*health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }*/
}

resource "aws_lb_listener" "tcp_priv" {
  load_balancer_arn = aws_lb.prod_app_back_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_app_tg.arn
  }
}

/*resource "aws_lb_target_group_attachment" "back_instance_attach" {
  count            = 1
  target_group_arn = aws_lb_target_group.back_app_tg.arn
  target_id        = aws_instance.prod-app-back.id
  port             = 80
}*/