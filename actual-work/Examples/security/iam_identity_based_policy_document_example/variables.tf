variable "aws_region" {
  default = "us-east-1"
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "The description of the IAM policy"
  type        = string
}

variable "key_policy_statements" {
  description = "All the statements for the key policy"
  type = map(object({
    sid = string
    actions = list(string)
    resources = list(string)
    effect = string
  }))
default = {}
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