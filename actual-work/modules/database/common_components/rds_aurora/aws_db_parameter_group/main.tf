resource "aws_db_parameter_group" "parameter_group_for_db" {
  name   = var.rds_parameter_group_name
  family = var.parameter_group_db_family
  description = var.parameter_group_description
  

  dynamic "parameter" {
    for_each = var.parameter_value
    content {
       name = parameter.value.name
       value = parameter.value.value
    }
  }
    tags = var.tags
}
