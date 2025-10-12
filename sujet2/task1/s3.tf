resource "aws_s3_bucket" "web_app" {
  bucket = "web-app3435674553587067564"

  tags = {
    Name        = "web-app"
    Environment = "Prod"
  }
}
resource "aws_s3_object" "webserver" {
  bucket = aws_s3_bucket.web_app.id
  key    = "webserver_x86_64"
  source = "../../sources sujet 2/CR01/webserver_x86_64"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../../sources sujet 2/CR01/webserver_x86_64")
}