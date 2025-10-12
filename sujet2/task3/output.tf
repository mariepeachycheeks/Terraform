output "s3-bucket-arn" {
  value = aws_s3_bucket.static_web.arn
}

output "s3-bucket-name" {
  value = aws_s3_bucket.static_web.bucket_domain_name
}


output "website-url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}