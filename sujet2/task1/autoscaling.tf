resource "aws_autoscaling_group" "marketing_web" {
  name                      = "marketing-web"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]

  target_group_arns = [aws_lb_target_group.marketing_web.arn]
  launch_template {
    id      = aws_launch_template.webserver.id
    version = "$Latest"
  }
  
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "webserver"
    propagate_at_launch = true
  }

  /*dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }*/
}
