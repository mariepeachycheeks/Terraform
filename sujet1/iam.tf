resource "aws_iam_role" "prod_app_back" {
  name = "prod-app-back-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "prod_app_back_inline" {
  name = "inline-policy"
  role = aws_iam_role.prod_app_back.id
  policy = data.aws_iam_policy_document.s3_front_assets.json
}
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.prod_app_back.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "prod-app-back-instance-profile"
  role = aws_iam_role.prod_app_back.name
}


data "aws_iam_policy_document" "s3_front_assets" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.prod_app_front_assets.arn}/*",
    ]
  }

  statement {

    actions = [
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }
}