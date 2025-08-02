data "aws_caller_identity" "current" {}

module "rds_encryption_at_rest_cmk" {
  	source            = "../../../security/kms_policy_json"
  	kms_alias         = "alias/${var.cluster_identifier}_aurora_mysql_key"
    delete_after_days = var.kms_delete_after_days
  	key_description   =  "Key for ${var.cluster_identifier} aurora mysql cluster "
  	key_policy_map = var.key_policy_map
	kms_tags = var.tags  
}