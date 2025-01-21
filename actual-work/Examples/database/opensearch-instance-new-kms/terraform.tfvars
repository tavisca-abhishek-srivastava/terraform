#### new opensearch ddomain using existing KMS
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


open_search_domain_name = "iac-os-en-new-kms-sg"
is_this_primary         = true
key_policy_statements = {
  "statement1" = {
    sid       = "Enable IAM User Permissions",
    actions   = ["kms:*"],
    resources = ["*"],
    effect    = "Allow",
    principals = {
      identifiers = ["arn:aws:iam::928814396842:root"]
    },
  },
  "statement2" = {
    sid = "Allow access for Key Administrators",
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ],
    resources = ["*"],
    effect    = "Allow",
    principals = {
      identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/adfs-governance"]
    },
  },
  "statement3" = {
    sid = "Allow use of the key",
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ],
    resources = ["*"],
    effect    = "Allow",
    principals = {
      identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka", "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"]
    },
  }
}
## security group
vpc_id = "vpc-07b12bcec12a4cd9b"
ingress_rules_sg1 = [
  {
    description      = "default rule"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/8"]
    source_sg_id     = ""
    self_referencing = false
  },
]

egress_rules_sg1 = [
  {
    description      = "default rule"
    from_port        = 0
    to_port          = 0
    protocol         = "ALL"
    cidr_blocks      = ["0.0.0.0/0"]
    source_sg_id     = ""
    self_referencing = false
  },
]



#### Opensearch variable values

opensearch_domains_config = {
  opensearch_domain_1_config = {
    open_search_domain_name               = "iac-os-en-new-kms-sg"
    open_search_engine_version            = "OpenSearch_2.3"
    dedicated_master_count                = 3
    dedicated_master_type                 = "m6g.large.search"
    dedicated_master_enabled              = true
    instance_type                         = "m6g.large.search"
    instance_count                        = 3
    zone_awareness_enabled                = true
    subnet_ids                            = ["subnet-01d4d19deaa34db85", "subnet-061e332b24aecd27b", "subnet-060048463710e54c4"]
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
    ebs_iops                              = 3000
    internal_user_database_enabled        = true
    ### kms 
    encrypt_at_rest_enabled = true
    is_this_primary         = true
    kms_delete_after_days   = 29
    key_policy_statements = {
      "statement1" = {
        sid       = "Enable IAM User Permissions",
        actions   = ["kms:*"],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:root"]
        },
      },
      "statement2" = {
        sid = "Allow access for Key Administrators",
        actions = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/adfs-governance"]
        },
      },
      "statement3" = {
        sid = "Allow use of the key",
        actions = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka", "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"]
        },
      }
    }
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
  }
  opensearch_domain_2_config = {
    open_search_domain_name               = "iac-os-en-new-kms-sg-2"
    open_search_engine_version            = "OpenSearch_2.3"
    dedicated_master_count                = 3
    dedicated_master_type                 = "m6g.large.search"
    dedicated_master_enabled              = true
    instance_type                         = "m6g.large.search"
    instance_count                        = 3
    zone_awareness_enabled                = true
    subnet_ids                            = ["subnet-01d4d19deaa34db85", "subnet-061e332b24aecd27b", "subnet-060048463710e54c4"]
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
    ebs_iops                              = 3000
    internal_user_database_enabled        = true
    ### kms 
    encrypt_at_rest_enabled = true
    is_this_primary         = true
    kms_delete_after_days   = 29
    key_policy_statements = {
      "statement1" = {
        sid       = "Enable IAM User Permissions",
        actions   = ["kms:*"],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:root"]
        },
      },
      "statement2" = {
        sid = "Allow access for Key Administrators",
        actions = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/adfs-governance"]
        },
      },
      "statement3" = {
        sid = "Allow use of the key",
        actions = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        resources = ["*"],
        effect    = "Allow",
        principals = {
          identifiers = ["arn:aws:iam::928814396842:role/adfs-devops", "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka", "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka"]
        },
      }
    }
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
  }
}


