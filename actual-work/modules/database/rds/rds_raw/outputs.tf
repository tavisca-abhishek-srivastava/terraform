	output "rds_arn" {
	value = aws_db_instance.rds_instance.arn
	description = "ARN of DB"
	 }
