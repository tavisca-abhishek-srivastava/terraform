module "kms-example" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    deletion_window_in_days = var.deletion_window_in_days
    key_description   = var.key_description
    key_policy_statements = var.key_policy_statements
    tags = var.tags
     
}