/*resource "aws_instance" "marketing_webapp" {
  ami                  = var.ami
  instance_type        = "t3.micro"
  subnet_id            = aws_subnet.public.id
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "marketing-webapp"
  }
}*/