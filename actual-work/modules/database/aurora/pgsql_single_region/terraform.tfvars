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

    },
        reader1 = {
        name = "reader-2",
        az = "us-east-1b"

    }
  }

aws_region = "us-east-1"
rds_parameter_group_name = "nrt-compliance-pgsql-cluster-pg"
parameter_group_db_family = "aurora-postgresql16"
parameter_group_description = "this is for nrt-compliance-pgsql-cluster"
parameter_value = {
  setting1 = {
    name = "log_min_duration_statement"
    value = 500},
  
}