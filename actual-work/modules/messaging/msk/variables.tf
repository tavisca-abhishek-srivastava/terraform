variable "cluster_name" {
    description = "Name of MSK Cluster"
    type = string
    default = "tf-s3-to-pg"
}
variable "kafka_version" {
    description = "Kafka Version"
    type = string
    default = "3.6.0"
}
variable "client_subnets" {
    description = "Subnet for brokers"
    type = list(string)
    default = [
        "subnet-060048463710e54c4",
        "subnet-01d4d19deaa34db85",
        "subnet-061e332b24aecd27b",
    ]
}                                                                                                                                                              
variable "number_of_broker_nodes" {
    description = "number of brokers in cluster"
    type = number
    default =   3
}
variable "instance_type" {
    description = "type of instance of broker"
    type = string
    default = "kafka.m5.large"
}
variable "security_groups" {
  description = "Security group"
  type = list(string)
  default = ["sg-07c3c80e71d4b954e"]
}