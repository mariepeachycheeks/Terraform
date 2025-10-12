data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "ua_referer" {
  name = "Managed-UserAgentRefererHeaders"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.static_web.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.static_web.id
    origin_id                = "wsc2024-47fnat-modb"
  }

  enabled = true
  //is_ipv6_enabled     = true
  //comment             = "Some comment"
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods          = ["GET", "HEAD"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = "wsc2024-47fnat-modb"
    cache_policy_id          = data.aws_cloudfront_cache_policy.cache_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.ua_referer.id


    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  tags = {
    Name        = "wsc2024-47fnat-modb"
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_cloudfront_origin_access_control" "static_web" {
  name                              = "static_web"
  description                       = "static_web Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
