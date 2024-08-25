data "aws_vpc" "app-vpc" {
  cidr_block = "10.0.0.0/16"
}

data "aws_subnet" "app-subnet-1" {
  cidr_block = "10.0.1.0/24"
}
data "aws_subnet" "app-subnet-2" {
  cidr_block = "10.0.2.0/24"
}
data "aws_subnet" "app-subnet-3" {
  cidr_block = "10.0.3.0/24"
}


###
resource "aws_security_group" "allow_app_port" {
  name        = "allow_app_port"
  description = "Allow Traffic to and from port 8090"
  vpc_id      = data.aws_vpc.app-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_app_port_ingress" {
  security_group_id = aws_security_group.allow_app_port.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_app_port_egress" {
  security_group_id = aws_security_group.allow_app_port.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}


resource "aws_apigatewayv2_vpc_link" "app-vpc-link" {
  name = "app-vpc-link"
  security_group_ids = [aws_security_group.allow_app_port.id]
  subnet_ids = [data.aws_subnet.app-subnet-1.id, data.aws_subnet.app-subnet-2.id, data.aws_subnet.app-subnet-3.id]
}


resource "aws_apigatewayv2_integration" "app-gateway-integration" {
  api_id           = aws_apigatewayv2_api.http-api.id
  credentials_arn     = data.aws_iam_role.awsacademy-role.arn
  description         = "App Proxy Integration"

  integration_type    = "HTTP_PROXY"

  # TODO Get Listener ARN
  integration_uri = "arn:aws:elasticloadbalancing:us-east-1:645363387166:listener/net/a8dd23be0205d4682821f300f8012b71/943e5f548ed3d787/086ec59a2724b591"
  integration_method = "ANY"

  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.app-vpc-link.id

  request_parameters = {
    "overwrite:path" = "$request.path"
  }
}

resource "aws_apigatewayv2_route" "http-default-route" {
  api_id    = aws_apigatewayv2_api.http-api.id
  route_key = "$default"

  authorization_type = "CUSTOM"
  authorizer_id = aws_apigatewayv2_authorizer.cognito-authorizer.id

  target = "integrations/${aws_apigatewayv2_integration.app-gateway-integration.id}"
}

