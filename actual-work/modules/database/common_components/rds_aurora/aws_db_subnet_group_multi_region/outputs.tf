output "subnet_group_name_output" {
  value       = aws_db_subnet_group.subnet_group_for_db.name
}

output "subnet_group_or_name_output" {
  value       = aws_db_subnet_group.subnet_group_for_db_or.name
}