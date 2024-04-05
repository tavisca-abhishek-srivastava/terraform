open_search_domain_name               = "iac-bnr-opensearch"
open_search_engine_version            = "OpenSearch_2.3"
dedicated_master_count                = 3
dedicated_master_type                 = "m6g.large.search"
dedicated_master_enabled              = true
instance_type                         = "m6g.large.search"
instance_count                        = 3
zone_awareness_enabled                = true
subnet_ids                            = ["subnet-01d4d19deaa34db85","subnet-061e332b24aecd27b","subnet-060048463710e54c4"]
security_options_enabled              = true
security_group_ids                    = ["sg-006dad075fbfed8e7"]
master_user_name                      = "opensearch_dbadmin"
master_user_password                  = "Welcome$123"
multi_az_with_standby_enabled         = true
encrypt_at_rest_enabled               = true
domain_endpoint_options_enforce_https = true
ebs_enabled                           = true
ebs_volume_size                       = 45
volume_type                           = "gp3"
throughput                            = 250
aws_region                            = "us-east-1"
ebs_iops = 3000
anonymous_auth_enabled = true
internal_user_database_enabled = true
kms_key = "arn:aws:kms:us-east-1:928814396842:key/0812992e-897f-41cc-b4e2-e1a2d1b3b672"
tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "opensearch-sr"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.poc"
  Backup : "no"
  Product : "poap"
  Name : "opensearch-sr-1"
}




