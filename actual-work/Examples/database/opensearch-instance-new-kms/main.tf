##### new KMS and new security group ###########

module "opensearch_encryption_at_rest_cmk" {
  for_each = var.opensearch_domains_config
    source                = "../../../modules/security/kms"
    kms_alias             = "alias/${each.value.open_search_domain_name}_key"
    # is_this_primary       = var.is_this_primary
    is_this_primary       = each.value.is_this_primary
    delete_after_days     = each.value.kms_delete_after_days
    key_description       = "Key for ${each.value.open_search_domain_name} opensearch domain "
    key_policy_statements = each.value.key_policy_statements
    tags                  = each.value.tags
}

module "opensearch_security_group" {
  source        = "../../../modules/networking/security_group"
  vpc_id        = var.vpc_id
  name          = "${var.open_search_domain_name}_sg"
  description   = "Security Group for ${var.open_search_domain_name} opensearch domain "
  egress_rules  = var.egress_rules_sg1
  ingress_rules = var.ingress_rules_sg1
}

module "opensearch" {
  for_each = var.opensearch_domains_config
    source                   = "../../../modules/database/opensearch-import-multiple"
    open_search_domain_name =  each.value.open_search_domain_name
    open_search_engine_version = each.value.open_search_engine_version
    dedicated_master_count = each.value.dedicated_master_count
    dedicated_master_type = each.value.dedicated_master_type
    dedicated_master_enabled = each.value.dedicated_master_enabled
    instance_type = each.value.instance_type
    subnet_ids = each.value.subnet_ids
    aws_region = var.aws_region
    domain_endpoint_options_enforce_https = each.value.domain_endpoint_options_enforce_https
    master_user_name = each.value.master_user_name
    master_user_password = each.value.master_user_password
    throughput = each.value.throughput
    instance_count = each.value.instance_count
    zone_awareness_enabled = each.value.zone_awareness_enabled
    multi_az_with_standby_enabled = each.value.multi_az_with_standby_enabled
    advanced_security_options_enabled = each.value.advanced_security_options_enabled
    ebs_enabled = each.value.ebs_enabled
    ebs_volume_size = each.value.ebs_volume_size
    volume_type = each.value.volume_type
    ebs_iops = each.value.ebs_iops
    internal_user_database_enabled = each.value.internal_user_database_enabled
    tags = var.tags
    encrypt_at_rest_enabled = each.value.encrypt_at_rest_enabled
    kms_key_id = module.opensearch_encryption_at_rest_cmk[each.key].mrk_cms_arn[0]
    security_group_ids = [module.opensearch_security_group.security_group_id]
}