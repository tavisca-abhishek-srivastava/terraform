variable "aws_dynamodb_table_name" {
  type = string
  default = "tf_bnr_testing"
}

variable "hash_key" {
  default = "user_id"
}

variable "range_key" {
  default = "product_id"
}

variable "other_attr" { 
    type = map(object({
      "name" = string
      "type" = string
    }))
  default = {
    "attr1" = { name = "user_id", type = "S" },
    "attr2" = { name = "product_id", type = "S" },
    "attr3" = { name = "product_name", type = "S" },
    "attr4" = { name = "product_desc", type = "S" },
  }
}