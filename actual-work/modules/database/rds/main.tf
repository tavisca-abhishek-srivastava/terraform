	module "rds_storage_cmk" {
  	source            = "../../security/kms"
  	kms_alias         = var.kms_alias
  	delete_after_days = var.delete_after_days
  	key_description   = var.key_description
  	key_policy_map    = var.key_policy_map
	kms_tags = var.kms_tags

}
	resource "aws_db_instance" "default" {
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
	  	parameter_group_name 		= "default.mysql5.7"
	  	skip_final_snapshot  		= true
	    apply_immediately 			= true
	  	backup_retention_period 	= 1
	  	multi_az = true
		
		timeouts {
			create = var.terrform_operation_timeout
			delete = var.terrform_operation_timeout
			update = var.terrform_operation_timeout
  }
  lifecycle {
	precondition {
	  condition = (var.storage_type == "gp3" && var.allocated_storage > 400) ? (var.storage_iops >=12000 ? true:false):((var.storage_type == "io1" || var.storage_type == "io2") ? (var.storage_iops >=1000):false)
	  error_message = "for disk type GP3 and allocated_storage >400, iops must be greater than 12000 "
	}
  }

	  tags = var.tags

	}
