module "nrt_rds_parameter_group" {
    source = "../../common_components/rds_aurora/aws_db_parameter_group"
    rds_parameter_group_name = var.rds_parameter_group_name
    parameter_group_db_family = var.parameter_group_db_family
    tags = var.tags
    parameter_value = var.parameter_value
    parameter_group_description = var.parameter_group_description

    
}

resource "aws_rds_cluster" "mysql" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-mysql"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "mydb"
  master_username         = "dbadmin"
  master_password         = "Welcome$1234"
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn
  storage_encrypted = true
  db_subnet_group_name = "bnr-data-subnet-grp"
  tags = var.tags
  

}

resource "aws_rds_cluster_instance" "cluster_instances" {
  for_each              =   var.instance_type
  identifier            =   "nrt-aurora-mysql-cluster-poc-${each.value.name}"
  availability_zone     =   each.value.az
  cluster_identifier    =   aws_rds_cluster.mysql.id
  instance_class        =   "db.r8g.large"
  engine                =   aws_rds_cluster.mysql.engine
  engine_version        =   aws_rds_cluster.mysql.engine_version
  db_subnet_group_name = "bnr-data-subnet-grp"
  db_parameter_group_name = module.nrt_rds_parameter_group.parameter_group_name
  promotion_tier = each.value.promotion_tier
  performance_insights_enabled = true
  performance_insights_kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn
  performance_insights_retention_period = 7
  tags = var.tags
  
}