## Output of the resource that we provision

output "api_endpoint" {
  value = "http://${aws_instance.fastapi.public_ip}:8000/"
}

output "api_gateway_endpoint" {
  value = aws_apigatewayv2_api.fastapi_api.api_endpoint
}