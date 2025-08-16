output "primary_region_subnet_name" {
  value = aws_db_subnet_group.subnet_group_for_db.name
}