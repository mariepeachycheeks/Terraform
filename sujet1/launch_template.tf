resource "aws_launch_template" "prod_app_back_lt" {
  name = "prod-app-back"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  instance_type = "t3.micro"

  image_id = data.aws_ami.ami.id


  vpc_security_group_ids = [aws_security_group.prod_app_back_sg.id]


  user_data = base64encode(templatefile("${path.root}//assets/prod_app_back.sh",
    {
      BUCKET   = aws_s3_bucket.prod_app_front_assets.id,
      DATABASE = aws_rds_cluster.prod_app_db.endpoint,

  }))
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "prod-app-back-as"

    }
  }
}

resource "aws_launch_template" "prod_app_front" {
  name = "prod-app-front"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  instance_type = "t3.micro"

  image_id = data.aws_ami.ami.id


  vpc_security_group_ids = [aws_security_group.prod_app_front_sg.id]


  user_data = base64encode(templatefile("${path.root}//assets/prod_app_front.sh",
    {
      BUCKET = aws_s3_bucket.prod_app_front_assets.id,
      HOST   = aws_lb.prod_app_back_alb.dns_name
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {

      Name = "prod-app-front-as"

    }
  }
}