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
variable "restore_2_pitr" {
  description = "true if table is restored from pitr"
  type = bool
  default = false
  
}
variable "backup_window" {
  description = <<EOF
  The daily time range (in UTC) during which automated backups are created if they are enabled
  Example: "09:46-10:16". Must not overlap with maintenance_window
  EOF 
  type = string
  default = null
}
variable "monitoring_role_arn" {
  description = "value"
  type = string
  default = null
}
variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type = string
  default = null
}
variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
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
  validation {
    condition = length(var.rds_engine_version) != 0
    error_message = "database engine version must be specified "
    }
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
variable "az_for_read_replica" {
  description = "list of azs where read only replica will be placed. This can be different from az of primary instance"
  type = list
  default = ["us-east-1b","us-east-1c"]
}
variable "storage_throughput" {
  description = <<EOF
  The storage throughput value for the DB instance. Can only be set when storage_type is 'gp3'.
  refer for more details: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#gp3-storage
  EOF
  type = number
  default = 3000
}

variable "license_model" {
  description = "License model information for this DB instance"
  type = string
  default = "general-public-license"
}
variable "port" {
  description = "port for client to connect to DB"
  type = number
  validation {
    condition = var.port != 0 || var.port != null
    error_message = "port can't be left blank"
  }

}
variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type = bool
  default = false
}

variable "performance_insights_retention_period" {
  description = <<EOF
  Amount of time in days to retain Performance Insights data. 
  Valid values are 7, 731 (2 years) or a multiple of 31. 
  When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true.
  EOF
  type = number
  default = 7
}

variable "user_name" {
  description = "username for rds instance"
  type = string
}
variable "password" {
  description = "password for rds instance"
  type = string
}

variable "db_subnet_group" {
  description = <<EOF
  "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. 
  If unspecified, will be created in the default VPC, or in EC2 Classic, if available. 
  When working with read replicas, it should be specified only if the source database specifies an instance in another AWS Region"
  EOF
  type = string
  default = null
}
variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type = list
}
variable "skip_final_snapshot" {
  description = <<EOF
 "Determines whether a final DB snapshot is created before the DB instance is deleted. 
  If true is specified, no DBSnapshot is created. 
  If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  EOF
  type = bool
  default = false
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

########################################################################################################
##                                                                                                    ##
##                     option group module related variables                                          ##
##                                                                                                    ##
########################################################################################################

variable "use_default_option_group" {
  description = "whether to use default option group for RDS/Aurora. if true -> provide name of 'default option group' in variable 'rds_option_group_name' if false -> custom name"
  type = bool
  default = true
}

# variables for option group module
variable "rds_option_group_name" {
  description = "name of rds/aurora option group"
  type        = string
  validation {
    condition     = length(var.rds_option_group_name) != 0
    error_message = "option group name can't be left blank"
  }
}

variable "option_group_engine_name" {
  description = "The engine_name of the DB like "
  type        = string
}

variable "option_group_description" {
  description = "provide description of usage of this option group"
  type        = string
}
variable "option_group_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
}

variable "option_settings" {
  type = map(object({
    option_name           = string
    option_settings_name  = string
    option_settings_value = any
    #vpc_security_group_memberships and port will be used only for mysql MEMCACHED option name
    vpc_security_group_memberships  = list(string)
    port = string
  }))
}

########################################################################################################
##                                                                                                    ##
##                     parameter group module related variables                                       ##
##                                                                                                    ##
########################################################################################################
variable "use_default_parameter_group" {
   description = <<EOF
  "whether to use default parameter group for RDS/Aurora. 
   if true -> provide name of 'default parameter group' in variable 'rds_option_group_name' if false -> custom name"
  EOF
  
  type = bool
  default = true
}
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