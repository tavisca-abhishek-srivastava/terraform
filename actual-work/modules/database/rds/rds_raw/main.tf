	module "rds_storage_cmk" {
  	source            = "../../../security/kms"
  	kms_alias         = var.kms_alias
  	delete_after_days = var.delete_after_days
  	key_description   = var.key_description
  	key_policy_map    = var.key_policy_map
	kms_tags = var.kms_tags
}

	module "rds_option_group" {
		source = "../../common_components/rds_aurora/aws_db_option_group/"
		# for_each = (var.use_default_option_group == false) ? toset([]):toset(["1"])
			rds_option_group_name = var.rds_option_group_name
			option_group_engine_name = var.option_group_engine_name
			option_group_major_engine_version = var.option_group_major_engine_version
			option_group_description = var.option_group_description
			option_settings = var.option_settings
			tags = var.tags
	}
	resource "aws_db_instance" "rds_instance" {
		depends_on = [ module.rds_option_group ]
		identifier  				= 	var.rds_instance_name
		db_name              		= 	var.db_name
		engine              	 	= 	var.rds_engine
		engine_version      	 	= 	var.rds_engine_version
	  	instance_class       		= 	var.db_instance_class
	  	storage_encrypted 			= 	true
		storage_type 				= 	var.storage_type
		allocated_storage   	 	= 	var.allocated_storage
		iops 						=	((var.storage_type == "gp3" && var.allocated_storage > 400) || var.storage_type == "io1" || var.storage_type == "io2") ? var.storage_iops:null
		storage_throughput			=	(var.storage_type == "gp3" && var.allocated_storage > 400) ? var.storage_throughput:null
		max_allocated_storage 		= 	(var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
		kms_key_id 					= module.rds_storage_cmk.mrk_cms_arn
	  	username             		= "dbadmin"
	  	password             		= "welcome$123"
	  	allow_major_version_upgrade = var.allow_major_version_upgrade
		apply_immediately 			= var.apply_immediately
		auto_minor_version_upgrade = var.auto_minor_version_upgrade
		availability_zone = var.multi_az == false ? var.availability_zone: null
		backup_retention_period 	= var.backup_retention_period
	  	multi_az = var.multi_az
		backup_window = ""
		db_subnet_group_name = "cxl-rds-subnet-group"
		deletion_protection = var.deletion_protection
		license_model = var.license_model
		maintenance_window = ""
		monitoring_role_arn = ""
		performance_insights_enabled = var.performance_insights_enabled
		performance_insights_kms_key_id = var.performance_insights_enabled == true? module.rds_storage_cmk.mrk_cms_arn:null
		performance_insights_retention_period = var.performance_insights_enabled == true? var.performance_insights_retention_period:null
		parameter_group_name = "default.mysql5.7"
		option_group_name = var.use_default_option_group == true ? var.rds_option_group_name:var.rds_option_group_name
		port = var.port
		dynamic "restore_to_point_in_time" {
		  for_each = var.restore_2_pitr ==  false ? toset([]):toset(["1"])
		  content {
			
		  }
		}
		skip_final_snapshot  		= true
		snapshot_identifier = null
		vpc_security_group_ids = ["sg-006dad075fbfed8e7"]

		timeouts {
			create = var.terrform_operation_timeout
			delete = var.terrform_operation_timeout
			update = var.terrform_operation_timeout
  }
  lifecycle {
	precondition {
		# length of variable 'az_for_read_replica' must be equal to 'number_of_read_replica'
	  	condition = length(var.az_for_read_replica) == var.number_of_read_replica ? true: false
	  	error_message = "number of az in list 'az_for_read_replica' must be equal to 'number_of_read_replica' "
	}
	precondition {
		# if storage_type is gp3 and total storage is greater than 400 GB then iops must be greater than 12000
	  	condition = (var.storage_type == "gp3" ? (var.allocated_storage > 400 ? (var.storage_iops >=12000 ? true :false ):true): true)
	  	error_message = "for disk type GP3 and allocated_storage >400, iops must be greater than 12000 "
	}
	precondition {
		# # if storage_type is io1 or io2 then iops must be greater than 1000
	  	condition = (var.storage_type == "io1" || var.storage_type == "io2" ? (var.storage_iops >=1000 ? true :false ):true)
	  	error_message = "for disk type io1 , iops must be greater than 1000"
	}
	precondition {
	  condition = var.number_of_read_replica > 0 ? var.backup_retention_period > 0 : false
	  error_message = "backup retention should be greater than 0 incase of read replica available"
	}
	
  }
	  tags = var.tags
	}
