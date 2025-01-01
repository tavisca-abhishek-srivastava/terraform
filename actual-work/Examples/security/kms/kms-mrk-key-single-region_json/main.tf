module "kms-example" {
    source = "../../../../modules/security/kms_policy_json"
    encryption_key_details = var.encryption_key_details
    kms_alias = var.kms_alias
    key_description = var.key_description
    delete_after_days = var.delete_after_days
    key_policy_map = var.key_policy_map
    kms_tags = var.kms_tags
   
}