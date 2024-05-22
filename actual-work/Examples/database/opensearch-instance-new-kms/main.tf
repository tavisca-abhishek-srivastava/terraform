##### new KMS and new security group ###########

module "opensearch_encryption_at_rest_cmk" {
  source                = "../../../modules/security/kms"
  kms_alias             = "alias/${var.open_search_domain_name}_key"
  is_this_primary = var.is_this_primary
  delete_after_days     = var.kms_delete_after_days
  key_description       = "Key for ${var.open_search_domain_name} opensearch domain "
  key_policy_statements = var.key_policy_statements
  tags                  = var.tags
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
  source                   = "../../../modules/database/opensearch-import-multiple"
  open_search_domain_name =  var.open_search_domain_name
  open_search_engine_version = var.open_search_engine_version
  dedicated_master_count = var.dedicated_master_count
  dedicated_master_type = var.dedicated_master_type
  dedicated_master_enabled = var.dedicated_master_enabled
  instance_type = var.instance_type
  subnet_ids = var.subnet_ids
  aws_region = var.aws_region
  domain_endpoint_options_enforce_https = var.domain_endpoint_options_enforce_https
  master_user_name = var.master_user_name
  master_user_password = var.master_user_password
  throughput = var.throughput
  instance_count = var.instance_count
  zone_awareness_enabled = var.zone_awareness_enabled
  multi_az_with_standby_enabled = var.multi_az_with_standby_enabled
  advanced_security_options_enabled = var.advanced_security_options_enabled
  ebs_enabled = var.ebs_enabled
  ebs_volume_size = var.ebs_volume_size
  volume_type = var.volume_type
  ebs_iops = var.ebs_iops
  internal_user_database_enabled = var.internal_user_database_enabled
  tags = var.tags
  encrypt_at_rest_enabled = var.encrypt_at_rest_enabled
  kms_key_id = module.opensearch_encryption_at_rest_cmk.mrk_cms_arn[1]
  security_group_ids = [module.opensearch_security_group.security_group_id]
}