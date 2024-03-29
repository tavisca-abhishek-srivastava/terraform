resource "aws_db_instance" "read-only-replica" {
  count = var.number_of_read_replica
  instance_class       = var.db_instance_class
  
  parameter_group_name = var.rds_parameter_group_name
  option_group_name = var.rds_option_group_name
  skip_final_snapshot  = true
  availability_zone = var.az_for_read_replica[count.index]
  identifier  = "jpmc-ro-${count.index}"
  apply_immediately = true
  replicate_source_db  = aws_db_instance.rds_instance.identifier
  storage_encrypted = true
  kms_key_id = module.rds_storage_cmk.mrk_cms_arn
  max_allocated_storage = (var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
  tags = var.tags

}