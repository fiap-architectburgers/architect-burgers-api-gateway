##########################################################
## API Gateway

resource "aws_apigatewayv2_api" "http-api" {
  name          = "http-api"
  protocol_type = "HTTP"
}

output "http-api-url" {
  value = aws_apigatewayv2_api.http-api.api_endpoint
}

## Authorization
resource "aws_apigatewayv2_authorizer" "cognito-authorizer" {
  api_id                            = aws_apigatewayv2_api.http-api.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = aws_lambda_function.authorizer-function.invoke_arn
  identity_sources = []
  name                              = "cognito-authorizer"
  enable_simple_responses           = true
  authorizer_payload_format_version = "2.0"
}

resource "aws_lambda_permission" "exec-authorizer-lambda-permission" {
  statement_id  = "AuthorizationFunctionAllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer-function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:us-east-1:${data.aws_caller_identity.current.account_id}:${aws_apigatewayv2_api.http-api.id}/authorizers/${aws_apigatewayv2_authorizer.cognito-authorizer.id}"
}


## API Deployment
resource "aws_apigatewayv2_stage" "http-api-test-stage" {
  api_id      = aws_apigatewayv2_api.http-api.id
  name        = "Test"
  auto_deploy = true
}

# resource "aws_apigatewayv2_deployment" "http-api-deployment" {
#   api_id      = aws_apigatewayv2_api.http-api.id
#   description = "Test Deployment"
#   depends_on = [aws_apigatewayv2_integration.http-echo-api-integration, aws_apigatewayv2_route.http-echo-api-route]
#
#   triggers = {
#     redeployment = sha1(join(",", tolist([
#       jsonencode(aws_apigatewayv2_integration.http-echo-api-integration),
#       jsonencode(aws_apigatewayv2_route.http-echo-api-route),
#     ])))
#   }
#
#   lifecycle {
#     create_before_destroy = true
#   }
# }
