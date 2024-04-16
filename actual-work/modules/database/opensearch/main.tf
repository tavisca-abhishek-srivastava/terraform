data "aws_caller_identity" "current" {}

module "opensearch_encryption_at_rest_cmk" {
  	source            = "../../security/kms"
  	kms_alias         = "alias/${var.open_search_domain_name}_key"
  	delete_after_days = var.kms_delete_after_days
  	key_description   =  "Key for ${var.open_search_domain_name} opensearch domain "
  	key_policy_map    = var.key_policy_map
	  kms_tags = var.tags
}

module "opensearch_security_group" {
    source            = "../../networking/security_group"
    vpc_id = var.vpc_id
    name = "${var.open_search_domain_name}_sg"
    description = "Security Group for ${var.open_search_domain_name} opensearch domain "
    egress_rules = var.egress_rules_sg1
    ingress_rules = var.ingress_rules_sg1
}

resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.open_search_domain_name
  engine_version = var.open_search_engine_version
  

  cluster_config {
    dedicated_master_count   = var.dedicated_master_count
    multi_az_with_standby_enabled = var.multi_az_with_standby_enabled
    dedicated_master_type    = var.dedicated_master_type
    dedicated_master_enabled = var.dedicated_master_enabled
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    zone_awareness_enabled   = var.zone_awareness_enabled
    zone_awareness_config {
      availability_zone_count = var.zone_awareness_enabled ? length(var.subnet_ids) : null
    }
  }

  advanced_security_options {
    enabled                        = var.security_options_enabled
    anonymous_auth_enabled         = false
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  encrypt_at_rest {
    enabled = var.encrypt_at_rest_enabled
    kms_key_id = module.opensearch_encryption_at_rest_cmk.mrk_cms_arn
  }

  domain_endpoint_options {
    enforce_https       = var.domain_endpoint_options_enforce_https
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
    throughput  = var.throughput
    iops = var.ebs_iops
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids = var.subnet_ids

    security_group_ids = [module.opensearch_security_group.security_group_id]
  }

tags = var.tags

access_policies = data.aws_iam_policy_document.opensearch_access_policy.json


log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_index_slow_logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
    enabled = true
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_search_slow_logs.arn
    log_type                 = "SEARCH_SLOW_LOGS"
    enabled = true
  }
  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group_es_application_logs.arn
    log_type                 = "ES_APPLICATION_LOGS"
    enabled = true
  }



}

