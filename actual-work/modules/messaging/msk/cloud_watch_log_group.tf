resource "aws_cloudwatch_log_group" "kms_log_group" {
  name              = "/aws/vendedlogs/kms/${var.cluster_name}/broker_logs"
  retention_in_days = var.cloud_watch_log_group_retention_days
  tags = var.tags
  
}