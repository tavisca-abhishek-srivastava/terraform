	output "rds_arn" {
	value = aws_db_instance.rds_instance.arn
	description = "ARN of DB"
	 }
	 output "name_of_option_group" {
		value = module.rds_option_group.option_group_name_output.id
	 }
