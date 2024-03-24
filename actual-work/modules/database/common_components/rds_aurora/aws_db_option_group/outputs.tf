output "option_group_name_output" {
  value       = aws_db_option_group.option_group_for_db.arn
  description = "option group name"
}
