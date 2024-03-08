variable "cluster_name" {
    description = "Provide a meaningful name that uniquely identifies your DAX cluster"
    type = string
}
variable "iam_role_arn" {
  type = string
}
variable "node_type" {
    description = "Choose the type of nodes to run in your clusters. All nodes in each cluster must be of the same type. You cannot modify the node types for a running DAX cluster."
    type = string
}
variable "replication_factor" {
    description = "For a cluster requiring high availability, we strongly recommend at least three nodes. You can scale the number of nodes up or down later."
    type = number
}

variable "cluster_endpoint_encryption_type" {
    description = "value"
    type = string
  default = "NONE"
}
variable "cluster_description" {
  type = string
}
variable "parameter_group_name" {
  type = string
}

variable "security_group_ids" {
  type = string
}

variable "subnet_group" {
    type = string
  
}