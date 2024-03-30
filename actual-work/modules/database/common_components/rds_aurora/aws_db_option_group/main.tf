terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_db_option_group" "option_group_for_db" {
  name                     = var.rds_option_group_name
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
}

