variable "rds_option_group_name" {
  description = "name of rds/aurora option group"
  type        = string
  validation {
    condition     = length(var.rds_option_group_name) != 0
    error_message = "parameter group name can't be left blank"
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
    #  db_security_group_memberships , vpc_security_group_memberships and port will be used only for mysql MEMCACHED option name
    #db_security_group_memberships   = list(string) 
    vpc_security_group_memberships  = list(string)
    port = string
  }))
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