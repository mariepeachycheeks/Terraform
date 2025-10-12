resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2.name
}

resource "aws_launch_template" "webserver" {
  name = "webserver"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  instance_type = "t3.micro"

  image_id = data.aws_ami.ami.id


  vpc_security_group_ids = [aws_security_group.ec2.id]


  user_data = base64encode(templatefile("../../sujet2/task1/marketing_web.sh",
    {
      BUCKET = aws_s3_bucket.web_app.id,
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "marketing-web"

    }
  }
}

