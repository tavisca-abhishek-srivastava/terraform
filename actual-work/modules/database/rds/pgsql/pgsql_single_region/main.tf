resource "aws_rds_cluster" "name" {
    engine = "aurora-postgresql"
    availability_zones = ["us-east-1a","us-east-1b"]
    database_name = "nrt-ui"
    cluster_identifier = var.cluster_identifier
    master_username = "dbadmin"
    manage_master_user_password = "welcome$1234"
    db_cluster_instance_class = "db.r6gd.xlarge"
    storage_type              = "io1"
    allocated_storage         = 100
    iops                      = 1000
    tags = var.tags



}