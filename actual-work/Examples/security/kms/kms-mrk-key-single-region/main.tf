module "kms-example" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    key_policy_statements = var.key_policy_statements
    tags = var.tags
     
}