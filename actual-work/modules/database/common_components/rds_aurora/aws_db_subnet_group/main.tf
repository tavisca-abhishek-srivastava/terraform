## added provider here to create resources in dr region as well
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "random_string" "subnet_group_name_postfix" {
  length = local.random_string_subnet_group_name_postfix_length
  special = local.random_string_subnet_group_name_postfix_special
  numeric = local.random_string_subnet_group_name_postfix_numeric
  upper = local.random_string_subnet_group_name_postfix_upper
  lower = local.random_string_subnet_group_name_postfix_lower
}
resource "aws_db_subnet_group" "subnet_group_for_db" {
  name = "${var.subnet_group_name}-${random_string.subnet_group_name_postfix.result}"
  subnet_ids = var.subnet_ids
  tags = var.tags
  lifecycle {
      create_before_destroy = true
  }
}

