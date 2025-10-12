resource "aws_lb" "marketing_web" {
  name               = "marketing-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "marketing_web" {
  name     = "marketing-web-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.server.id
}


resource "aws_lb_listener" "marketing_web" {
  load_balancer_arn = aws_lb.marketing_web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.marketing_web.arn
  }
}

