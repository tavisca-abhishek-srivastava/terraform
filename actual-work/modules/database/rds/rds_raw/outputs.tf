	output "rds_arn" {
	value = aws_db_instance.rds_instance.arn
	description = "ARN of primary instance"
	 }
	output "rds_read_only_replica_arn" {
	value = aws_db_instance.read-only-replica[*].arn
	description = "ARN of read only replica"
	 }
