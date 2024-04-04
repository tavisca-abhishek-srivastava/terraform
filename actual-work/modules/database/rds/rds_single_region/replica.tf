resource "random_string" "ro-replica_name_postfix" {
  length = local.random_string_ro_replica_name_postfix_length
  special = local.random_string_ro_replica_name_postfix_special
  numeric = local.random_string_ro_replica_name_postfix_numeric
  upper = local.random_string_ro_replica_name_postfix_upper
  lower = local.random_string_ro_replica_name_postfix_lower
}

resource "aws_db_instance" "read-only-replica" {
  count = var.number_of_read_replica
    instance_class       = var.db_instance_class
    parameter_group_name = var.rds_parameter_group_name
    option_group_name = var.use_default_option_group == true ? (var.rds_option_group_name) : module.rds_option_group["1"].option_group_name_output
    skip_final_snapshot  = var.skip_final_snapshot
    availability_zone = var.az_for_read_replica[count.index]
    identifier  = "jpmc-ro-${random_string.ro-replica_name_postfix.result}-${count.index}"
    ## if read only replica will be promoted then they will have multi-az setup enabled
    multi_az =  var.promoto_read_replica == false ? false:var.multi_az
    ## to promote ro replica, set variable "promoto_read_replica" to true
    replicate_source_db  = var.promoto_read_replica == false ? aws_db_instance.rds_instance.identifier : null
    storage_encrypted = local.enable_storage_encryption
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