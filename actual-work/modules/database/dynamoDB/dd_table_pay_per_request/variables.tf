######################################################################################
# Optional variable and value is set to default

variable "is_stream_enabled" {
  description = "This field is to enable dyanmoDB streaming. run terrform apply 2 times incase of import from table is true"
  type        = bool
  default     = false
}
variable "stream_view_type" {
  description = "This determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
  type    = string
  default = "NEW_IMAGE"  
}
variable "ttl_enabled" {
  description = "Whether TTL is enabled Valid values 'true' or 'false'"
  type    = bool
  default = false  
}
variable "attribute_for_ttl" {
  description = "Name of the table attribute to store the TTL timestamp in"
  type    = string
  default = "timetolive"
    validation {
    condition     = length(var.attribute_for_ttl) > 1 && length(var.attribute_for_ttl) < 255
    error_message = "ttl attribute name must be between 1 and 255 characters"
  }
}

###########################################################################################
# Mandatory variables
variable "table_hash_key" {
  description = "This will be hash key for dynamoDB table"
  type        = string
  validation {
    condition     = lower(var.table_hash_key) == var.table_hash_key && length(var.table_hash_key) != 0
    error_message = "table_hash_key should be in lower case and should be defined"
  }
}

variable "table_range_key" {
  description = "This will be range key for dynamoDB table"
  type        = string
  validation {
    condition     = lower(var.table_range_key) == var.table_range_key && length(var.table_range_key) != 0
    error_message = "table_range_key should be in lower case and should be defined"
  }
}

variable "attributes" {
  description = "These will be attributes for dynamoDB table including hash and range key"
  type = map(object({
    name = string
    type = string
  }))
  validation {
    condition     = length(var.attributes) > 0
    error_message = "Attribute should have hash key and range key at minimum"
  }
}
variable "gsi_indices" {
  description = "Map of GSI Index/s in key-value pair, key will be GSI index name"
  type = map(object({
    write_capacity = number
    read_capacity  = number
    range_key      = string
    hash_key       = string

  }))
  default = {}  ## change1
}

variable "lsi_indices" {
  description = "Map of LSI Index in key-value pair, key will be LSI index name"
  type = map(object({
    range_key = string

  }))
}

variable "enable_deletion_protection" {
  description = "Enables deletion protection for table. it must be true for all tables"
  type = bool
  default = true
  validation {
    condition     = var.enable_deletion_protection == false || var.enable_deletion_protection == true
    error_message = "enable_deletion_protection should be either true or false"
  }
}
variable "table_name" {
  description = "Name of DynamoDB table unique in account"
  type = string
  validation {
    condition     = length(var.table_name) != 0
    error_message = "table_name should not be empty"
  }
}
variable "table_class" {
  description = "Storage class of the table. Valid values are 'STANDARD' and 'STANDARD_INFREQUENT_ACCESS'"
  type = string
  validation {
    condition     = length(var.table_class) != 0
    error_message = "table_class should not be empty"
  }
}

########################################################################################################
##                                                                                                    ##
##                     KMS module related variables                                                   ##
##                                                                                                    ##
########################################################################################################

variable "encryption_key_details" {
  description = "for key_type possible values are 'dynamoDB_managed' , 'aws_managed', 'customer_managed' "
  type = object({
    key_type = optional(string,"dynamoDB_managed")  
  })
}

variable "kms_alias" {
  type    = string
  default = "alias/nrt_encryption_key"
  description = "define in the form of 'alias/unique_key_name'"
   
}

variable "delete_after_days" {
  description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
  type    = number
  default = 30
}

variable "key_description" {
  description = "The description of the key as visible in AWS console"
  type    = string
  default = "key_for_dynamoDB-dest"
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
  default = {
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
}

########################################################################################################
##                                                                                                    ##
##                     table data import from source dynamoDB table                                   ##
##                                                                                                    ##
########################################################################################################

variable "is_data_imported" {
description = "enable this if you want to import data from another dynamoDB table using s3"
type = bool
default = false

}

variable "bucket_name_to_import_data" {
  description = "while exporting data from source bucket, make sure to select DYNAMODB_JSON and compression type as GZIP"
  type = string
  default = "abc"
}

variable "import_data_key_prefix" {
  description = "path of .gz file in the S3"
  type = string
  default = "abc"
}

variable "terrform_operation_timeout" {
  description = "provide a value in minute with 'm' appended if any operation takes more than default 360 minutes"
  type = string
  default = "360m"

}