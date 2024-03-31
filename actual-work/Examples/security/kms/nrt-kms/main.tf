module "nrt-dax" {
    source = "../../../../modules/security/kms"
    kms_alias         = var.kms_alias
    delete_after_days = var.delete_after_days
    key_description   = var.key_description
    key_policy_map    = var.key_policy_map
    replica_region = var.replica_region
    need_kms_replica = var.need_kms_replica
    kms_tags = var.kms_tags
    replica_key_policy = var.replica_key_policy
    
}