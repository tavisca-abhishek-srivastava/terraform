variable "cluster_identifier" {
  type = string
  description = "Cluster name"
  default = "nrt_compliance"
}



#### kms

variable "key_policy_map" {
  description = "A valid policy JSON document"
  type = any
}
variable "delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
    default = 30
}

variable "tags" {
  type = object({
    AppName             =   string
    Backup              =   string
    BusinessUnit        =   string
    DataClassification  =   string
    Environment         =   string
    InfraOwner          =   string
    Name                =   string    
    Product             =   string
    Squad               =   string
  })
}