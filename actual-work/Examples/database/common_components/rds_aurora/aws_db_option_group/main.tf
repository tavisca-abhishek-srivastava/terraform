module "nrt_rds_parameter_group" {
    source = "../../../../../modules/database/common_components/rds_aurora/aws_db_option_group"
    rds_option_group_name = var.rds_option_group_name
    engine_name = var.engine_name
    major_engine_version = var.major_engine_version
    option_group_description = var.option_group_description
    option_settings = var.option_settings
    tags = var.tags

    
}