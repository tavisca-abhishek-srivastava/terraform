output "option_group_name_output" {
  value       = aws_db_option_group.option_group_for_db.id
}
output "my-string" {
  value = "var.rds_option_group_name-${random_string.option_group_name_postfix.result}"
}