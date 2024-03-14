output "dd_table_arn" {
  value = aws_dynamodb_table.dd_table_provisioned.arn
}

output "dd_table_stream_arn" {
  value = aws_dynamodb_table.dd_table_provisioned.stream_arn
}