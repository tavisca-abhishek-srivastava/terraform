provider "aws" {
region= var.region_for_cross_region_read_replica
alias = "dr"
}

data "aws_kms_key" "cmk_forrds" {
   key_id = "${var.kms_alias}"
   provider = aws.dr
}

resource "aws_db_instance" "cross_region_read-only-replica" {
  count = var.number_of_cross_region_read_replica
  instance_class       = var.db_instance_class
  
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = var.db_subnet_group
  skip_final_snapshot  = true
  availability_zone = var.az_for_cross_region_read_replica[count.index]
  identifier  = "jpmc-ro-${var.region_for_cross_region_read_replica}-${count.index}"
  apply_immediately = true
  replicate_source_db  = aws_db_instance.rds_instance.arn
  storage_encrypted = true
  kms_key_id = data.aws_kms_key.cmk_forrds.arn
  max_allocated_storage = (var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
  tags = var.tags
  provider = aws.dr

}