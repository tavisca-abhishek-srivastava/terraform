output "mrk_cms_arn" {
value = aws_kms_key.encryption_key.arn
}

output "replica_mrk_cms_arn" {
value = [
    for x in aws_kms_replica_key.replica:
      x.arn
  ]
}
