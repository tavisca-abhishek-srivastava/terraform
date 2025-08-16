variable "subnet_group_name" {
  description = "provide subnet group name"
  type = string
}

variable "subnet_group_subnet_ids" {
  description = "provide atleast 3 subnet ids from 3 different azs for primary region"
  type = list
}
variable "subnet_group_subnet_ids_or" {
  description = "provide atleast 3 subnet ids from 3 different azs for primary region"
  type = list
}
variable "primary_region" {
  description = "aws primary region"
}

variable "replica_region" {
  description = "aws replica region"
}
variable "use_default_subnet_group" {
   description = <<EOF
  "whether to use default subnet group for RDS/Aurora. 
  if true -> provide name of 'default subnet group' in variable 'rds_subnet_group_name' if false -> custom name"
  EOF
  
  type = bool
  default = false
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