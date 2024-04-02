## added provider here to create resources in dr region as well
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
resource "random_string" "option_group_name_postfix" {
  length = local.random_string_option_group_name_postfix_length
  special = local.random_string_option_group_name_postfix_special
  numeric = local.random_string_option_group_name_postfix_numeric
  upper = local.random_string_option_group_name_postfix_upper
  lower = local.random_string_option_group_name_postfix_lower
}

resource "aws_db_option_group" "option_group_for_db" {
  name                     = "${var.rds_option_group_name}-${random_string.option_group_name_postfix.result}"
  option_group_description = var.option_group_description
  engine_name              = var.option_group_engine_name
  major_engine_version     = var.option_group_major_engine_version
  dynamic "option" {
    for_each = var.option_settings
    content {
      option_name = option.value.option_name
      option_settings {
        name  = option.value.option_settings_name
        value = option.value.option_settings_value
    }
    #db_security_group_memberships = option.value.option_name == "MEMCACHED" ? option.value.db_security_group_memberships:null
    vpc_security_group_memberships  = option.value.option_name == "MEMCACHED" ? option.value.vpc_security_group_memberships:null


    }
  }
  tags = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

