# Set in deploy time according to the previously created aws resources

variable "http_api_id" {
  type = string
  description = "API Gateway Http-API"
}

variable "cognito_user_pool_client_id" {
  type = string
}

variable "cognito_user_pool_client_secret" {
  type = string
}

# export TF_VAR_load_balancer_listener_arn="....."
variable "load_balancer_listener_arn" {
  type = string
  description = "ARN of the load balancer listener (8090) created for the EKS cluster"
}