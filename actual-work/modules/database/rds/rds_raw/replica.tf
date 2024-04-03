resource "aws_db_instance" "read-only-replica" {
  count = var.number_of_read_replica
    instance_class       = var.db_instance_class
    parameter_group_name = var.rds_parameter_group_name
    option_group_name = var.rds_option_group_name
    skip_final_snapshot  = true
    availability_zone = var.az_for_read_replica[count.index]
    identifier  = "jpmc-ro-${count.index}"
    replicate_source_db  = aws_db_instance.rds_instance.identifier
    storage_encrypted = true
    kms_key_id = module.rds_storage_cmk.mrk_cms_arn
    max_allocated_storage = (var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
    allow_major_version_upgrade = var.allow_major_version_upgrade
    apply_immediately 			= var.apply_immediately
    auto_minor_version_upgrade = var.auto_minor_version_upgrade
    backup_retention_period 	= var.backup_retention_period
    backup_window = var.backup_window
    monitoring_role_arn =var.monitoring_role_arn
    performance_insights_enabled = var.performance_insights_enabled
    performance_insights_kms_key_id = var.performance_insights_enabled == true? module.rds_storage_cmk.mrk_cms_arn:null
    performance_insights_retention_period = var.performance_insights_enabled == true? var.performance_insights_retention_period:null
    tags = var.tags

}