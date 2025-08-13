variable "cluster_identifier" {
  type = string
}
variable "key_policy_map" {
    description = "A valid policy JSON document"
    type = any
}
variable "kms_delete_after_days" {
  type = number
}
variable "tags" {
  type = object({
    AppName             =   string
    Backup              =   string
    BusinessUnit        =   string
    DataClassification  =   string
    Environment         =   string
    InfraOwner          =   string
    Name                =   string
    Product             =   string
    #Squad               =   string
  })
}
variable "instance_role" {
  type = map(object({
    name = string,
    az = string,
    promotion_tier = number
  }))
  
}
variable "storage_type" {
  type = string
}

variable "allocated_storage" {
  type = number

}
variable "storage_iops" {
  type = number
}

variable "backup_retention_period" {
  type = number
}

# this is for provider
variable "aws_region" {
  type = string
}

# variables for parameter group module
variable "rds_parameter_group_name" {
  description = "name of rds/aurora parameter group"
  type = string
  validation {
    condition = length(var.rds_parameter_group_name) != 0
    error_message = "parameter group name can't be left blank"
  }
}

variable "parameter_group_db_family" {
  description = "The family of the DB parameter group"
  type = string
}

variable "parameter_group_description" {
  description = "provide description of usage of this parameter group"
  type = string
}
variable "parameter_value" {
  type = map(object({
    name = string
    value = any
  }))
}