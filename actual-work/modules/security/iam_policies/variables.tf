variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "The description of the IAM policy"
  type        = string
}

# variable "policy_document" {
#   description = "The IAM policy document"
#   type        = any
# }

variable "key_policy_statements" {
  description = "All the statements for the key policy"
  type = map(object({
    sid = string
    actions = list(string)
    resources = list(string)
    effect = string
    principals = object({
      identifiers = list(string)
    })
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