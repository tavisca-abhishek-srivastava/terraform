data "aws_caller_identity" "current" {}

module "rds_encryption_at_rest_cmk" {
  	source            = "../../../security/kms_policy_json_mrk_replicated"
  	kms_alias         = "alias/${var.cluster_identifier}_aurora_key"
    #deletion_window_in_days = var.deletion_window_in_days
	deletion_window_in_days = var.deletion_window_in_days
  	key_description   =  "Key for ${var.cluster_identifier} aurora cluster "
  	key_policy_map = var.key_policy_map
	key_primary_region = var.key_primary_region
	is_this_primary = var.is_this_primary
	is_kms_replica = var.is_kms_replica
	need_kms_replica = var.need_kms_replica

	tags = var.tags 
}
output "kms" {
  value = module.rds_encryption_at_rest_cmk
}