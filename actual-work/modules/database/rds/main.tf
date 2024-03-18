	module "rds_storage_cmk" {
  	source            = "../../../security/kms"
  	kms_alias         = var.kms_alias
  	delete_after_days = var.delete_after_days
  	key_description   = var.key_description
  	key_policy_map    = var.key_policy_map
  # need_cmk = (var.encryption_key_details.key_type == "customer_managed" ? true : false)
}
	resource "aws_db_instance" "default" {
		identifier  				= var.rds_instance_name
		db_name              		= var.db_name
		allocated_storage   	 	= var.allocated_storage
		engine              	 	= "mysql"
		engine_version      	 	= "5.7"
	  	instance_class       		= var.db_instance_class
	  	storage_encrypted 			= true
		kms_key_id 					= module.rds_storage_cmk.arn
	  	username             		= "dbadmin"
	  	password             		= "welcome$123"
	  	parameter_group_name 		= "default.mysql5.7"
	  	skip_final_snapshot  		= true
	  	availability_zone   		= "us-east-1a"
	    apply_immediately 		= true
	  	backup_retention_period 	= 1
	  	multi_az = true
		
		timeouts {
			create = var.terrform_operation_timeout
			delete = var.terrform_operation_timeout
			update = var.terrform_operation_timeout
  }
	  tags = var.tags

	}
