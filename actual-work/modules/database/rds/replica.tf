resource "aws_db_instance" "read-only-cross-region" {
  count = 2
  #allocated_storage    = var.allocated_storage
  instance_class       = var.db_instance_class

  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone = "us-east-1b"
  identifier  = "jpmc-ro-${count.index}"
  apply_immediately = true
  replicate_source_db  = aws_db_instance.rds_instance.identifier
  storage_encrypted = true
  kms_key_id = module.rds_storage_cmk.mrk_cms_arn
  #db_subnet_group_name = "default"
  
  	tags = var.tags

}