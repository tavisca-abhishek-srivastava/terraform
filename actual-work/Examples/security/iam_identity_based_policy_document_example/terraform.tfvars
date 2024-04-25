policy_name = "iam-iac-policy"
policy_description = "this is for testing iac common"


key_policy_statements = {
  "statement1" = { 
    sid = "1",
    actions = ["kms:*"],
    resources = ["*"],
    effect = "Allow",
   
    },
  "statement2" = {
    sid = "2",
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
    
    }, 
  "statement3" = {
    sid = "3",
    actions = [
           "kms:Encrypt",
           "kms:Decrypt",
           "kms:ReEncrypt*",
           "kms:GenerateDataKey*",
           "kms:DescribeKey"
         ],
    resources = ["*"],
    effect = "Allow",

  }
}

tags = {
  DataClassification : "restricted"
  Environment : "poc"
  AppName : "tf-iac-"
  InfraOwner : "sre-cloud-reliability@tavisca.com"
  BusinessUnit : "travel.app"
  Backup : "no"
  Product : "poap"
  Name : "tf-iac-kms-key-replicated"
}