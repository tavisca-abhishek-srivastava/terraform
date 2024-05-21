#### new opensearch ddomain using existing KMS


open_search_domain_name               = "iacbnropensearch-enhanced-existing-kms"
open_search_engine_version            = "OpenSearch_2.3"
dedicated_master_count                = 3
dedicated_master_type                 = "m6g.large.search"
dedicated_master_enabled              = true
instance_type                         = "m6g.large.search"
instance_count                        = 3
zone_awareness_enabled                = true
subnet_ids                            = ["subnet-01d4d19deaa34db85","subnet-061e332b24aecd27b","subnet-060048463710e54c4"]
advanced_security_options_enabled     = true
master_user_name                      = "opensearch_dbadmin"
master_user_password                  = "Welcome$123"
multi_az_with_standby_enabled         = true
domain_endpoint_options_enforce_https = true
ebs_enabled                           = true
ebs_volume_size                       = 46
volume_type                           = "gp3"
throughput                            = 252
aws_region                            = "us-east-1"
ebs_iops = 3000
internal_user_database_enabled = true
### kms 
encrypt_at_rest_enabled = true
kms_key_id = "arn:aws:kms:us-east-1:928814396842:key/mrk-486137a92c2543ec97ce88f8a068534f"
## security group
vpc_id = "vpc-07b12bcec12a4cd9b"
ingress_rules_sg1 = [
    {
      description    = "default rule"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      source_sg_id    = ""
      self_referencing = false
    },
  ]

egress_rules_sg1 = [
    {
      description    = "default rule"
      from_port       = 0
      to_port         = 0
      protocol        = "ALL"
      cidr_blocks     = ["0.0.0.0/0"]
      source_sg_id    = ""
      self_referencing = false
    },
  ]
tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "opensearch-sr"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.poc"
  Backup : "no"
  Product : "poap"
  Name : "opensearchsr"
}



