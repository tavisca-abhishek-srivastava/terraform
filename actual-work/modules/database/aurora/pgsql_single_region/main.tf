resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "nrt-compliance-pgsql-cluster"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "mydb"
  master_username         = "dbadmin"
  master_password         = "Welcome$1234"
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  tags = var.tags

}