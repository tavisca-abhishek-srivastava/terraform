module "nrt-dax" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    key_policy_map    = var.key_policy_map
    kms_tags = var.kms_tags
    
}