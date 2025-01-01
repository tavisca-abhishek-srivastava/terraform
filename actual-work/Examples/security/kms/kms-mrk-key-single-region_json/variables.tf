variable "key_primary_region" {
  default = "us-east-1"
}

variable "kms_alias" {
  description = "define in the form of 'alias/unique_key_name'"
  type    = string
}

variable "delete_after_days" {
  description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
  type    = number
  default = 30
}
variable "key_description" {
  description = "The description of the key as visible in AWS console"
  type    = string
}
variable "kms_tags" {
  type = object({
    DataClassification = string
    Environment        = string
    AppName            = string
    InfraOwner         = string
    BusinessUnit       = string
    Backup             = string
    Product            = string
    Name               = string
  })
}
variable "key_policy_map" {
  description = "A valid policy JSON document"
  type = any
  # default = {
  #   "Id" : "key-consolepolicy-3",
  #   "Version" : "2012-10-17",
  #   "Statement" : [
  #     {
  #       "Sid" : "Enable IAM User Permissions",
  #       "Effect" : "Allow",
  #       "Principal" : {
  #         "AWS" : "arn:aws:iam::928814396842:root"
  #       },
  #       "Action" : "kms:*",
  #       "Resource" : "*"
  #     },
  #     {
  #       "Sid" : "Allow access for Key Administrators",
  #       "Effect" : "Allow",
  #       "Principal" : {
  #         "AWS" : [
  #           "arn:aws:iam::928814396842:role/adfs-devops",
  #           "arn:aws:iam::928814396842:role/adfs-governance"
  #         ]
  #       },
  #       "Action" : [
  #         "kms:Create*",
  #         "kms:Describe*",
  #         "kms:Enable*",
  #         "kms:List*",
  #         "kms:Put*",
  #         "kms:Update*",
  #         "kms:Revoke*",
  #         "kms:Disable*",
  #         "kms:Get*",
  #         "kms:Delete*",
  #         "kms:TagResource",
  #         "kms:UntagResource",
  #         "kms:ScheduleKeyDeletion",
  #         "kms:CancelKeyDeletion"
  #       ],
  #       "Resource" : "*"
  #     },
  #     {
  #       "Sid" : "Allow use of the key",
  #       "Effect" : "Allow",
  #       "Principal" : {
  #         "AWS" : [
  #           "arn:aws:iam::928814396842:role/adfs-devops",
  #           "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka",
  #           "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"
  #         ]
  #       },
  #       "Action" : [
  #         "kms:Encrypt",
  #         "kms:Decrypt",
  #         "kms:ReEncrypt*",
  #         "kms:GenerateDataKey*",
  #         "kms:DescribeKey"
  #       ],
  #       "Resource" : "*"
  #     },
  #     {
  #       "Sid" : "Allow attachment of persistent resources",
  #       "Effect" : "Allow",
  #       "Principal" : {
  #         "AWS" : [
  #           "arn:aws:iam::928814396842:role/adfs-devops",
  #           "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka",
  #           "arn:aws:iam::928814396842:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_Travel-NonProd-DevOps_58cf51ef9bc19c74"
  #         ]
  #       },
  #       "Action" : [
  #         "kms:CreateGrant",
  #         "kms:ListGrants",
  #         "kms:RevokeGrant"
  #       ],
  #       "Resource" : "*",
  #       "Condition" : {
  #         "Bool" : {
  #           "kms:GrantIsForAWSResource" : "true"
  #         }
  #       }
  #     }
  #   ]
  # }
}