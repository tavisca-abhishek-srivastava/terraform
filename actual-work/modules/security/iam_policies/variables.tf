variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "The description of the IAM policy"
  type        = string
}

variable "policy_document" {
  description = "The IAM policy document"
  type        = any
}
