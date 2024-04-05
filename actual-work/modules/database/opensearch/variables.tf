variable "open_search_domain" {
    description = "value"
    type = string
  }
variable "open_search_engine_version" {
    description = "(Optional) Either Elasticsearch_X.Y or OpenSearch_X.Y to specify the engine version for the Amazon OpenSearch Service domain. For example, OpenSearch_1.0 or Elasticsearch_7.9"
    type = string 
}
variable "dedicated_master_count" {
  description = "(Optional) Number of dedicated main nodes in the cluster"
  type = number
  default = 0  
}
variable "dedicated_master_type" {
  description = "(Optional) Instance type of the dedicated main nodes in the cluster."
  type = string
  default = null
}

variable "dedicated_master_enabled" {
  description = "(Optional) Whether dedicated main nodes are enabled for the cluster"
  type = bool
}
variable "instance_type" {
  
  type = string
}
variable "instance_count" {
  type = number
}

variable "zone_awareness_enabled" {
  type = bool
}

variable "subnet_ids" {
  type = list
}

variable "security_options_enabled" {
  type = bool
}
variable "security_group_ids" {
  type = list
}

variable "master_user" {
  type = string
}

variable "encrypt_at_rest_enabled" {
  type = bool
}

variable "domain_endpoint_options_enforce_https" {
  type = bool
}

variable "ebs_enabled" {
  type = bool
}

variable "ebs_volume_size" {
  type = number
}

variable "volume_type" {
  type = string
}

variable "throughput" {
  type = number
}

variable "security_group_ids" {
  type = string
}

variable "aws_region" {
  type = string
}