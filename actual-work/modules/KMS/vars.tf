variable "kms_alias" {
  type = string
}

variable "delete_after_days" {
  type = number
}

variable "description" {
  type = string
}
variable "key_policy_map" {
  type = map(string)
 
}