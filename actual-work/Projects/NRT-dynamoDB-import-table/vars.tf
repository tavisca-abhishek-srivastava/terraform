variable "ttl_enabled" {
  type = bool
  #default = false
}
variable "attribute_for_ttl" {
type = string
#default = "timetolive"
validation {
  condition = length(var.attribute_for_ttl) >1 && length(var.attribute_for_ttl) < 255
  error_message = "ttl attribute name must be between 1 and 255 characters"
}
}

###################################################
variable "table_hash_key" {
  description = "This will be hash key for dynamoDB table"
  type = string
  validation {
    condition     = lower(var.table_hash_key) == var.table_hash_key && length(var.table_hash_key) != 0
    error_message = "table_hash_key should be in lower case and should be defined"
  }
}

variable "table_range_key" {
  description = "This will be range key for dynamoDB table"
  type    = string
  validation {
    condition     = lower(var.table_range_key) == var.table_range_key && length(var.table_range_key) != 0
    error_message = "table_range_key should be in lower case and should be defined"
}
}


variable "attributes" {
  description = "These will be attributes for dynamoDB table"
  type = map(object({
    name = string
    type = string
  }))
  validation {
    condition     =  length(var.attributes) > 2
    error_message = "Attribute should have hash key and range key at minimum"
}

}
variable "gsi_indices" {
  type = map(object({
    write_capacity = number
    read_capacity  = number
    range_key      = string

  }))

}

variable "lsi_indices" {
  type = map(object({
    range_key = string

  }))

}


variable "enable_deletion_protection" {
  type = bool
  # default = false
  validation {
    condition     = var.enable_deletion_protection == false || var.enable_deletion_protection == true
    error_message = "enable_deletion_protection should be either true or false"
  }
}
variable "table_name" {
  type = string
  validation {
    condition     = length(var.table_name) !=0
    error_message = "table_name should not be empty"
  }
}
variable "table_class" {
  type = string
  validation {
    condition     = length(var.table_class) != 0
    error_message = "table_class should not be empty"
  }
}
variable "table_read_capacity_unit" {
  type = number
  validation {
    condition     = var.table_read_capacity_unit > 0
    error_message = "table_read_capacity_unit should  be > 0"
  }
}

variable "table_write_capacity_unit" {
  type = number
  validation {
    condition     = var.table_write_capacity_unit > 0
    error_message = "table_write_capacity_unit should  be > 0"
  }
}

variable "table_autoscaling_min_read_capacity_unit" {
  type = number
  validation {
    condition     = var.table_autoscaling_min_read_capacity_unit > 0
    error_message = "table_autoscaling_min_read_capacity_unit should  be > 0"
  }

}
variable "table_autoscaling_max_read_capacity_unit" {
  type = number
}

variable "table_autoscaling_min_write_capacity_unit" {
  type = number
  validation {
    condition     = var.table_autoscaling_min_write_capacity_unit > 0
    error_message = "table_autoscaling_min_write_capacity_unit should  be > 0"
  }

}
variable "table_autoscaling_max_write_capacity_unit" {
  type = number
}


variable "table_write_target_percent" {
  type = number
  validation {
    condition     = var.table_write_target_percent > 0
    error_message = "table_write_target_percent should  be > 0"
  }
}
variable "table_read_target_percent" {
  type = number
  validation {
    condition     = var.table_read_target_percent > 0
    error_message = "table_read_target_percent should  be > 0"
  }
}

########################################################################################################
##                                                                                                    ##
##                     KMS module related variables                                                   ##
##                                                                                                    ##
########################################################################################################

variable "encryption_key_details" {
  type = object({
    key_type = optional(string,"dynamoDB_managed")  
  })
  description = "for key_type possible values are 'dynamoDB_managed' , 'aws_managed', 'customer_managed' "
  
}

variable "kms_alias" {
  type = string
  #default = "alias/nrt_encryption_key-import"
}

variable "delete_after_days" {
  type = number
  #default = 10
}

variable "key_description" {
  type = string
  #default = "key_for_dynamoDB-import"
}
variable "key_policy_map" {
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
type = bool
description = "enter true if you want to import data from another DynamoDB table else false"

}

variable "bucket_name_to_import_data" {
  type = string
  description = "while exporting data from source bucket, make sure to select DYNAMODB_JSON and compression type as GZIP"
}

variable "import_data_key_prefix" {
  type = string
  description = "path of .gz file in the S3"
}