variable "kms_alias" {
    description = "define in the form of 'alias/unique_key_name'"
    type = string
}

variable "delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
}

variable "key_description" {
    description = "The description of the key as visible in AWS console"
    type = string
}
variable "key_policy_map" {
    description = "A valid policy JSON document"
    type = any
 
}

variable "replica_key_policy" {
    description = "A valid policy JSON document"
    type = any
    default = null
 
}

variable "kms_tags" {
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