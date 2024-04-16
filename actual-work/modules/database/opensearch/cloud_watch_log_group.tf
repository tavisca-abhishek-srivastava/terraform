resource "aws_cloudwatch_log_group" "opensearch_log_group_index_slow_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/index-slow"
  retention_in_days = var.cloud_watch_log_group_retention_days
  tags = var.tags
  
}


resource "aws_cloudwatch_log_group" "opensearch_log_group_search_slow_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/search-slow"
  retention_in_days = var.cloud_watch_log_group_retention_days
  tags = var.tags
  
}


resource "aws_cloudwatch_log_group" "opensearch_log_group_es_application_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/es-application"
  retention_in_days = var.cloud_watch_log_group_retention_days
  tags = var.tags
  
}