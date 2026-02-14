# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.secure_subnet_ids

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Environment = var.environment
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-db"

  engine         = "mysql"
  engine_version = "8.0.40"
  instance_class = "db.t3.micro"

  db_name  = var.database_name
  username = var.database_username
  password = var.database_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  allocated_storage     = 20
  max_allocated_storage = 0
  storage_encrypted     = true
  storage_type          = "gp3"

  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  tags = {
    Name        = "${var.project_name}-rds"
    Environment = var.environment
  }
}
