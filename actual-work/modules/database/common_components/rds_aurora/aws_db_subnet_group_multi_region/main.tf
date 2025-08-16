resource "random_string" "subnet_group_name_postfix" {
  length = local.random_string_subnet_group_name_postfix_length
  special = local.random_string_subnet_group_name_postfix_special
  numeric = local.random_string_subnet_group_name_postfix_numeric
  upper = local.random_string_subnet_group_name_postfix_upper
  lower = local.random_string_subnet_group_name_postfix_lower
}
resource "aws_db_subnet_group" "subnet_group_for_db" {
  name = "${var.subnet_group_name}-${random_string.subnet_group_name_postfix.result}"
  subnet_ids = var.subnet_group_subnet_ids
  tags = var.tags
  provider = aws.primary
  
  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "subnet_group_for_db_or" {
  name = "${var.subnet_group_name}-${random_string.subnet_group_name_postfix.result}"
  subnet_ids = var.subnet_group_subnet_ids_or
  tags = var.tags
  provider = aws.replica
  lifecycle {
      create_before_destroy = true
  }
}
