variable "cluster_name" {
    description = "Provide a meaningful name that uniquely identifies your DAX cluster"
    type = string
}
variable "iam_role_arn" {
    description = "IAM service role to connect to DyanmoDB. -> https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DAX.create-cluster.cli.create-service-role.html"
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
    description = "provide NONE or TLS"
    type = string
    default = "NONE"
}
variable "cluster_description" {
    description = "enter meaningful description for the usages of DAX cluster "
    type = string
}
variable "parameter_group_name" {
    description = "enter existing parameter group"
    type = string
}

variable "security_group_ids" {
    description = "enter existing security group"
  type = string
}

variable "subnet_group_details" {
    description = "enter subnet group details"
    type = object({
      name = string
      subnet_id_1 = string
      subnet_id_2 = string
      subnet_id_3 = string
    })

    validation {
      condition = length(var.subnet_group_details.subnet_id_1) != 0
      error_message = "please specify subnet group name and atleast 3 subnet ids"
    }
  
}