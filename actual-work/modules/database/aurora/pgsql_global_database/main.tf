module "nrt_rds_parameter_group" {
    source = "../../common_components/rds_aurora/aws_db_parameter_group"
    rds_parameter_group_name = var.rds_parameter_group_name
    parameter_group_db_family = var.parameter_group_db_family
    tags = var.tags
    parameter_value = var.parameter_value
    parameter_group_description = var.parameter_group_description

    
}

resource "aws_rds_global_cluster" "nrt_gdc" {
  provider = "aws.primary"

  global_cluster_identifier = "nrt-compliance-pgsql-global-cluster"
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "nrt_compliance"
  master_username         = "dbadmin"
  master_password         = "Welcome$1234"
  backup_retention_period = var.backup_retention_period
  #preferred_backup_window = "07:00-09:00"
  skip_final_snapshot = true
  apply_immediately = true
  kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn[1].arn
  storage_encrypted = true
  global_cluster_identifier = "${aws_rds_global_cluster.nrt_gdc.id}"

  db_subnet_group_name = "bnr-data-subnet-grp"
  tags = var.tags
  
  		timeouts{
			create = local.terrform_operation_timeout
			delete = local.terrform_operation_timeout
			update = local.terrform_operation_timeout
  					}

}

resource "aws_rds_cluster_instance" "cluster_instances" {
  for_each              =   var.instance_role
  identifier            =   "nrt-aurora-gd-cluster-poc-${each.value.name}"
  availability_zone     =   each.value.az
  cluster_identifier    =   aws_rds_cluster.postgresql.id
  instance_class        =   "db.t3.medium"
  engine                =   aws_rds_cluster.postgresql.engine
  engine_version        =   aws_rds_cluster.postgresql.engine_version
  db_subnet_group_name = "bnr-data-subnet-grp"
  db_parameter_group_name = module.nrt_rds_parameter_group.parameter_group_name
  promotion_tier = each.value.promotion_tier
  performance_insights_enabled = true
  performance_insights_kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn[1].arn #"arn:aws:kms:us-east-1:346319152574:key/mrk-4eca0415b8b4434f96399c2f2d80b1ef"
  performance_insights_retention_period = 7
  
  tags = var.tags
  lifecycle {
	precondition {
	  # # if read replica is present then backup retention must be grater than 1
	  condition = ((length(var.instance_role) > 1) && (var.backup_retention_period > 0) ) ? true : (length(var.instance_role) == 1 ? true : false)
	  error_message = "if read replica is present then backup retention must be grater than 0"
	}
  }

  		timeouts{
			create = local.terrform_operation_timeout
			delete = local.terrform_operation_timeout
			update = local.terrform_operation_timeout
  					}
  
}