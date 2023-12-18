provider "aws" {
region="us-east-1"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 11
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone = "us-east-1a"
  identifier  = "jpmc"
  apply_immediately = true
  backup_retention_period = 1
}

output "arn" {
value = aws_db_instance.default.arn
description = "ARN of DB"
 }
