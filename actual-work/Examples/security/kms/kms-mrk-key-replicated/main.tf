

module "kms-example-primary" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    key_policy_statements = var.key_policy_statements
    need_kms_replica = var.need_kms_replica
    # replica_region = var.replica_region
    replica_key_policy_statements = var.replica_key_policy_statements
    tags = var.tags
    providers = {
      aws= aws.primary
     }
     
}

module "kms-example-replica" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    # replica_region = var.replica_region
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    replica_key_policy_statements = var.replica_key_policy_statements
    tags = var.tags
    primary_key_arn = module.kms-example-primary.mrk_cms_arn
    providers = {
      aws= aws.replica
     }
     
}