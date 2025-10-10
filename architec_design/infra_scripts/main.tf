## Creating an EC2 instance with FastAPI installed using user_data

resource "aws_instance" "fastapi" {
  ami                    = var.image_id
  instance_type          = var.vm_spce
  vpc_security_group_ids = var.sgp
  key_name               = var.keyname
  user_data              = file("init_script.sh")
  tags = {
    Name         = "Python-fastapi-deployment"
    CreationDate = "10/10/2025"
    TF_version   = "v1.13.3"
  }
}

## Create a HTTP API in API Gateway

resource "aws_apigatewayv2_api" "fastapi_api" {
  name          = "FastAPIProxy"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "fastapi_integration" {
  api_id           = aws_apigatewayv2_api.fastapi_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "http://${aws_instance.fastapi.public_ip}:8000/"
  integration_method = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.fastapi_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.fastapi_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.fastapi_api.id
  name        = "$default"
  auto_deploy = true
}
