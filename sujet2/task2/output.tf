output "api-arn"{
    value = aws_api_gateway_rest_api.api.execution_arn
}

output "lambda-hello-arn"{
    value = aws_lambda_function.hello_world.arn
}

output "lambda-message-arn"{
    value = aws_lambda_function.message.arn
}

output "lambda-date-arn"{
    value = aws_lambda_function.date.arn
}

output "api-endpoint-lambda-hello"{
    value = aws_api_gateway_stage.hello.invoke_url
}

output "api-endpoint-lambda-date"{
    value = "${aws_api_gateway_stage.hello.invoke_url}/date"
}

output "api-endpoint-lambda-message"{
    value = "https://www.worldskills-france.org/"
}