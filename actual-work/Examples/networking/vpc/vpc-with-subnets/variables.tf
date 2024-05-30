variable "subnet_variables" {
  type = map(object({
    name       = string
    count      = number
    cidr_block = string
    ipv4_routes = list(object({
        destination = string
        target = object({
          type = string
          id   = string
        })
      }))
  }))
  default = {
    web-subnets = {
      name       = "web-subnets"
      count      = 1
      cidr_block = "172.0.0.0/20"
      ipv4_routes = []
    }
    app-subnets = {
      name       = "app-subnets"
      count      = 1
      cidr_block = "172.0.0.0/20"
      ipv4_routes = []
    }
    data-subnets = {
      name       = "data-subnets"
      count      = 1
      cidr_block = "172.0.0.0/20"
      ipv4_routes = []
    }
    mgmt-subnets = {
      name       = "mgmt-subnets"
      count      = 1
      cidr_block = "172.0.0.0/20"
      ipv4_routes = []
    }
    public-subnets = {
      name       = "public-subnets"
      count      = 1
      cidr_block = "172.0.0.0/20"
      ipv4_routes = []
    }
    secondary-range-subnets = {
      name       = "secondary-range-subnets"
      count      = 4
      cidr_block = "172.1.0.0/16"
      ipv4_routes = []
  }
  }
}

variable "vpc_name" {
  description = "desired name for VPC"
  default     = "oski-stage"
}

variable "vpc_cidr_block" {
  description = "this CIDR block range will be used to create VPC"
  default     = "172.0.0.0/19"
}

variable "availability_zones" {
  description = "list of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "region" {
  default = "us-east-1"
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "natgw_count" {
  default = 2
  description = "number of nat gateways"
}

variable "s3_bucket_name_for_vpc_flow_logs" {
  description = "placeholder for s3 bucket to put flow logs"
  default = "arn:aws:s3:::cxloyalty-us-east-1-centralized-ct-vpcflowlog"
}

variable "enable_vpc_flow_log" {
  description = "need to enable and disable flow logs"
  default = true
}
#Rule Number should start from 103
variable "public_nacl_user" {
  description = "#example to add custom rules [{from_port : 1024, to_port : 65535,  rule_num : 103, cidr : '0.0.0.0/0'}]"
  default = []
}
variable "app_nacl_user" {
  description = "#example to add custom rules [{from_port : 1024, to_port : 65535,  rule_num : 103, cidr : '0.0.0.0/0'}]"
  default = []
}
variable "web_nacl_user" {
  description = "#example to add custom rules [{from_port : 1024, to_port : 65535,  rule_num : 103, cidr : '0.0.0.0/0'}]" 
  default = []
}
variable "data_nacl_user" {
  description = "#example to add custom rules [{from_port : 1024, to_port : 65535,  rule_num : 103, cidr : '0.0.0.0/0'}]"
  default = []
}
variable "mgmt_nacl_user" {
  description = "#example to add custom rules [{from_port : 1024, to_port : 65535,  rule_num : 103, cidr : '0.0.0.0/0'}]"
  default = []
}