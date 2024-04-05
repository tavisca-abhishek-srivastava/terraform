	module "rds_storage_cmk" {
  	source            = "../../../security/kms"
  	kms_alias         = "alias/${var.rds_instance_name}_key" #var.kms_alias change1
  	delete_after_days = var.kms_delete_after_days
  	key_description   =  "Key for ${var.rds_instance_name} RDS " #var.kms_key_description change2
  	key_policy_map    = var.key_policy_map
	kms_tags = var.tags #  change3
}

	module "rds_option_group" {
		source = "../../common_components/rds_aurora/aws_db_option_group/"
		# # if var.use_default_option_group == false then it will create new option group else will use default option group provided by user
		# for_each = (var.use_default_option_group == false) ? toset(["1"]):toset([])
			rds_option_group_name = "${var.rds_instance_name}-option-group" #var.rds_option_group_name  change4
			option_group_engine_name = var.rds_engine # change5
			option_group_major_engine_version = var.option_group_major_engine_version
			option_group_description = "option group for ${var.rds_instance_name} RDS "    # var.option_group_description change6
			option_settings = var.option_settings
			tags = var.tags
	}

	module "rds_parameter_group" {
	  source = "../../common_components/rds_aurora/aws_db_parameter_group/"
	  # if var.use_default_parameter_group == false then it will create new parameter group else will use default parameter group provided by user
	#   for_each = (var.use_default_parameter_group == false) ? toset(["1"]):toset([])
	  	parameter_group_description =  "parameter group for ${var.rds_instance_name} RDS "   #var.parameter_group_description change7
		parameter_value = var.parameter_value
		parameter_group_db_family = var.parameter_group_db_family
		rds_parameter_group_name =  "${var.rds_instance_name}-parameter-group"    #var.rds_parameter_group_name change8
		tags = var.tags
	}

	module "rds_subnet_group" {
	  source = "../../common_components/rds_aurora/aws_db_subnet_group/"
	  # if var.use_default_subnet_group == false then it will create new subnet group else will use default subnet group provided by user
	  for_each = (var.use_default_subnet_group == false) ? toset(["1"]):toset([])
	  subnet_group_name = "${var.rds_instance_name}-subnet-group"
	  subnet_ids = var.subnet_group_subnet_ids
	  tags = var.tags
	}

	resource "aws_db_instance" "rds_instance" {
		depends_on = [ module.rds_option_group,module.rds_parameter_group ,module.rds_subnet_group]
		identifier  				=   var.rds_instance_name
		## incase of PITR restore dbname must be null
		db_name              		= 	(var.restore_2_pitr ==true && var.rds_engine == "mysql") ? null:  var.db_name
		engine              	 	= 	var.rds_engine
		engine_version      	 	= 	var.rds_engine_version
	  	instance_class       		= 	var.db_instance_class
	  	storage_encrypted 			= 	local.enable_storage_encryption
		storage_type 				= 	var.storage_type
		allocated_storage   	 	= 	var.allocated_storage
		# if storage_type is gp3 and allocated storage is > 400 GB or storage type is io1 or io2 then iops must be specified else it will use default value
		iops 						=	((var.storage_type == "gp3" && var.allocated_storage > 400) || var.storage_type == "io1" || var.storage_type == "io2") ? var.storage_iops:null
		# if storage_type is gp3 and allocated storage is > 400 GB then throughput must be specified else it will use default value
		storage_throughput			=	(var.storage_type == "gp3" && var.allocated_storage > 400) ? var.storage_throughput:null
		# if autoscaling is true then max allocated storage will be specified or will be 0
		max_allocated_storage 		= 	(var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
		kms_key_id 					= 	module.rds_storage_cmk.mrk_cms_arn
	  	username             		= 	var.user_name
	  	password             		= 	var.password
	  	allow_major_version_upgrade = var.allow_major_version_upgrade
		apply_immediately 			= var.apply_immediately
		auto_minor_version_upgrade = var.auto_minor_version_upgrade
		# availability_zone will be specified only if multi_az is false
		availability_zone = var.multi_az == false ? var.availability_zone: null
		backup_retention_period 	= var.backup_retention_period
	  	multi_az = var.multi_az
		backup_window = var.backup_window
		### if use_default_subnet_group is true then user provided default/existing subnet will be used or else it will create new one
		db_subnet_group_name = var.use_default_subnet_group == true ? (var.rds_subnet_group_name) : module.rds_subnet_group["1"].subnet_group_name_output
		deletion_protection = var.deletion_protection
		license_model = var.license_model
		maintenance_window = var.maintenance_window
		monitoring_role_arn =var.monitoring_role_arn
		performance_insights_enabled = var.performance_insights_enabled
		### if performance_insights is enabled then only set this attribute
		performance_insights_kms_key_id = var.performance_insights_enabled == true? module.rds_storage_cmk.mrk_cms_arn:null
		performance_insights_retention_period = var.performance_insights_enabled == true? var.performance_insights_retention_period:null
		parameter_group_name =  module.rds_parameter_group.parameter_group_name      #var.use_default_parameter_group == true ? (var.rds_parameter_group_name) : module.rds_parameter_group["1"].parameter_group_name change10
		### if use_default_option_group is true then user provided default/existing option group will be used or else it will create new one
		option_group_name = module.rds_option_group.option_group_name_output   #var.use_default_option_group == true ? (var.rds_option_group_name) : module.rds_option_group["1"].option_group_name_output change9
		port = var.port
		### PITR option will work with latest 
		dynamic "restore_to_point_in_time" {
		  for_each = var.restore_2_pitr ==  false ? toset([]):toset(["1"])
		  content {
			source_db_instance_identifier = var.pitr_source_db_instance_identifier
			use_latest_restorable_time = var.use_latest_restorable_time
			restore_time = (var.use_latest_restorable_time ==false) ? var.restore_time:null
		  }
		}
		skip_final_snapshot  = var.skip_final_snapshot
		snapshot_identifier = null
		vpc_security_group_ids = var.vpc_security_group_ids

		timeouts {
			create = var.terrform_operation_timeout
			delete = var.terrform_operation_timeout
			update = var.terrform_operation_timeout
  }
  lifecycle {
	precondition {
		## length of variable 'az_for_read_replica' must be equal to 'number_of_read_replica'
	  	condition = length(var.az_for_read_replica) == var.number_of_read_replica ? true: false
	  	error_message = "number of az in list 'az_for_read_replica' must be equal to 'number_of_read_replica' "
	}
	precondition {
		## if storage_type is gp3 and total storage is greater than 400 GB then iops must be greater than 12000
	  	condition = (var.storage_type == "gp3" ? (var.allocated_storage > 400 ? (var.storage_iops >=12000 ? true :false ):true): true)
	  	error_message = "for disk type GP3 and allocated_storage >400, iops must be greater than 12000 "
	}
	precondition {
		# # if storage_type is io1 or io2 then iops must be greater than 1000
	  	condition = (var.storage_type == "io1" || var.storage_type == "io2" ? (var.storage_iops >=1000 ? true :false ):true)
	  	error_message = "for disk type io1 , iops must be greater than 1000"
	}
	precondition {
		# # if read replica is present then backup retention must be grater then 1
	  condition = var.number_of_read_replica > 0 ? (var.backup_retention_period > 0 ? true : false) : true
	  error_message = "backup retention should be greater than 0 incase of read replica available"
	}
	
  }
	  tags = var.tags
	}
