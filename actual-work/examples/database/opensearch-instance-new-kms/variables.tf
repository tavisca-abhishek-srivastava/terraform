variable "aws_region" {
  description = "region where opensearch domain will be created"
  type        = string
  default     = "us-east-1"
}
variable "open_search_domain_name" {
  description = "Name of Opensearch domain"
  type        = string
  validation {
    condition     = length(var.open_search_domain_name) <= 28
    error_message = "Domain name must be in small and less than 28 characters"
  }
}
variable "opensearch_domains_config" {

}

########################################################################################################
##                                                                                                    ##
##                     KMS module related variables for opensearch encryption at rest                 ##
##                                                                                                    ##
########################################################################################################
variable "kms_delete_after_days" {
  description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
  type        = number
  default     = 30
}

variable "key_policy_statements" {
  description = "All the statements for the key policy"
  type        = any
  default     = {}
}
variable "is_this_primary" {
  description = "To define if a key is primary or replica"
  type        = bool
  default     = false
}

########################################################################################################
##                                                                                                    ##
##                     security group module related variables for opensearch                         ##
##                                                                                                    ##
########################################################################################################

variable "vpc_id" {
  description = "Enter VPC ID for Security group"
  type        = string
  default     = ""
}

variable "ingress_rules_sg1" {
  description = "Enter ingress rule in the"
  type        = list(any)
  default     = []
}

variable "egress_rules_sg1" {
  description = "Enter engress rule in the"
  type        = list(any)
  default     = []
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