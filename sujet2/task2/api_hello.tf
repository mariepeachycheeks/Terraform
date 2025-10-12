resource "aws_api_gateway_rest_api" "api" {
  name        = "ServerlessAPI"
  description = "Terraform Serverless Application"
}

/*resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "prod"
}*/

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_rest_api.api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}



resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.method.resource_id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello_world.invoke_arn

  depends_on = [aws_api_gateway_method.method]
}

resource "aws_api_gateway_deployment" "hello" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.method.id,
      aws_lambda_permission.allow_api.id,
      aws_api_gateway_integration.lambda.id,

    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.method,
      aws_lambda_permission.allow_api,
      aws_api_gateway_integration.lambda,
  ]
}

resource "aws_api_gateway_stage" "hello" {
  deployment_id = aws_api_gateway_deployment.hello.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "prod"
  depends_on = [aws_cloudwatch_log_group.api]
}

resource "aws_cloudwatch_log_group" "api" {
  name              = "API-Gateway-Execution-Logs"
  retention_in_days = 7
}

resource "aws_lambda_permission" "allow_api" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "hello_world"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/"
}

resource "aws_iam_role" "lambda_execution" {
  name = "lambda_execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the basic execution role
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

