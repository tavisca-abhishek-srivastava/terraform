variable "aws_dynamodb_table_name" {
  type = string
  default = "tf_bnr_testing"
}

variable "table_hash_key" {
    type = string
    # default = "user_id"
    validation {
      condition = lower(var.table_hash_key) == var.table_hash_key
      error_message = "table_hash_key should be in lower case"
    }
}

variable "range_key" {
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
   "product_name" = { write_capacity = 5 , read_capacity  = 5, range_key      = "product_id"},
   "product_desc" = { write_capacity = 5 ,read_capacity  = 5,range_key      = "product_id"},
   "age" = { write_capacity = 15, read_capacity  = 15, range_key      = "user_id"},
  }
  }

variable   "lsi_indices"  {
  type = map(object({
    write_capacity = number
    read_capacity  =number
    range_key = string

  }))
  default = { 
   "product_name" = { write_capacity = 5 , read_capacity  = 5, range_key      = "product_id"},
   "product_desc" = { write_capacity = 5 ,read_capacity  = 5,range_key      = "product_id"},
   "age" = { write_capacity = 15, read_capacity  = 15, range_key      = "user_id"},
  }
  }
  