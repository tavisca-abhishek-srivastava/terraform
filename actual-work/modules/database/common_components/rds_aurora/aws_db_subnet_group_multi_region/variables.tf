variable "subnet_group_name" {
  description = "provide subnet group name"
  type = string
}

variable "subnet_group_subnet_ids" {
  description = "provide atleast 3 subnet ids from 3 different azs for primary region"
  type = list
}
# variable "primary_region" {
#   description = "aws primary region"
# }

# variable "replica_region" {
#   description = "aws replica region"
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