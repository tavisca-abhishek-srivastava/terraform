table_hash_key = "user_id"
table_range_key = "product_id"
table_name = "DynamoDB-GSI-LSI"
table_class = "STANDARD"
enable_deletion_protection = false
table_read_capacity_unit = 200
table_write_capacity_unit = 500
table_autoscaling_min_read_capacity_unit = 900
table_autoscaling_max_read_capacity_unit = 3000
table_read_target_percent = 80
table_write_target_percent = 80
table_autoscaling_max_write_capacity_unit = 3000
table_autoscaling_min_write_capacity_unit = 500
ttl_enabled = true
attribute_for_ttl = "otpttl"
attributes = {
    "attr1" = { name = "user_id", type = "S" },
    "attr2" = { name = "product_id", type = "S" },
    "attr3" = { name = "product_name", type = "S" },
    "attr4" = { name = "product_desc", type = "S" },
    "attr5" = { name = "age", type = "N" },
  }
gsi_indices = {
    # in key-value pair, key will be GSI hash_key and same will be index name
    "product_name" = { write_capacity = 500, read_capacity = 200, range_key = "product_id" },
    "product_desc" = { write_capacity = 500, read_capacity = 200, range_key = "product_id" },
    "age"          = { write_capacity = 500, read_capacity = 200, range_key = "user_id" },
    "product_id" = { write_capacity = 500, read_capacity = 200, range_key = "user_id" },
  }
  lsi_indices = { 
   "by_age" = {range_key = "age"},
  }
  
  kms_alias = "alias/nrt_encryption_key"
  delete_after_days = 10
  key_description = "key_for_dynamoDB"
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
encryption_key_details = {
  key_type = "aws_managed"
}