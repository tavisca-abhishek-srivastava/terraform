module "nrt_rds_parameter_group" {
    source = "../../common_components/rds_aurora/aws_db_parameter_group"
    rds_parameter_group_name = var.rds_parameter_group_name
    parameter_group_db_family = var.parameter_group_db_family
    tags = var.tags
    parameter_value = var.parameter_value
    parameter_group_description = var.parameter_group_description

    
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
  kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn
  storage_encrypted = true
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
  identifier            =   "nrt-aurora-cluster-poc-${each.value.name}"
  availability_zone     =   each.value.az
  cluster_identifier    =   aws_rds_cluster.postgresql.id
  instance_class        =   "db.t3.medium"
  engine                =   aws_rds_cluster.postgresql.engine
  engine_version        =   aws_rds_cluster.postgresql.engine_version
  db_subnet_group_name = "bnr-data-subnet-grp"
  db_parameter_group_name = module.nrt_rds_parameter_group.parameter_group_name
  promotion_tier = each.value.promotion_tier
  performance_insights_enabled = true
  performance_insights_kms_key_id = module.rds_encryption_at_rest_cmk.mrk_cms_arn
  performance_insights_retention_period = 7
  tags = var.tags
  lifecycle {
    	## if storage_type is gp3 and total storage is greater than 400 GB then iops must be greater than 12000
	precondition {
	  condition = ((var.storage_type == "gp3" && var.allocated_storage > 400) && var.storage_iops >=12000) ? true : ((var.storage_type == "gp3" && var.allocated_storage > 30) ? true : false)
	  error_message = "for disk type GP3 and allocated_storage >400, iops must be greater than 12000 "
	}
	precondition {
		# # if storage_type is io1 or io2 then iops must be greater than 1000
		condition = ((var.storage_type == "io1" || var.storage_type == "io2" ) && var.storage_iops >=1000) ? true : ( var.storage_type == "gp3" ? true : false)
		error_message = "for disk type io1/iops must be greater than 1000"
	}

	precondition {
	  # # if read replica is present then backup retention must be grater than 1
	  condition = ((length(var.instance_role) > 1) && (var.backup_retention_period > 0) ) ? true : (length(var.instance_role) == 1?true : false)
	  error_message = "if read replica is present then backup retention must be grater than 0"
	}
  }

  		timeouts{
			create = local.terrform_operation_timeout
			delete = local.terrform_operation_timeout
			update = local.terrform_operation_timeout
  					}
  
}