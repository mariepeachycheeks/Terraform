# resource "aws_instance" "prod-app-front" {
#   ami                  = var.ami
#   instance_type        = "t3.micro"
#   subnet_id            = aws_subnet.public[0].id
#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

#   vpc_security_group_ids = [aws_security_group.prod_app_front_sg.id]

#   user_data = templatefile("${path.root}//assets/prod_app_front.sh",
#     {
#       BUCKET = aws_s3_bucket.prod_app_front_assets.id,
#   })
#   tags = {
#     Name = "prod-app-front"
#   }
# }


# resource "aws_instance" "prod-app-back" {
#   ami                  = var.ami
#   instance_type        = "t3.micro"
#   subnet_id            = aws_subnet.private[0].id
#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
#   tags = {
#     Name = "prod-app-back"
#   }
#   vpc_security_group_ids = [aws_security_group.prod_app_back_sg.id]

#   user_data = templatefile("${path.root}//assets/prod_app_back.sh",
#     {
#       BUCKET   = aws_s3_bucket.prod_app_front_assets.id,
#       DATABASE = aws_rds_cluster.prod_app_db.endpoint,

#   })
# }