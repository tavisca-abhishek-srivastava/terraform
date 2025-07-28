tags = {
    "AppName"            = "nrt-compliance-pgsql-cluster"
    "Backup"             = "yes"
    "BusinessUnit"       = "travel.app"
    "DataClassification" = "internal"
    "Environment"        = "qa"
    "InfraOwner"         = "sre-cloud-reliability@tavisca.com"
    "Name"               = "nrt-compliance-pgsql-cluster"
    "Product"            = "poap"
  }
  instance_type = {
    writer = {
      name = "writer",
      az = "us-east-1a"
    },
    reader = {
        name = "reader-1",
        az = "us-east-1b"

    }
  }