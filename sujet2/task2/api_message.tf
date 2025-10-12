resource "aws_api_gateway_resource" "message" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "message"
}

resource "aws_api_gateway_method" "method_message" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.message.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_message" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.method_message.resource_id
  http_method = aws_api_gateway_method.method_message.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.message.invoke_arn

  depends_on = [aws_api_gateway_method.method_message]

}

resource "aws_lambda_permission" "allow_api_message" {
  statement_id  = "AllowExecutionFromAPIGatewayMessage"
  action        = "lambda:InvokeFunction"
  function_name = "message"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/message"
}

resource "aws_api_gateway_deployment" "message" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.method_message.id,
      aws_lambda_permission.allow_api_message.id,
      aws_api_gateway_integration.lambda_message.id,
      aws_lambda_function.message.id

    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.method_message,
      aws_lambda_permission.allow_api_message,
      aws_api_gateway_integration.lambda_message,
      aws_lambda_function.message
  ]
}




