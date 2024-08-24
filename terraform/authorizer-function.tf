
#######################################################
## "Echo API" - Simple Lambda for testing the infra

data "archive_file" "authorizer-function-code" {
  type        = "zip"
  source_file = "../authenticator/src/authorizer-function.js"
  output_path = "authorizer-function_payload.zip"
}

resource "aws_lambda_function" "authorizer-function" {
  function_name = "authorizer-function"
  filename      = "authorizer-function_payload.zip"
  role          = data.aws_iam_role.awsacademy-role.arn
  handler       = "authorizer-function.handler"

  source_code_hash = data.archive_file.authorizer-function-code.output_base64sha256

  runtime = "nodejs20.x"

  environment {
    variables = {

    }
  }
}
