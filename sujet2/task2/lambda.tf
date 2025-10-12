resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda.zip"
}


resource "aws_lambda_function" "hello_world" {
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  function_name = "hello_world"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda.lambda_handler_hello"


  runtime = "python3.11"


  tags = {
    Environment = "production"
    Application = "example"
  }
  
}

resource "aws_lambda_function" "date" {
  filename = data.archive_file.lambda_zip.output_path

  function_name = "date"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda.lambda_handler_date"


  runtime = "python3.11"


  tags = {
    Environment = "production"
    Application = "example"
  }
}

resource "aws_lambda_function" "message" {
  
  filename = data.archive_file.lambda_zip.output_path
  description = "function message again new"
  function_name = "message"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda.lambda_handler_message"


  runtime = "python3.11"


  tags = {
    Environment = "production"
    Application = "example"
  }
}