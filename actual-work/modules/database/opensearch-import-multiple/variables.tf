variable "open_search_domain_name" {
  description = "Name of Opensearch domain"
  type        = string
  validation {
    condition = length(var.open_search_domain_name) <=28
    error_message = "Domain name must be in small and less than 28 characters"
  }
}
variable "open_search_engine_version" {
  description = "(Optional) Either Elasticsearch_X.Y or OpenSearch_X.Y to specify the engine version for the Amazon OpenSearch Service domain. For example, OpenSearch_1.0 or Elasticsearch_7.9"
  type        = string
}
####### variables for vpc_options
variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the OpenSearch domain endpoints to be created in"
  type        = list(any)
  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "Minimum 2 subnet ids must be specified"
  }
}
variable "security_group_ids" {
  description = "(Optional) List of VPC Security Group IDs to be applied to the OpenSearch domain endpoints"
  type = list(string)
  default = []
}
########### variable for advanced_security_options
variable "advanced_security_options_enabled" {
  description = "Whether advanced security is enabled."
  type        = bool
  default = true
}

variable "internal_user_database_enabled" {
  description = "Whether the internal user database is enabled. Default is false"
  type        = bool
  default     = true
}

variable "anonymous_auth_enabled" {
  description = <<EOF
  "Whether Anonymous auth is enabled. Enables fine-grained access control on an existing domain. 
  Ignored unless advanced_security_options are enabled. Can only be enabled on an existing domain."
  EOF
  type = bool
  default = false
}
variable "master_user_arn" {
  description = "(Optional) ARN for the main user. Only specify if internal_user_database_enabled is not set or set to false"
  type        = string
  default     = ""
}
variable "master_user_name" {
  description = <<EOF
   "(Optional) Main user's username, which is stored in the Amazon OpenSearch Service domain's internal database. 
  Only specify if internal_user_database_enabled is set to true"
  EOF
  type        = string
  default     = ""
}
variable "master_user_password" {
  description = <<EOF
  "(Optional) Main user's password, which is stored in the Amazon OpenSearch Service domain's internal database. 
  Only specify if internal_user_database_enabled is set to true"
  EOF
  type        = string
  default     = ""
}

########## variables for 'auto_tune_options' block
variable "desired_state" {
  description = "(Required) Auto-Tune desired state for the domain. Valid values: ENABLED or DISABLED"
  type        = string
  default     = "ENABLED"
}
variable "start_at" {
  description = "(Required) Date and time at which to start the Auto-Tune maintenance schedule in RFC3339 format"
  type        = string
  default     = null
}
variable "value" {
  description = "(Required) An integer specifying the value of the duration of an Auto-Tune maintenance window"
  type        = number
  default     = 0
}

variable "unit" {
  description = "(Required) Unit of time specifying the duration of an Auto-Tune maintenance window. Valid values: HOURS"
  type        = string
  default     = "HOURS"
}
variable "cron_expression_for_recurrence" {
  description = "(Required) A cron expression specifying the recurrence pattern for an Auto-Tune maintenance schedule"
  type        = string
  default     = null
}
variable "use_off_peak_window" {
  description = <<EOF
  "(Optional) Whether to schedule Auto-Tune optimizations that require blue/green deployments during the domain's configured daily off-peak window. 
  Defaults to false"
  EOF
  type = bool
  default = false
}
########################## variables for "cluster_config"
variable "dedicated_master_count" {
  description = "(Optional) Number of dedicated main nodes in the cluster"
  type        = number
  default     = 3
  validation {
    condition     = var.dedicated_master_count >= 3
    error_message = "dedicated master count should be 3 or more"
  }
}
variable "dedicated_master_type" {
  description = "(Optional) Instance type of the dedicated main nodes in the cluster."
  type        = string
  default     = ""
}
variable "dedicated_master_enabled" {
  description = "(Optional) Whether dedicated main nodes are enabled for the cluster"
  type        = bool
}
variable "instance_type" {
  description = "Instance type of data nodes in the cluster"
  type        = string
  default = true
}
variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 3
  validation {
    condition     = var.instance_count >= 3
    error_message = "data node count should be 3 or more"
  }
}
variable "multi_az_with_standby_enabled" {
  description = "Whether a multi-AZ domain is turned on with a standby AZ. put null if creating opensearch based elasticsearch"
  type        = bool
  default     = true
}
variable "zone_awareness_enabled" {
  description = <<EOF
  "Whether zone awareness is enabled, set to true for multi-az deployment. 
  To enable awareness with three Availability Zones, the availability_zone_count within the zone_awareness_config must be set to 3"
  EOF
  type        = bool
  default = true
}
variable "cold_storage_options_enabled" {
  description = "Configuration block containing cold storage configuration"
  type        = bool
  default     = false
}
variable "warm_enabled" {
  description = "(Optional) Whether to enable warm storage"
  type        = bool
  default     = false
}
variable "warm_type" {
  description = <<EOF
                "(Optional) Instance type for the OpenSearch cluster's warm nodes. 
                Valid values are ultrawarm1.medium.search, ultrawarm1.large.search and ultrawarm1.xlarge.search. 
                warm_type can be only and must be set when warm_enabled is set to true"
                EOF
  type        = string
  default     = "ultrawarm1.medium.search"
}
variable "warm_count" {
  description = <<EOF
                  "(Optional) Number of warm nodes in the cluster. Valid values are between 2 and 150. 
                  warm_count can be only and must be set when "warm_enabled" is set to true"
                  EOF
  type        = number
  default = 2

}
##### domain_endpoint_options variable
variable custom_endpoint_certificate_arn {
  description = "(Optional) ACM certificate ARN for your custom endpoint."
  type        = string
  default     = ""
}
variable custom_endpoint_enabled {
  description = "(Optional) Whether to enable custom endpoint for the OpenSearch domain"
  type        = bool
  default     = false  
}
variable custom_endpoint {
  description = "(Optional) Fully qualified domain for your custom endpoint"
  type        = string
  default     = ""
  }
variable "domain_endpoint_options_enforce_https" {
  description = "Whether or not to require HTTPS for domain endpoint"
  type        = bool
  default = true
}
############## variables for encrypt_at_rest
variable "encrypt_at_rest_enabled" {
  description = <<EOF
  "(Required) Whether to enable encryption at rest. If the encrypt_at_rest block is not provided then this defaults to true. 
  Enabling encryption on new domains requires an engine_version of OpenSearch_X.Y or Elasticsearch_5.1 or greater"
  EOF
  type        = bool
  default     = true
}
variable "kms_key_id" {
  description = <<EOF
  "(Optional) KMS key ARN to encrypt the Elasticsearch domain with. 
  If not specified then it defaults to using the aws/es service KMS key. 
  Note that KMS will accept a KMS key ID but will return the key ARN. 
  To prevent Terraform detecting unwanted changes, use the key ARN instead."
  EOF
  type = string
  default = ""
}

###########
variable "automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain"
  type = number
  default = 0
}
variable "auto_software_update_enabled" {
  description = "(Optional) Whether automatic service software updates are enabled for the domain. Defaults to false"
  type = bool
  default = false
}
variable "rollback_on_disable" {
  description = "(Optional) Whether to roll back to default Auto-Tune settings when disabling Auto-Tune. Valid values: DEFAULT_ROLLBACK or NO_ROLLBACK"
  type        = string
  default = "NO_ROLLBACK"
}

########## variables for ebs_options
variable "ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain"
  type        = bool
  default     = true
}
variable "ebs_volume_size" {
  description = "(Required if ebs_enabled is set to true.) Size of EBS volumes attached to data nodes (in GiB)"
  type        = number
  default = 45
  validation {
    condition     = var.ebs_volume_size > 30
    error_message = "ebs volume size must be greater than 30 GB"
  }
}
variable "volume_type" {
  description = "(Optional) Type of EBS volumes attached to data nodes"
  type        = string
  default     = "gp3"
}
variable "throughput" {
  description = <<EOF
  "(Required if volume_type is set to gp3) Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. 
  Applicable only for the gp3 volume type."
  EOF
  type        = number
  default = 250
}
variable "ebs_iops" {
  description = "(Optional) Baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the GP3 and Provisioned IOPS EBS volume types."
  type        = number
  default = 3000
}
############ variable for off_peak_window_options
variable "off_peak_window_options_enabled" {
  description = "(Optional) Enabled disabled toggle for off-peak update window."
  type = bool
  default = true
}
variable "window_start_time" {
  description = "(Optional) 10h window for updates"
  type = number
  default = 2
}
variable "hours" {
  description = "(Required) Starting hour of the 10-hour window for updates"
  type = number
  default = 2
}
variable "minutes" {
  description = "(Required) Starting minute of the 10-hour window for updates"
  type = number
  default = 0
}
##################################

variable "aws_region" {
  description = "region where opensearch domain will be created"
  type        = string
  default = "us-east-1"
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
##                     security group module related variables for opensearch                         ##
##                                                                                                    ##
########################################################################################################

variable "vpc_id" {
  description = "Enter VPC ID for Security group"
  type        = string
  default = ""
}

variable "ingress_rules_sg1" {
  description = "Enter ingress rule in the"
  type        = list(any)
  default = []
}

variable "egress_rules_sg1" {
  description = "Enter engress rule in the"
  type        = list(any)
  default = []
}

#### Cloud watch Log group

variable "cloud_watch_log_group_retention_days" {
  description = "number of days cloud watch log group will be retained"
  type        = number
  default     = 14
}