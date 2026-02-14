output "asg_id" {
  description = "Auto Scaling Group ID"
  value       = aws_autoscaling_group.main.id
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.main.arn
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.main.id
}

output "asg_desired_capacity" {
  description = "Auto Scaling Group desired capacity"
  value       = aws_autoscaling_group.main.desired_capacity
}
