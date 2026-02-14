output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
  sensitive = true
}

output "rds_address" {
  value = aws_db_instance.main.address
}

output "rds_port" {
  value = aws_db_instance.main.port
}

output "rds_database_name" {
  value = aws_db_instance.main.db_name
}
