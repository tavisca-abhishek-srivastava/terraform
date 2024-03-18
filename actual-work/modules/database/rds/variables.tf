
variable "aws_region" {
  default = "us-east-1"
}
variable "rds_engine" {
  description = "The database engine to use. e.g. 'mysql', 'postgres','mariadb','sqlserver-ee' etc"
  type = string
  validation {
    condition = var.rds_engine
    error_message = "engine must be of type "
    }
}

variable "rds_engine_version" {
  type = string
}
variable "allocated_storage" {
  description = "value"
  default = 30
  validation {
    condition = var.allocated_storage > 30
    error_message = "Storage should be greater than 30"
  }
}
variable "storage_type" {
  description = "value"
  type = string
  validation {
    condition = var.storage_type == "gp3"
    error_message = "storage type should be of type gp3"
  }
}
variable "storage_iops" {
  type = number
  default = 0

}
variable "db_name" {
  description = "value"
  type = string
  validation {
    condition = length(var.db_name) != 0
    error_message = "please provide db name"
  }
}
variable "rds_instance_name" {
  description = "value"
  type = string
  validation {
    condition = length(var.rds_instance_name) != 0
    error_message = "please provide rds instance name"
  }
}

variable "db_instance_class" {
  description = "value"
  type = string
  validation {
    condition = length(var.db_instance_class) != 0
    error_message = "please provide db instance class"
  }
}
variable "terrform_operation_timeout" {
  description = "provide a value in minute with 'm' appended if any operation takes more than default 360 minutes"
  type = string
  default = "360m"
}
		
variable "tags" {
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

########################################################################################################
##                                                                                                    ##
##                     KMS module related variables                                                   ##
##                                                                                                    ##
########################################################################################################
variable "kms_alias" {
    description = "define in the form of 'alias/unique_key_name'"
    type = string
}

variable "delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
}

variable "key_description" {
    description = "The description of the key as visible in AWS console"
    type = string
}
variable "key_policy_map" {
    description = "A valid policy JSON document"
    type = any
 
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