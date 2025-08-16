tags = {
    "AppName"            = "nrt-compliance-pgsql-cluster-nv"
    "Backup"             = "yes"
    "BusinessUnit"       = "travel.app"
    "DataClassification" = "internal"
    "Environment"        = "qa"
    "InfraOwner"         = "sre-cloud-reliability@tavisca.com"
    "Name"               = "nrt-compliance-pgsql-cluster-nv"
    "Product"            = "poap"
  }

### subnet group
subnet_group_name = "testing-subnet-group"
use_default_subnet_group = false
subnet_group_subnet_ids = ["subnet-081d38d112d9b87db","subnet-0a270dcfe55895f61","subnet-0a7393d9a81b5dd51"]
subnet_group_subnet_ids_or = ["subnet-0c1dac091a3c3129a","subnet-050b02e5f412e6ac4","subnet-027b75ea35a74119a"]
primary_region = "us-east-1"
replica_region = "us-west-2"