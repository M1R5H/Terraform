output "alb_dns_name" {
  value       = aws_lb.example02.dns_name
  description = "The domain name of the load balancer"
}