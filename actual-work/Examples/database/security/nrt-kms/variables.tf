variable "aws_region" {
  default = "us-east-1"
}
########################################################################################################
##                                                                                                    ##
##                     KMS module related variables                                                   ##
##                                                                                                    ##
########################################################################################################
variable "encryption_key_details" {
  type = object({
    key_type = optional(string,"dynamoDB_managed")  
  })
  description = "for key_type possible value is 'customer_managed' "
  
}

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