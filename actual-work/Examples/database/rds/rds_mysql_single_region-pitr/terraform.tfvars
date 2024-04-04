rds_instance_name = "jpmc-master-mysql-sr-example"   # single region
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
user_name = "dbadmin"
password = "welcome$123"
skip_final_snapshot = true
vpc_security_group_ids = ["sg-006dad075fbfed8e7"]
apply_immediately = true
### pitr section
restore_2_pitr = false
pitr_source_db_instance_identifier = "jpmc-master-mysql"
use_latest_restorable_time = true
#### for read only replica
number_of_read_replica = 2
az_for_read_replica = ["us-east-1b","us-east-1c"]
promoto_read_replica = false
tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-sr"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-sr-1"
}
#### for option group of RDS
use_default_option_group = false
rds_option_group_name = "nrt-rds-mysql-app-sr"
option_group_major_engine_version = "5.7"
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
#### for parameter group of RDS
use_default_parameter_group = false
rds_parameter_group_name = "nrt-rds-mysql-app-sr"
parameter_group_db_family = "mysql5.7"
parameter_group_description = "this is for NRT RDS"
parameter_value = {
  setting1 = {
    name = "character_set_server"
    value = "utf8"},
  setting2 = {
    name = "character_set_server"
    value = "utf8"},
  setting3 = {
    name = "autocommit"
    value = 1},
  setting4 = {
    name = "log_queries_not_using_indexes"
    value = 1},
}
### for subnet group 
use_default_subnet_group = false
rds_subnet_group_name = "nrt-rds-subnet-group-sr"
subnet_group_subnet_ids = ["subnet-01d4d19deaa34db85","subnet-061e332b24aecd27b","subnet-060048463710e54c4"]
############### KMS input
kms_alias = "alias/nrt_rds_encryption_key-sr"
kms_delete_after_days = 10
kms_key_description = "key for rds encryption in single region"
kms_tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-nrt-nrt-iac-rds-kms-sr"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-nrt-iac-rds-kms-sr"
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
