#Optional variable

variable "terrform_operation_timeout" {
  description = "provide a value in minute with 'm' appended if any operation takes more than default 360 minutes"
  type = string
  default = "360m"
}
variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed"
  type = bool
  default = false
}
variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type = bool
  default = false
}
variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type = bool
  default = false
}

##############################
variable "aws_region" {
  default = "us-east-1"
}
variable "rds_engine" {
  description = "The database engine to use. e.g. 'mysql', 'postgres','mariadb','sqlserver-ee' etc"
  type = string
  validation {
    condition = length(var.rds_engine) != 0
    error_message = "database engine to use. e.g. 'mysql', 'postgres','mariadb','sqlserver-ee' etc "
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
    condition = var.storage_type == "gp3" || var.storage_type == "io1" || var.storage_type == "io2"
    error_message = "storage type should be of type gp3"
  }
}
variable "storage_iops" {
  type = number
  default = 0
}
variable "enable_storage_autoscaling" {
  description = "to enable storage autoscaling"
  type = bool
  default = false
}

variable "max_allocated_storage" {
  description = "set this value if 'enable_storage_autoscaling' is set to true"
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

variable "availability_zone" {
  description = "The AZ for the RDS instance"
  type = string
  default = "us-east-1a"
}
variable "backup_retention_period" {
  description = "The days to retain backups for. Must be between 0 and 35.Must be greater than 0 if the database is used as a source for a Read Replica"
  type = number
}
variable "multi_az" {
  type = bool
  default = false
}
variable "number_of_read_replica" {
  description = "number of read replica for better read performance"
  type = number
  default = 0
}
variable "az_for_replica" {
  description = "list of azs where read only replica will be placed. This can be different from az of primary instance"
  type = list
  default = ["us-east-1b","us-east-1c"]
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