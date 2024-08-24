
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_iam_role" "awsacademy-role" {
  name = "LabRole"
}

