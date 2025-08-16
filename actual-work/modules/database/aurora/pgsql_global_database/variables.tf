variable "cluster_identifier" {
  type = string
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
variable "instance_role_or" {
  type = map(object({
    name = string,
    az = string,
    promotion_tier = number
  }))
  
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

##### MRK
variable "key_primary_region" {
  description = "primary region for key"
  type = string
  default = "us-east-1"
}
variable "kms_alias" {
    description = "define in the form of 'alias/unique_key_name'"
    type = string
}
variable "is_this_primary" {
  description = "To define if a key is primary or replica"
  type = bool
  default = false
}

variable "deletion_window_in_days" {
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
######### replica key variables
variable "is_kms_replica" {
  description = "enable it is replica key needed in another region"
  type = bool
  default = false
}
variable "need_kms_replica" {
  description = "enable it when kms replica is needed in another region"
  type = bool
  default = false
}
variable "replica_region" {
  description = "another region for kms key replica "
  type = string
  default = null
}

########################################################################################################
##                                                                                                    ##
##                     subnet group module related variables                                          ##
##                                                                                                    ##
########################################################################################################
variable "use_default_subnet_group" {
   description = <<EOF
  "whether to use default subnet group for RDS/Aurora. 
  if true -> provide name of 'default subnet group' in variable 'rds_subnet_group_name' if false -> custom name"
  EOF
  
  type = bool
  default = true
}
variable "rds_subnet_group_name" {
  description = "name of rds/aurora subnet group existing or new"
  type = string
  validation {
    condition = length(var.rds_subnet_group_name) != 0
    error_message = "subnet group name can't be left blank"
  }
}

variable "subnet_group_subnet_ids" {
  description = "List of subnet group subnet ids"
  type = list
  validation {
    condition = length(var.subnet_group_subnet_ids) >= 3
    error_message = "number of subnets in subnet group name can't be left blank"
  }
}

variable "subnet_group_subnet_ids_or" {
  description = "List of subnet group subnet ids"
  type = list
  validation {
    condition = length(var.subnet_group_subnet_ids) >= 3
    error_message = "number of subnets in subnet group name can't be left blank"
  }
}