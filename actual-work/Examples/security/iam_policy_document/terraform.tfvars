policy_name = "iam-iac-policy"
policy_description = "this is for testing iac"


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

