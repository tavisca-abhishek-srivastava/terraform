module "nrt_rds_parameter_group" {
    source = "../../../../../modules/database/common_components/rds_aurora/aws_db_parameter_group"
    rds_parameter_group_name = var.rds_parameter_group_name
    family = var.family
    tags = var.tags
    parameter_value = var.parameter_value
    description = var.description

    
}