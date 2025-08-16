resource "random_string" "parameter_group_name_postfix" {
  length = local.random_string_parameter_group_name_postfix_length
  special = local.random_string_parameter_group_name_postfix_special
  numeric = local.random_string_parameter_group_name_postfix_numeric
  upper = local.random_string_parameter_group_name_postfix_upper
  lower = local.random_string_parameter_group_name_postfix_lower
}

resource "aws_db_parameter_group" "parameter_group_for_db" {
  name   = "${var.rds_parameter_group_name}-${random_string.parameter_group_name_postfix.result}"
  family = var.parameter_group_db_family
  description = var.parameter_group_description
  provider = aws.primary
  

  dynamic "parameter" {
    for_each = var.parameter_value
    content {
       name = parameter.value.name
       value = parameter.value.value
    }
  }
    tags = var.tags
    lifecycle {
      create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "parameter_group_for_db_or" {
  name   = "${var.rds_parameter_group_name}-${random_string.parameter_group_name_postfix.result}"
  family = var.parameter_group_db_family
  description = var.parameter_group_description
  provider = aws.replica
  

  dynamic "parameter" {
    for_each = var.parameter_value
    content {
       name = parameter.value.name
       value = parameter.value.value
    }
  }
    tags = var.tags
    lifecycle {
      create_before_destroy = true
  }
}
