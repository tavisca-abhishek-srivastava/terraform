# Optional variable (need not to define in caller ) and value is set to default
variable "is_stream_enabled" {
  type = bool
  default = false
}
variable "stream_view_type" {
  type = string
  default = "NEW_IMAGE"
}
variable "ttl_enabled" {
  type = bool
  default = true
}
variable "attribute_for_ttl" {
type = string
default = "timetolive"
validation {
  condition = length(var.attribute_for_ttl) >1 && length(var.attribute_for_ttl) < 255
  error_message = "ttl attribute name must be between 1 and 255 characters"
}
}

###########################################################################################
# Mandatory variables
variable "table_hash_key" {
  type = string
  validation {
    condition     = lower(var.table_hash_key) == var.table_hash_key && lenght(var.table_hash_key) != 0
    error_message = "table_hash_key should be in lower case and should be defined"
  }
}

variable "table_range_key" {
  type    = string
  validation {
    condition     = lower(var.table_range_key) == var.table_range_key && lenght(var.table_range_key) != 0
    error_message = "table_range_key should be in lower case and should be defined"
}
}

variable "attributes" {
  type = map(object({
    name = string
    type = string
  }))
  default = {
    "attr1" = { name = "user_id", type = "S" },
    "attr2" = { name = "product_id", type = "S" },
    "attr3" = { name = "product_name", type = "S" },
    "attr4" = { name = "product_desc", type = "S" },
    "attr5" = { name = "age", type = "N" },
  }
}
variable "gsi_indices" {
  type = map(object({
    write_capacity = number
    read_capacity  = number
    range_key      = string

  }))
  default = {
    # in key-value pair, key will be GSI hash_key
    "product_name" = { write_capacity = 60, read_capacity = 60, range_key = "product_id" },
    "product_desc" = { write_capacity = 60, read_capacity = 60, range_key = "product_id" },
    "age"          = { write_capacity = 65, read_capacity = 65, range_key = "user_id" },
  }
}

variable "lsi_indices" {
  type = map(object({
    range_key = string

  }))
  default = {
    # in key-value pair, key will be LSI range_key
    "by_age" = { range_key = "age" },
  }
}


variable "kms_key_arn" {
  type    = string
  default = "arn:aws:kms:us-east-1:928814396842:key/bb8d50d3-6d96-4b26-8e3e-eb9e3026be18"
}

variable "enable_deletion_protection" {
  type = bool
  # default = false
  validation {
    condition     = var.enable_deletion_protection == false || var.enable_deletion_protection == true
    error_message = "enable_deletion_protection should be either true or false"
  }
}
variable "aws_dynamodb_table_name" {
  type = string
  validation {
    condition     = lower(var.aws_dynamodb_table_name) == var.aws_dynamodb_table_name
    error_message = "table_name should be in lower case"
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