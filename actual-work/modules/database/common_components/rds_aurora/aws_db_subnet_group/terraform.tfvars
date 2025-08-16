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
subnet_ids = ["subnet-081d38d112d9b87db","subnet-0a270dcfe55895f61","subnet-0a7393d9a81b5dd51"]