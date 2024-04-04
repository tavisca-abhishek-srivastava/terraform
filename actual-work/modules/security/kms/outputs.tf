output "mrk_cms_arn" {
value = aws_kms_key.dynamodb_encryption_key.arn
}

output "replica_mrk_cms_arn" {
# value = aws_kms_replica_key.replica[*].arn
value = [
    for x in aws_kms_replica_key.replica:
      x.arn
  ]
}
