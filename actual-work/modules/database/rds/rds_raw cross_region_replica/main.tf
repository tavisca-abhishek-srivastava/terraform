	module "rds_storage_cmk" {
  	source            = "../../security/kms"
  	kms_alias         = var.kms_alias
  	delete_after_days = var.delete_after_days
  	key_description   = var.key_description
  	key_policy_map    = var.key_policy_map
	kms_tags = var.kms_tags

}
	resource "aws_db_instance" "rds_instance" {
		identifier  				= var.rds_instance_name
		db_name              		= var.db_name
		engine              	 	= var.rds_engine
		engine_version      	 	= var.rds_engine_version
	  	instance_class       		= var.db_instance_class
	  	storage_encrypted 			= true
		storage_type 				= var.storage_type
		allocated_storage   	 	= var.allocated_storage
		iops 						= ((var.storage_type == "gp3" && var.allocated_storage > 400) || var.storage_type == "io1" || var.storage_type == "io2") ? var.storage_iops:null
		max_allocated_storage 		= (var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
		kms_key_id 					= module.rds_storage_cmk.mrk_cms_arn
	  	username             		= "dbadmin"
	  	password             		= "welcome$123"
	  	skip_final_snapshot  		= true
	    allow_major_version_upgrade = var.allow_major_version_upgrade
		apply_immediately 			= var.apply_immediately
		auto_minor_version_upgrade = var.auto_minor_version_upgrade
		availability_zone = var.multi_az == false ? var.availability_zone: null
		backup_retention_period 	= var.backup_retention_period
	  	multi_az = var.multi_az
		backup_window = ""
		db_subnet_group_name = ""
		deletion_protection = false
		license_model = ""
		maintenance_window = ""
		monitoring_role_arn = ""
		option_group_name = ""
		performance_insights_enabled = false
		performance_insights_kms_key_id = module.rds_storage_cmk.mrk_cms_arn
		performance_insights_retention_period = 7
		parameter_group_name 		= "default.mysql5.7"
		port = 3306
		restore_to_point_in_time {
		  
		}
		
		timeouts {
			create = var.terrform_operation_timeout
			delete = var.terrform_operation_timeout
			update = var.terrform_operation_timeout
  }
  lifecycle {
	precondition {
	  #condition = (var.storage_type == "gp3" && var.allocated_storage >= 400) ? (var.storage_iops >=12000 ? true:false):((var.storage_type == "io1" || var.storage_type == "io2") ? (var.storage_iops >=1000):false)
	  condition = (var.storage_type == "gp3" ? (var.allocated_storage > 400 ? (var.storage_iops >=12000 ? true :false ):true): true)
	  error_message = "for disk type GP3 and allocated_storage >400, iops must be greater than 12000 "
	}
	precondition {
	  condition = (var.storage_type == "io1" || var.storage_type == "io2" ? (var.storage_iops >=1000 ? true :false ):true)
	  error_message = "for disk type io1 , iops must be greater than 1000"
	}
  }

	  tags = var.tags

	}
