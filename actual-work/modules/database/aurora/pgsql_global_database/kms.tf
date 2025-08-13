data "aws_caller_identity" "current" {}

module "rds_encryption_at_rest_cmk" {
  	source            = "../../../security/kms_policy_json_mrk_replicated"
  	kms_alias         = "alias/${var.cluster_identifier}_aurora_key"
    deletion_window_in_days = var.deletion_window_in_days
  	key_description   =  "Key for ${var.cluster_identifier} aurora cluster "
  	key_policy_map = var.key_policy_map
	tags = var.tags  
}