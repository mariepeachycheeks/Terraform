resource "aws_s3_bucket" "prod_app_front_assets" {
  bucket = "prod-app-front-assets-20250810114611296000000001"

  tags = {
    Name = "prod-app-front-assets"
  }
}

data "aws_iam_policy_document" "prod_app_front_permissions" {
  statement {
    actions = [
      "s3:GetObject",
      "",
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

resource "aws_s3_object" "innovatech" {
  bucket = aws_s3_bucket.prod_app_front_assets.id
  key    = "innovatech.sql"
  source = "${path.module}/assets/innovatech.sql"
  etag   = filemd5("${path.module}/assets/innovatech.sql")
}

resource "aws_s3_object" "back" {
  bucket = aws_s3_bucket.prod_app_front_assets.id
  key    = "back"
  source = "${path.module}/assets/back"
  etag   = filemd5("${path.module}/assets/back")
}


resource "aws_s3_object" "webserver" {
  bucket = aws_s3_bucket.prod_app_front_assets.id
  key    = "webserver"
  source = "${path.module}/assets/webserver"
  etag   = filemd5("${path.module}/assets/webserver")
}