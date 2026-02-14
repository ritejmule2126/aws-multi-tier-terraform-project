output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "database_endpoint" {
  description = "Database endpoint"
  value       = module.rds.rds_endpoint
  sensitive   = true
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.asg.asg_name  # Now this exists!
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${module.alb.alb_dns_name}"
}
