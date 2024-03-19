resource "aws_db_instance" "read-only-cross-region" {
  allocated_storage    = var.allocated_storage
  instance_class       = var.db_instance_class

  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone = "us-east-1b"
  identifier  = "jpmc-ro"
  apply_immediately = true
  replicate_source_db  = aws_db_instance.rds_instance.arn
  #db_subnet_group_name = "default"
  
  	tags = var.tags

}