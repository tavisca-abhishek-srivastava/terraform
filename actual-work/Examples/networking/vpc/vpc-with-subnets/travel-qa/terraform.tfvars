subnet_variables = {
  web-subnets = {
    name       = "web-subnets"
    count      = 4
    cidr_block = "175.0.0.0/22"
    ipv4_routes =[]
  }
  data-subnets = {
    name       = "app-subnets"
    count      = 4
    cidr_block = "175.0.20.0/22"
    ipv4_routes = [
      #{
      # destination = "10.0.0.0/16"
      # target = {
      #   type = "TRANSIT_GATEWAY"
      # id   = "tgw-0b0632269db9da348"
      # }
      #},
    ]
  }
  app-subnets = {
    name       = "data-subnets"
    count      = 4
    cidr_block = "175.0.8.0/21"
    ipv4_routes =[]
  }
  mgmt-subnets = {
    name       = "mgmt-subnets"
    count      = 4
    cidr_block = "175.0.4.0/22"
    ipv4_routes =[]
  }
  public-subnets = {
    name       = "public-subnets"
    count      = 4
    cidr_block = "175.0.28.0/22"
    ipv4_routes =[]
  }
  secondary-range-subnets = {
    name       = "secondary-range-subnets"
    count      = 4
    cidr_block = "172.1.0.0/16"
    ipv4_routes =[]
  }
}

vpc_name           = "oski-stage"
vpc_cidr_block     = "175.0.0.0/19"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
region             = "us-east-1"
secondary_cidr_blocks = ["172.1.0.0/16"]
public_nacl_user = [
  {from_port : 1024, to_port : 65535,  rule_num : 103, cidr : "0.0.0.0/0"}
]
app_nacl_user = [
  {from_port : 1024, to_port : 65535,  rule_num : 103, cidr : "0.0.0.0/0"}
]
web_nacl_user = [
  {from_port : 1024, to_port : 65535,  rule_num : 103, cidr : "0.0.0.0/0"}
]
data_nacl_user = [
  {from_port : 1024, to_port : 65535,  rule_num : 103, cidr : "0.0.0.0/0"}
]
mgmt_nacl_user = [
  {from_port : 1024, to_port : 65535,  rule_num : 103, cidr : "0.0.0.0/0"}
]