open_search_domain_name               = "iacbnropensearch"
open_search_engine_version            = "OpenSearch_2.11"
dedicated_master_count                = 3
dedicated_master_type                 = "m6g.large.search"
dedicated_master_enabled              = true
instance_type                         = "m6g.large.search"
instance_count                        = 3
zone_awareness_enabled                = true
subnet_ids                            = ["subnet-01d4d19deaa34db85","subnet-061e332b24aecd27b","subnet-060048463710e54c4"]
security_options_enabled              = true
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
internal_user_database_enabled = true
### kms 
kms_delete_after_days = 30
key_policy_map = {
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::928814396842:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/adfs-governance"
          ]
        },
        "Action" : [
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
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka"
            
          ]
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka"
           
          ]
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  }

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



