variable "cluster_name" {
  description = "Name of MSK Cluster"
  type        = string
  default     = "tf-s3-to-pg"
}
variable "kafka_version" {
  description = "Kafka Version"
  type        = string
  default     = "3.6.0"
}
variable "client_subnets" {
  description = "Subnet for brokers"
  type        = list(string)
  default = [
    "subnet-04c8a1cce0a80f526",
    "subnet-001023c820ce7e35c",
    "subnet-08792a1a703950fe7",
  ]
}
variable "number_of_broker_nodes" {
  description = "number of brokers in cluster"
  type        = number
  default     = 3
}
variable "instance_type" {
  description = "type of instance of broker"
  type        = string
  default     = "kafka.m5.large"
}
variable "security_groups" {
  description = "Security group"
  type        = list(string)
  default     = ["sg-07c3c80e71d4b954e"]
}
variable "encryption_in_transit_client_broker" {
  description = "(Optional) Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS"
  type = string
  default = "TLS_PLAINTEXT"
}
variable "cloud_watch_log_group_retention_days" {
  type = number
  default = 14
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