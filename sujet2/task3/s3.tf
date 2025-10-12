resource "aws_s3_bucket" "static_web" {
  bucket = "wsc2024-47fnat-modb-7564297867453"

  tags = {
    Name        = "wsc2024-47fnat-modb"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "static_web" {
  bucket = aws_s3_bucket.static_web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_object" "index" {
  bucket   = aws_s3_bucket.static_web.id
  key      = "index.html"
  source   = "../../sujet2/task3/index.html"
  metadata = {"content-type": "text/html"}
  etag     = filemd5("../../sujet2/task3/index.html")
}

resource "aws_s3_object" "style" {
  bucket   = aws_s3_bucket.static_web.id
  key      = "style.css"
  source   = "../../sujet2/task3/style.css"
  metadata = {"content-type": "text/css"}

  etag = filemd5("../../sujet2/task3/style.css")
}


resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.static_web.id

  policy = <<POLICY
{
   "Version": "2008-10-17",
        "Id": "PolicyForCloudFrontPrivateContent",
        "Statement": [
            {
                "Sid": "AllowCloudFrontServicePrincipal",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.static_web.arn}/*",
                "Condition": {
                    "StringEquals": {
                      "AWS:SourceArn": "${aws_cloudfront_distribution.s3_distribution.arn}"
                    }
                }
            }
        ]
      }
POLICY

}

 