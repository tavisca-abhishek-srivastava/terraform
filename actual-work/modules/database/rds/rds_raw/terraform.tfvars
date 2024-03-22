rds_instance_name = "jpmc-master"
db_name = "mysql_db"
allocated_storage = 100
storage_type = "io1"
db_instance_class = "db.t3.micro"
rds_engine = "mysql"
rds_engine_version = "5.7"
enable_storage_autoscaling = true
max_allocated_storage = 601
storage_iops = 1021
backup_retention_period = 1
port = 3306
multi_az = true

#### for read only replica
number_of_read_replica = 3
az_for_read_replica = ["us-east-1b","us-east-1c","us-east-1a"]

tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-1"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-1"
}
#### for option group of RDS
use_default_option_group = false
rds_option_group_name = "nrt-rds-mysql-app"
option_group_engine_name = "mysql"
option_group_major_engine_version = "8.0"
option_group_description = "This is for NRT RDS"
option_settings = {
  "setting1" = {
    option_name           = "MEMCACHED"
    option_settings_name  = "BACKLOG_QUEUE_LIMIT"
    option_settings_value = "1025"
    vpc_security_group_memberships = ["sg-006dad075fbfed8e7"]
    port = 11211
  },
  "setting2" = {
    option_name           = "MARIADB_AUDIT_PLUGIN"
    option_settings_name  = "SERVER_AUDIT_QUERY_LOG_LIMIT"
    option_settings_value = "1025"
    vpc_security_group_memberships = null
    port = null
  },
}

############### KMS input
kms_alias = "alias/nrt_rds_encryption_key"
delete_after_days = 10
key_description = "key_for_rds_encryption"
kms_tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-kms"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-kms"
  }
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
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka",
            "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"
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
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka",
            "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"
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
