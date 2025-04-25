data "aws_caller_identity" "current" {}

module "rds_encryption_at_rest_cmk" {
  	source            = "../../../../security/kms_policy_json"
  	kms_alias         = "alias/${var.rds_instance_name}_rds_key"
    delete_after_days = var.kms_delete_after_days
  	key_description   =  "Key for ${var.rds_instance_name} rds  instance "
  	key_policy_map = var.key_policy_map
	kms_tags = var.tags  
}