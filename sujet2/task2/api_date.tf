resource "aws_api_gateway_resource" "date" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "date"
}

resource "aws_api_gateway_method" "method_date" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.date.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_date" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.method_date.resource_id
  http_method = aws_api_gateway_method.method_date.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.date.invoke_arn

  depends_on = [aws_api_gateway_method.method_date]

}

resource "aws_lambda_permission" "allow_api_date" {
  statement_id  = "AllowExecutionFromAPIGatewayDate"
  action        = "lambda:InvokeFunction"
  function_name = "date"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/GET/date"
}

resource "aws_api_gateway_deployment" "date" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_method.method_date.id,
      aws_lambda_permission.allow_api_date.id,
      aws_api_gateway_integration.lambda_date.id

    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.method_date,
      aws_lambda_permission.allow_api_date,
      aws_api_gateway_integration.lambda_date
  ]
}




