module "kms-example" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    key_policy_statements = var.key_policy_statements
    # key_policy_map    = var.key_policy_map
    need_kms_replica = var.need_kms_replica
    replica_region = var.replica_region
    replica_key_policy = var.replica_key_policy
    tags = var.tags
     
}