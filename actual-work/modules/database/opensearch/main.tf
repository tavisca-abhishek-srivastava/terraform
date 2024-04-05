data "aws_caller_identity" "current" {}

resource "random_password" "password" {
  length  = 32
  special = true
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
    anonymous_auth_enabled         = true
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  encrypt_at_rest {
    enabled = var.encrypt_at_rest_enabled
    kms_key_id = var.kms_key
  }

#   domain_endpoint_options {
#     enforce_https       = var.domain_endpoint_options_enforce_https
#     tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
#   }

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
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    security_group_ids = var.security_group_ids
  }


  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.open_search_domain_name}/*"
        }
    ]
}
CONFIG
}