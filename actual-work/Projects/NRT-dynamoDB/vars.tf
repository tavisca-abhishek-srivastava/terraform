variable "table_hash_key" {
    type = string
    # default = "user_id"
    validation {
      condition = lower(var.table_hash_key) == var.table_hash_key
      error_message = "table_hash_key should be in lower case"
    }
}

variable "table_range_key" {
  type = string
  default = "product_id"
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
variable   "gsi_indices"  {
  type = map(object({
    write_capacity = number
    read_capacity  =number
    range_key = string

  }))
  default = { 
    # in key-value pair, key will be index hash_key
   "product_name" = { write_capacity = 5 , read_capacity  = 5, range_key      = "product_id"},
   "product_desc" = { write_capacity = 5 ,read_capacity  = 5,range_key      = "product_id"},
   "age" = { write_capacity = 15, read_capacity  = 15, range_key      = "user_id"},
  }
  }

variable   "lsi_indices"  {
  type = map(object({
    range_key = string

  }))
  default = { 
   "by_age" = {range_key = "age"},
  }
}

variable "kms_key_arn" {
  type = string
  default = "arn:aws:kms:us-east-1:928814396842:key/bb8d50d3-6d96-4b26-8e3e-eb9e3026be18"
}

variable "enable_deletion_protection" {
  type = bool
  # default = false
  validation {
      condition = var.enable_deletion_protection == false
      error_message = "enable_deletion_protection should be either true or false"
  }
}

variable "aws_dynamodb_table_name" {
  type = string
  # default = "tf_bnr_testing_provisioned"
  validation {
      condition = lower(var.aws_dynamodb_table_name) == var.aws_dynamodb_table_name
      error_message = "table_name should be in lower case"
  }
}
variable "table_class" {
    type = string
  # default = "tf_bnr_testing_provisioned"
  validation {
      condition = length(var.table_class) != 0
      error_message = "table_class should not be empty"
  }
 }