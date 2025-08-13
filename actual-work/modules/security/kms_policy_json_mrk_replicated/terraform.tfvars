#key is mrk and also replicaed in us-west-2 region

kms_alias = "alias/iac_encryption_key_kms_mrk_key_replicated_nrt"
is_this_primary = true
deletion_window_in_days = 8
key_description = "key_for_kms_nrt"
need_kms_replica = true
is_kms_replica = true
replica_region = "us-west-2"
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


tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-iac-kms-key-replicated"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-iac-kms-key-replicated"
}