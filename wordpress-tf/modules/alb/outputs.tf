# DNS name of the ALB
output "alb_dns" {
  description = "DNS name of ALB"
  value       = aws_lb.alb.dns_name
}

# ARN of the ALB (handy for Route53 / WAF)
output "alb_arn" {
  description = "ARN of ALB"
  value       = aws_lb.alb.arn
}

# ARN of the target group
output "alb_target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.wp_tg.arn
}

