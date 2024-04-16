variable "open_search_domain_name" {
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
  default = 3
  validation {
    condition = var.dedicated_master_count >= 3
    error_message = "dedicated master count should be 3 or more"
    }  
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
  description = "Instance type of data nodes in the cluster"
  type = string
}
variable "instance_count" {
  description = "Number of instances in the cluster"
  type = number
  default = 3
    validation {
    condition = var.instance_count >= 3
    error_message = "data node count should be 3 or more"
    }  
}

variable "multi_az_with_standby_enabled" {
  description = "Whether a multi-AZ domain is turned on with a standby AZ"
  type = bool
}

variable "zone_awareness_enabled" {
  description = <<EOF
  "Whether zone awareness is enabled, set to true for multi-az deployment. 
  To enable awareness with three Availability Zones, the availability_zone_count within the zone_awareness_config must be set to 3"
  EOF
  type = bool
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the OpenSearch domain endpoints to be created in"
  type = list
    validation {
    condition = length(var.subnet_ids) >= 3
    error_message = "Minimum 3 subnet ids must be specified"
    }  
}

variable "security_options_enabled" {
  description = "Whether advanced security is enabled."
  type = bool
}

variable "internal_user_database_enabled" {
  description = "Whether the internal user database is enabled. Default is false"
  type = bool
  default = false
}

variable "anonymous_auth_enabled" {
  description = <<EOF
  "Whether Anonymous auth is enabled. Enables fine-grained access control on an existing domain. 
  Ignored unless advanced_security_options are enabled. Can only be enabled on an existing domain."
  EOF
  type = bool
}

variable "master_user_name" {
   description = <<EOF
  "Main user's username, which is stored in the Amazon OpenSearch Service domain's internal database. 
  Only specify if internal_user_database_enabled is set to true"
  EOF
  type = string
}

variable "master_user_password" {
  description = <<EOF
  "Main user's password, which is stored in the Amazon OpenSearch Service domain's internal database. 
  Only specify if internal_user_database_enabled is set to true"
  EOF

}

variable "encrypt_at_rest_enabled" {
  description = <<EOF
  "(Required) Whether to enable encryption at rest. If the encrypt_at_rest block is not provided then this defaults to true. 
  Enabling encryption on new domains requires an engine_version of OpenSearch_X.Y or Elasticsearch_5.1 or greater"
  EOF
  type = bool
  default = true
}

variable "domain_endpoint_options_enforce_https" {
  description = "Whether or not to require HTTPS for domain endpoint"
  type = bool
}

variable "ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain"
  type = bool
  default = true
}

variable "ebs_volume_size" {
  description = "(Required if ebs_enabled is set to true.) Size of EBS volumes attached to data nodes (in GiB)"
  type = number
  validation {
    condition = var.ebs_volume_size > 30
    error_message = "ebs volume size must be greater than 30 GB"
  }
}

variable "volume_type" {
  description = "(Optional) Type of EBS volumes attached to data nodes"
  type = string
  default = "gp3"
}

variable "throughput" {
  description = <<EOF
  "(Required if volume_type is set to gp3) Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. 
  Applicable only for the gp3 volume type."
  EOF
  type = number
}

variable "ebs_iops" {
  description = "(Optional) Baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the GP3 and Provisioned IOPS EBS volume types."
  type = number
}
variable "aws_region" {
  description = "region where opensearch domain will be created"
  type = string
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
########################################################################################################
##                                                                                                    ##
##                     KMS module related variables for opensearch encryption at rest                 ##
##                                                                                                    ##
########################################################################################################

variable "kms_delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
    default = 30
}

variable "key_policy_map" {
    description = "A valid policy JSON document"
    type = any
}


########################################################################################################
##                                                                                                    ##
##                     security group module related variables for opensearch                         ##
##                                                                                                    ##
########################################################################################################

variable "vpc_id" {
  description = "Enter VPC ID for Security group"
  type = string
}

variable "ingress_rules_sg1" {
  description = "Enter ingress rule in the"
  type = list
}

variable "egress_rules_sg1" {
 description = "Enter engress rule in the"
  type = list
}

#### Cloud watch Log group

variable "cloud_watch_log_group_retention_days" {
  description = "number of days cloud watch log group will be retained"
  type = number
  default = 14
}
