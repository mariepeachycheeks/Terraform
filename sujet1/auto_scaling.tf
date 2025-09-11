resource "aws_autoscaling_group" "prod_app_back" {
  name                      = "prod-app-back"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.private[0].id, aws_subnet.private[1].id, aws_subnet.private[2].id]

  target_group_arns = [aws_lb_target_group.back_app_tg.arn]
  launch_template {
    id      = aws_launch_template.prod_app_back_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "prod-app-back-sg"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_group" "prod_app_front" {
  name                      = "prod-app-front"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]

  target_group_arns = [aws_lb_target_group.front_app_tg.arn]
  launch_template {
    id      = aws_launch_template.prod_app_front.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  tag {
    key                 = "Name"
    value               = "prod-app-front-sg"
    propagate_at_launch = true
  }

}