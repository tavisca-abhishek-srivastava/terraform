variable "aws_region" {
  default = "us-east-1"
}
########################################################################################################
##                                                                                                    ##
##                     KMS module related variables                                                   ##
##                                                                                                    ##
########################################################################################################
variable "kms_alias" {
    description = "define in the form of 'alias/unique_key_name'"
    type = string
    
}
variable "primary_key_arn" {
  description = "The primary key arn of a multi-region replica key"
  type        = string
  default     = null
}
variable "delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
}
variable "key_description" {
    description = "The description of the key as visible in AWS console"
    type = string
}

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

variable "need_kms_replica" {
  description = "enable it when kms replica is needed in another region"
  type = bool
  default = false
}
variable "replica_region" {
  description = "another region for kms key replica. "
  type = string
  default = null
}

variable "replica_key_policy_statements" {
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

# variable "replica_key_policy" {
#     description = "A valid policy JSON document"
#     type = any
#     default = null
# }
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