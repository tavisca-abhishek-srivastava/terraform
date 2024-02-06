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


variable "attr1" {
  type = map()
  default = {
    name = "user_id", type = "S"
  }
}
variable "attr2" {
  type = map()
  default = {
    name = "product_id", type = "S"
  }
}
variable "attr3" {
  type = map()
  default = {
    name = "road_id", type = "S"
  }
}
variable "attr4" {
  type = map()
  default = {
    name = "product_desc", type = "S"
  }
}


