# variable "replica_region" {
#   description = "value"
# }
# variable "primary_region" {
#   description = "value"
# }


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