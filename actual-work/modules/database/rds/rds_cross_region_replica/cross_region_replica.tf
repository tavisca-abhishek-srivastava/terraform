	module "rds_dr_option_group" {
		source = "../../common_components/rds_aurora/aws_db_option_group/"
		for_each = (var.use_default_option_group == false) ? toset(["1"]):toset([])
			rds_option_group_name = var.rds_option_group_name
			option_group_engine_name = var.option_group_engine_name
			option_group_major_engine_version = var.option_group_major_engine_version
			option_group_description = var.option_group_description
			option_settings = var.option_settings_dr
			tags = var.tags
       
      providers = {
        aws = aws.dr
      }

	}

	module "rds_dr_parameter_group" {
	  source = "../../common_components/rds_aurora/aws_db_parameter_group/"
	  for_each = (var.use_default_parameter_group == false) ? toset(["1"]):toset([])
	  parameter_group_description = var.parameter_group_description
		parameter_value = var.parameter_value
		parameter_group_db_family = var.parameter_group_db_family
		rds_parameter_group_name = var.rds_parameter_group_name
		tags = var.tags
     providers = {
        aws = aws.dr
      }

	}

data "aws_kms_key" "cmk_for_rds" {
  depends_on = [module.rds_storage_cmk]
   key_id = "${var.kms_alias}"
   provider = aws.dr
}

resource "aws_db_instance" "cross_region_read-only-replica" {
  depends_on = [ module.rds_dr_option_group,module.rds_dr_parameter_group ]
  count = var.number_of_cross_region_read_replica
  instance_class       = var.db_instance_class
  option_group_name = var.use_default_option_group == true ? (var.rds_option_group_name) : module.rds_dr_option_group["1"].option_group_name_output
  parameter_group_name = var.rds_parameter_group_name
  db_subnet_group_name = var.db_subnet_group
  skip_final_snapshot  = true
  availability_zone = var.az_for_cross_region_read_replica[count.index]
  identifier  = "jpmc-ro-${var.region_for_cross_region_read_replica}-${count.index}"
  apply_immediately = var.apply_immediately
  replicate_source_db  = aws_db_instance.rds_instance.arn
  storage_encrypted = true
  kms_key_id = module.rds_storage_cmk.replica_mrk_cms_arn #data.aws_kms_key.cmk_for_rds.arn
  max_allocated_storage = (var.enable_storage_autoscaling == true) ? var.max_allocated_storage:0
  tags = var.tags
  provider = aws.dr
}

