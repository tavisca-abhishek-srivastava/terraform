resource "aws_rds_cluster" "name" {
    engine = "postgres"
    availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
    database_name = "nrt-ui"
    cluster_identifier = var.cluster_identifier
    master_username = "dbadmin"
    master_password = "welcome$1234"

    db_cluster_instance_class = "db.r6gd.xlarge"
    storage_type              = "io1"
    allocated_storage         = 100
    iops                      = 1000
    tags = {
    "AppName"            = "nrt-compliance"
    "Backup"             = "false"
    "BusinessUnit"       = "Travel.poc"
    "DataClassification" = "internal"
    "Environment"       = "poc"
    "InfraOwner"    = "sre-cloud-reliability@tavisca.com"
    "Name"          = "nrt-compliance"
    "Product"       = "poap"
    "Squad"         = "Travel.poc"
    "Restricted"    =   "yes"

  }



}