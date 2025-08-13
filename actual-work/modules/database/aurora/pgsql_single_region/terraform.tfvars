cluster_identifier  = "nrt-compliance-pgsql-cluster"
kms_delete_after_days = 30

tags = {
    "AppName"            = "nrt-compliance-pgsql-cluster"
    "Backup"             = "yes"
    "BusinessUnit"       = "travel.app"
    "DataClassification" = "internal"
    "Environment"        = "qa"
    "InfraOwner"         = "sre-cloud-reliability@tavisca.com"
    "Name"               = "nrt-compliance-pgsql-cluster"
    "Product"            = "poap"
  }
  instance_role = {
    writer = {
      name = "writer",
      az = "us-east-1a",
      promotion_tier = 0
    },
    reader = {
        name = "reader-1",
        az = "us-east-1b",
        promotion_tier = 1

    },
        reader1 = {
        name = "reader-2",
        az = "us-east-1c",
        promotion_tier = 2

    }
  }
allocated_storage = 30
storage_type = "gp3"
storage_iops = 1000
backup_retention_period = 1
aws_region = "us-east-1"
rds_parameter_group_name = "nrt-compliance-pgsql-cluster-pg"
parameter_group_db_family = "aurora-postgresql16"
parameter_group_description = "this is for nrt-compliance-pgsql-cluster"
parameter_value = {
  setting1 = {
    name = "log_min_duration_statement"
    value = 500},
  
}
key_policy_map = {
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::346319152574:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" :  {
        "Service": "rds.amazonaws.com"
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
    ]
  }