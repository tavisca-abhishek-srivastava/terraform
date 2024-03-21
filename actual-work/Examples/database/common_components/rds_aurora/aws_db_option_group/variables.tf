# this is for provider
variable "aws_region" {
  type = string
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

variable "engine_name" {
  description = "The engine_name of the DB like "
  type        = string
}

variable "option_group_description" {
  description = "provide description of usage of this option group"
  type        = string
}
variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
}

variable "option_settings" {
  type = map(object({
    option_name           = string
    option_settings_name  = string
    option_settings_value = any
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