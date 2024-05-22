output "opensearch_dashboard_endpoint" {
  value = aws_opensearch_domain.opensearch.dashboard_endpoint
}
output "opensearch_domain_endpoint" {
  value = aws_opensearch_domain.opensearch.endpoint
}
# output "opensearch_kibana_endpoint" {
#   value = aws_opensearch_domain.opensearch.kibana_endpoint
# }