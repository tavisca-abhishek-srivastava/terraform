

module "kms-example-primary" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    is_this_primary = true
    deletion_window_in_days = var.deletion_window_in_days
    key_description   = var.key_description
    key_policy_statements = var.key_policy_statements
    tags = var.tags

}

module "kms-example-replica" {
    source = "../../../../modules/security/kms"
    is_kms_replica = true
    need_kms_replica = var.need_kms_replica
    kms_alias         = var.kms_alias
    deletion_window_in_days = var.deletion_window_in_days
    key_description   = var.key_description
    replica_key_policy_statements = var.replica_key_policy_statements
    tags = var.tags
    primary_key_arn = module.kms-example-primary.mrk_cms_arn[0]
    providers = {
      aws= aws.replica
     }
     
}