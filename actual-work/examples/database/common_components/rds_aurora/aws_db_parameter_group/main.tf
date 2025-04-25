module "nrt_rds_parameter_group" {
    source = "../../../../../modules/database/common_components/rds_aurora/aws_db_parameter_group"
    rds_parameter_group_name = var.rds_parameter_group_name
    parameter_group_db_family = var.parameter_group_db_family
    tags = var.tags
    parameter_value = var.parameter_value
    parameter_group_description = var.parameter_group_description

    
}