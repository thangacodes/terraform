output "http_alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = "http://${aws_lb.app_lb.dns_name}"
}
output "https_alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = "https://${aws_lb.app_lb.dns_name}"
}
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.app_lb.arn
}

output "alb_zone_id" {
  description = "Hosted zone ID of the ALB (used for Route53 alias)"
  value       = aws_lb.app_lb.zone_id
}

output "tg-arn" {
  value = aws_lb_target_group.app_tg.arn
}
