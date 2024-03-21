resource "aws_db_option_group" "option_group_for_db" {
  name                     = var.rds_option_group_name
  option_group_description = var.option_group_description
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version
  dynamic "option" {
    for_each = var.option_settings
    content {
      option_name = option.value.option_name
      option_settings {
        name  = option.value.option_settings_name
        value = option.value.option_settings_value
      }
    }
  }



  tags = var.tags
}
