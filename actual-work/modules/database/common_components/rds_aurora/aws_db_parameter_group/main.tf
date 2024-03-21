resource "aws_db_option_group" "option_group_for_db" {
  name   = var.rds_option_group_name
  family = var.family
  description = var.description
  

  dynamic "parameter" {
    for_each = var.parameter_value
    content {
       name = parameter.value.name
       value = parameter.value.value
    }
  }
    tags = var.tags
}
