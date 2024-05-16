#key is mrk and also replicaed in us-west-2 region

kms_alias = "alias/iac_encryption_key_kms_mrk_key_replicated"
is_this_primary = true
delete_after_days = 8
key_description = "key_for_kms"
need_kms_replica = true
is_kms_replica = true
replica_region = "us-west-2"
key_policy_statements = {
  "statement1" = { 
    sid = "Enable IAM User Permissions",
    actions = ["kms:*"],
    resources = ["*"],
    effect = "Allow",
    principals =     {
          identifiers  = ["arn:aws:iam::928814396842:root"]
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
    effect = "Allow",
    principals =     {
        identifiers  = ["arn:aws:iam::928814396842:role/adfs-devops","arn:aws:iam::928814396842:role/adfs-governance"]
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
    effect = "Allow",
    principals =     {
          identifiers  = ["arn:aws:iam::928814396842:role/adfs-devops","arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka","arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"]
                  },
  }
}

replica_key_policy_statements = {
  "statement1" = { 
    sid = "Enable IAM User Permissions",
    actions = ["kms:*"],
    resources = ["*"],
    effect = "Allow",
    principals =     {
          identifiers  = ["arn:aws:iam::928814396842:root"]
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
    effect = "Allow",
    principals =     {
        identifiers  = ["arn:aws:iam::928814396842:role/adfs-devops","arn:aws:iam::928814396842:role/adfs-governance"]
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
    effect = "Allow",
    principals =     {
          identifiers  = ["arn:aws:iam::928814396842:role/adfs-devops","arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka","arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"]
                  },
  }
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