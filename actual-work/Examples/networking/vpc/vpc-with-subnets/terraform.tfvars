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
#natgw_count        = 2
secondary_cidr_blocks = ["172.1.0.0/16", "172.2.0.0/16"]