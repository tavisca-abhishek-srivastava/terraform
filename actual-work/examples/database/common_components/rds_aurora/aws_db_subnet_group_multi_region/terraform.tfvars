cluster_identifier  = "nrt-compliance-pgsql-cluster"

tags = {
    "AppName"            = "nrt-compliance-pgsql-cluster-nv"
    "Backup"             = "yes"
    "BusinessUnit"       = "travel.app"
    "DataClassification" = "internal"
    "Environment"        = "qa"
    "InfraOwner"         = "sre-cloud-reliability@tavisca.com"
    "Name"               = "nrt-compliance-pgsql-cluster-nv"
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
  instance_role_or = {
    writer = {
      name = "writer",
      az = "us-west-2a",
      promotion_tier = 0
    },
    reader = {
        name = "reader-1",
        az = "us-west-2b",
        promotion_tier = 1

    },
        reader1 = {
        name = "reader-2",
        az = "us-west-2c",
        promotion_tier = 2

    }
  }
backup_retention_period = 1
aws_region = "us-east-1"
rds_parameter_group_name = "nrt-compliance-pgsql-cluster-pg-nv"
replica_region = "us-west-2"
primary_region = "us-east-1"
parameter_group_db_family = "aurora-postgresql16"
parameter_group_description = "this is for nrt-compliance-pgsql-cluster-nv"
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

  #key is mrk and also replicaed in us-west-2 region

key_primary_region = "us-east-1"
kms_alias = "nrt-compliance-pgsql-global-cluster"
is_this_primary = true
deletion_window_in_days = 8
key_description = "key for kms nrt nv"
is_kms_replica = true
need_kms_replica = true

### subnet group

use_default_subnet_group = false
rds_subnet_group_name = "dummy"
subnet_group_subnet_ids = ["subnet-081d38d112d9b87db","subnet-0a270dcfe55895f61","subnet-0a7393d9a81b5dd51"]
subnet_group_subnet_ids_or = ["subnet-0c1dac091a3c3129a","subnet-050b02e5f412e6ac4","subnet-027b75ea35a74119a"]
